//
//  AppServiceTests.swift
//  MiqiTests
//
//  Created by Jonathan Solorzano on 2/5/22.
//

import Foundation

import XCTest
@testable import Miqi

class AppServiceAddAttemptTests: XCTestCase {
    
    var sut: AppService!
    var storage: UserDefaults!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = AppService.shared
        storage = UserDefaults(suiteName: Constants.appGroup)
        UserDefaults.resetDefaults(suiteName: Constants.appGroup)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        storage = nil
    }

    // TESTS - addAttempt()
    
    // 1. No previous attemps for today on a social app should:
    // -- Create a new key for today
    // -- Store the attempt in array: Only 1 attempt at the end
    func test_addAttempt_noPreviousAttempts() throws {
        
        let nowTimeInterval = Date().timeIntervalSince1970
        let app: Application = .tiktok
        let dictKey = "\(nowTimeInterval.dateDDMMYYYY)-\(app.name)"
        
        let appStats = sut.addAttempt(
            type: .openIntercepted,
            for: .tiktok,
            from: .intent,
            on: nowTimeInterval
        )
        
        guard let dict = storage.dictionary(forKey: dictKey)
        else { return XCTFail("There's no dictionary stored for key: \(dictKey)") }
        
        guard let savedAppStats: AppStats = dict.data?.decode()
        else { return XCTFail("AppStats were not stored correctly") }
        
        XCTAssertEqual(savedAppStats.attempts.count, 1, "The amount of attempts should be 1")
        XCTAssertEqual(appStats.attempts.count, 1, "The amount of attempts should be 1")
    }
    
    // 2. Close attempt having previous open attempts should:
    // -- Append attempt to existing array: Increase 1 count
    // -- Recalculate the time spent: Define a known calculation value
    // 3. Close attempt having multiple open-close attempts previously registered and a totalTimeSpent > 0
    // -- Append attempt to existing array: Increase 1 count
    // -- Recalculate the time spent: Define a known calculation value
    // 4. Open attempt on new day having previous day records should:
    // -- Create new key (date+appName) in storage
    // -- Record attempt
    
}
