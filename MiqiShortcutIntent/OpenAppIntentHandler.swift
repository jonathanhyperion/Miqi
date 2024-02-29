//
//  OpenAppHandler.swift
//  MiqiShortcutIntent
//
//  Created by Elena Gordienko on 07.04.2022.
//

import Foundation
import Intents

final class OpenAppIntentHandler: NSObject, OpenAppIntentHandling {
    
    /// This method should not perform any computations.
    /// It should return as soon as possible, otherwise the intent would fail.
    /// All the work should be done while processing corresponding user activities.
    @objc(handleOpenApp:completion:)
    func handle(
        intent: OpenAppIntent,
        completion: @escaping (OpenAppIntentResponse) -> Void
    ) {
        
        let currentTimeInterval = Date().timeIntervalSince1970
        
        if AppOpeningGuardService.shared.shouldAllowOpening(intent.applicationName, at: currentTimeInterval) {
            
            // Opens the other app
            
            DispatchQueue.global(qos: .userInitiated).async {

                let _ = AppService.shared.addAttempt(
                    type: .openApp,
                    for: intent.applicationName,
                    from: .intent,
                    on: currentTimeInterval
                )
                
                print("CALLING AppService.shared.addAttempt from OpenAppIntent at: ", currentTimeInterval)
            }
            
            completion(OpenAppIntentResponse(code: .success, userActivity: nil))
            
            return
        }
        
        // Opens this app
        
        let userActivity = NSUserActivity(activityType: Constants.openAppUserActivity)
        userActivity.userInfo = [
            Constants.openAppUserInfoKey: intent.applicationName.rawValue,
            Constants.openAppTimeIntervalKey: currentTimeInterval
        ]
        
        completion(OpenAppIntentResponse(code: .continueInApp, userActivity: userActivity))
    }
}
