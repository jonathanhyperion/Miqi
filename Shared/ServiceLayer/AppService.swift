//
//  AttemptsCounter.swift
//  Miqi
//
//  Created by Jonathan Solorzano on 2.05.2022.
//

import Foundation

final class AppService {
    
    static let shared = AppService()
    
    // MARK: - Init/Deinit
    
    private init() { }
    
    // MARK: - Services
    
    /// Wraps get stats frunction from storage
    func getStats(
        for app: Application,
        on date: String
    ) -> AppStats? {
        return StatsStorage.shared.getStats(
            for: app,
            on: date
        )
    }
    
    /// Adds the attempt type to the app stats. Also, calculates & saves the new time spent
    func addAttempt(
        type: AttemptType,
        for app: Application,
        from: AttemptSource,
        on timeInterval: TimeInterval
    ) -> AppStats {
        
        var appStats = StatsStorage.shared.getStats(
            for: app,
            on: timeInterval.dateDDMMYYYY
        ) ?? .init(app: app)
        
        appStats.attempts.append(.init(
            type: type,
            timeInterval: timeInterval,
            from: from
        ))
        appStats.totalTimeSpent = timeSpent(attemtps: appStats.attempts)
        
        StatsStorage.shared.saveStats(
            appStats,
            for: app,
            on: timeInterval.dateDDMMYYYY
        )
        
        return appStats
    }
    
    /// Iterate the list and identify the next open and next close and sum the distances
    func timeSpent(attemtps: [Attempt]) -> TimeInterval {
        
        var totalTimeSpent: TimeInterval = 0
        var currentOpen: TimeInterval? = nil
        
        for attemtp in attemtps.sorted(by: { $0.timeInterval < $1.timeInterval}) {
            
            switch attemtp.type {
            case .openApp: currentOpen = attemtp.timeInterval
            case .close:
                
                if let open = currentOpen {
                    // Sum the distance between open and close to total time spent
                    totalTimeSpent += open.distance(to: attemtp.timeInterval).abs
                    // Reset current open for next open-to-close time intervals
                    currentOpen = nil
                }
                
            default: break
            }
        }
        
        return totalTimeSpent
    }
    
}
