//
//  CloseAppIntentHandler.swift
//  MiqiShortcutIntent
//
//  Created by Elena Gordienko on 07.04.2022.
//

import Foundation
import Intents

final class CloseAppIntentHandler: NSObject, CloseAppIntentHandling {
    
    /// This method should not perform any computations.
    /// It should return as soon as possible, otherwise the intent would fail.
    /// All the work should be done while processing corresponding user activities.
    @objc(handleCloseApp:completion:)
    func handle(
        intent: CloseAppIntent,
        completion: @escaping (CloseAppIntentResponse) -> Void
    ) {
        let currentTimeInterval = Date().timeIntervalSince1970
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let _ = AppService.shared.addAttempt(
                type: .close,
                for: intent.applicationName,
                from: .intent,
                on: currentTimeInterval
            )
            
            print("CALLING AppService.shared.addAttempt from CloseAppIntent at: ", currentTimeInterval)
        }
        
        completion(CloseAppIntentResponse(code: .success, userActivity: nil))
    }
}

