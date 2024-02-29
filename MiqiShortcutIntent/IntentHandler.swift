//
//  IntentHandler.swift
//  MiqiShortcutIntent
//
//  Created by Elena Gordienko on 26.03.2022.
//

import Intents

final class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        
        switch intent {
        case is OpenAppIntent: return OpenAppIntentHandler()
        case is CloseAppIntent: return CloseAppIntentHandler()
        default: fatalError("Unknown intent type: \(intent)")
        }
    }
}
