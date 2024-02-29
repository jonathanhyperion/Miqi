//
//  AppOpeningGuardService.swift
//  Miqi
//
//  Created by Elena Gordienko on 27.03.2022.
//

import Foundation

final class AppOpeningGuardService {
    
    static let shared: AppOpeningGuardService = .init()
    
    private init() { }
    
    /// Decides whether to allow user to open the `application`
    /// - parameters:
    /// - application: the application user tries to open
    /// - returns:
    /// whether user can open the app without triggering breathing exercise
    func shouldAllowOpening(
        _ application: Application,
        at currentTimeInterval: TimeInterval
    ) -> Bool {
        
        guard let appStats = AppService.shared.getStats(
            for: application,
            on: currentTimeInterval.dateDDMMYYYY
        ) else { return false }
        
        let closes = appStats.attempts.filter({ $0.type == .close})
        
        guard
            // if distanceBetweenLastCloseAndNow is nil, this is either the very first opening for this app after configuring the automation,
            // or the situation when first closing automation haven't finish yet,
            // or an incosistent state
            let distanceBetweenLastCloseAndNow = closes.last?.timeInterval.distance(to: currentTimeInterval).abs,
            // if this app was closed and then reopened more than after a minute, it is considered as a new open attempt
            // (another session)
            distanceBetweenLastCloseAndNow < Constants.secsBeforeNewSession
        else {
            // this checks for the situation when close intent wasn't triggered fast enough to add a close attempt
            let backs = appStats.attempts.filter({ $0.type == .backToApp})
            
            if let secsAfterLastGoBack = backs.last?.timeInterval.distance(to: currentTimeInterval).abs,
               // check whether user chose to proceed within 3 seconds from current date
                secsAfterLastGoBack < Constants.secsBetweenNewOpenAndLastGoBack {
                print("Validation 2 TRUE: secsAfterLastGoBack \(secsAfterLastGoBack) < \(Constants.secsBetweenNewOpenAndLastGoBack)" )
                return true
            }
            
            print("Validation 1 FALSE: distanceBetweenLastCloseAndNow < \(Constants.secsBeforeNewSession)" )
            
            return false
        }
        
        print("Validation 1 TRUE: distanceBetweenLastCloseAndNow \(distanceBetweenLastCloseAndNow) < \(Constants.secsBeforeNewSession)" )
        
        return true
    }
    
}
