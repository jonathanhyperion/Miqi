//
//  ApplicationsDataStorage.swift
//  Miqi
//
//  Created by Elena Gordienko on 26.03.2022.
//

import Foundation

final class StatsStorage {
    
    static let shared = StatsStorage()
    private let storage = UserDefaults(suiteName: Constants.appGroup)
    
    // MARK: - Init/Deinit
    
    private init() { }
    
    // MARK: - Operations
    
    /// Gets the stats from a specific date string key (DDMMYYY) from User Defaults
    func getStats(
        for application: Application,
        on date: String
    ) -> AppStats? {
        
        let key = "\(date)-\(application.name)"
        let statsDict = storage?.dictionary(forKey: key)
        
        print("\nGET STATS", statsDict)
       
        return statsDict?.data?.decode()
    }
    
    /// Saves the stats in a specific date string key (DDMMYYYY) in User Defaults
    func saveStats(
        _ appStats: AppStats,
        for application: Application,
        on date: String
    ) {
        
        let key = "\(date)-\(application.name)"
        var statsDict = storage?.dictionary(forKey: key)
        statsDict = appStats.asDictionary()
        
        storage?.set(statsDict, forKey: key)
        storage?.synchronize() // Ensures the data is written to disk immediately. Avoids bugs when using extensions
        print("\nSAVE STATS", statsDict)
    }

}
