//
//  ApplicationData.swift
//  Miqi
//
//  Created by Elena Gordienko on 26.03.2022.
//

import Foundation

extension Application: Codable & Hashable { }

public enum AttemptType: Codable {
    case openApp, openIntercepted, close, backToApp
}

public enum AttemptSource: Codable {
    case intent, miqui
}

public struct Attempt: Codable {
    
    let type: AttemptType
    let timeInterval: TimeInterval
    let from: AttemptSource
    
    public init(
        type: AttemptType,
        timeInterval: TimeInterval,
        from: AttemptSource
    ) {
        self.type = type
        self.timeInterval = timeInterval
        self.from = from
    }
}

public struct AppStats: Codable {
    
    var app: Application
    var attempts: [Attempt]
    var lastCloseTimeInterval: TimeInterval?
    var lastGoBackToAppTimeInterval: TimeInterval?
    var totalTimeSpent: TimeInterval

    public init(
        app: Application,
        attempts: [Attempt] = [],
        lastClose: TimeInterval? = nil,
        lastGoBackToApp: TimeInterval? = nil,
        totalTimeSpent: TimeInterval = 0
    )  {
        self.app = app
        self.attempts = attempts
        self.lastCloseTimeInterval = lastClose
        self.lastGoBackToAppTimeInterval = lastGoBackToApp
        self.totalTimeSpent = totalTimeSpent
    }
    
    func openAttempts() -> Int {
//        let opensCount = opens.count
//        // open intent handler is called whenever the target app becomes active
//        // so the same attempt is counted twice whenever the breathing exercise is triggered
//        return opensCount / 2 + opensCount % 1
        
        return attempts.filter({ $0.type == .openApp || $0.type == .backToApp }).count
    }
}
