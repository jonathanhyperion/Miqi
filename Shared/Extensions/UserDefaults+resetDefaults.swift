//
//  UserDefaults+resetDefaults.swift
//  Miqi
//
//  Created by Jonathan Solorzano on 3/5/22.
//

import Foundation

extension UserDefaults {
    static func resetDefaults(suiteName: String? = nil) {
        
        guard let bundleID = Bundle.main.bundleIdentifier
        else { return }
        
        if let suiteName = suiteName {
            UserDefaults(suiteName: suiteName)?.removePersistentDomain(forName: bundleID)
        } else {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}
