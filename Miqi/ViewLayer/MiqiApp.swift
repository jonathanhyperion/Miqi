//
//  MiqiApp.swift
//  Miqi
//
//  Created by Elena Gordienko on 26.03.2022.
//

import Intents
import SwiftUI

@main
struct MiqiApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    @State private var showingPopupView = false
    @State private var currentAppStats: AppStats? = nil
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            .fullScreenCover(isPresented: $showingPopupView) {
                PopupView(appStats: currentAppStats ?? .init(app: .unknown))
            }.userActivity(Constants.openAppUserActivity) { userActivity in
                userActivity.isEligibleForSearch = false
            }
            .onContinueUserActivity(Constants.openAppUserActivity) { userActivity in
                showingPopupView = true
                processOpeningAppActivity(userInfo: userActivity.userInfo)
            }.onChange(of: scenePhase) { newScenePhase in
                processScenePhaseChange(to: newScenePhase)
            }
        }
    }
    
    private func processScenePhaseChange(to phase: ScenePhase) {
        switch phase {
        case .active, .background:
            break
        case .inactive:
            showingPopupView = false
        @unknown default:
            break
        }
    }
    
    private func processOpeningAppActivity(userInfo: [AnyHashable : Any]?) {
        
        guard
            let userInfo = userInfo as? [String: Any],
            let appIdentifier = userInfo[Constants.openAppUserInfoKey] as? Int,
            let openTimeInteral = userInfo[Constants.openAppTimeIntervalKey] as? TimeInterval,
            let app = Application(rawValue: appIdentifier)
        else {
            print("OpenApp failed: no user info provided")
            return
        }
        
        currentAppStats = AppService.shared.addAttempt(
            type: .openIntercepted,
            for: app,
            from: .miqui,
            on: openTimeInteral
        )
    }
}
