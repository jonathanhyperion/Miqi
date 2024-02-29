//
//  AppServiceTimeSpentTests.swift
//  MiqiTests
//
//  Created by Jonathan Solorzano on 3/5/22.
//

import Foundation


import XCTest
@testable import Miqi

class AppServiceTimeSpentTests: XCTestCase {
    
    var sut: AppService!
    var storage: UserDefaults!
    
    let times05042022: [String: TimeInterval] = [
        "5am": 1651662000,
        "6am": 1651665600,
        "7am": 1651669200,
        "8am": 1651672800,
        "9am": 1651676400,
        "10am": 1651680000
    ]

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

    
    // TESTS - timeSpent()
    
    // 1. No close attempts, only open attempts, should:
    // -- Return 0
    func test_timeSpent_onlyOpenAttempts() throws {
        
        let now = Date().timeIntervalSince1970
        
        let attempts: [Attempt] = [
            .init(type: .openIntercepted, timeInterval: now, from: .miqui),
            .init(type: .openApp, timeInterval: now + 1000, from: .miqui),
            .init(type: .openApp, timeInterval: now + 2000, from: .miqui),
            .init(type: .openApp, timeInterval: now + 3000, from: .miqui)
        ]
            
        let timeSpent = sut.timeSpent(attemtps: attempts)
        
        XCTAssertEqual(timeSpent, 0, "Time spent should be 0, there's no close attempt")
    }
    
    // 2. Multiple open attempts before close attempt, should:
    // -- Only calculate time based on last open attempt and the next close
    func test_timeSpent_multipleOpensBeforeClose() throws {
        
        let attempts: [Attempt] = [
            .init(type: .openIntercepted, timeInterval: times05042022["5am"]!, from: .miqui),
            .init(type: .openApp, timeInterval: times05042022["6am"]!, from: .miqui),
            .init(type: .openIntercepted, timeInterval: times05042022["7am"]!, from: .miqui),
            .init(type: .openApp, timeInterval: times05042022["8am"]!, from: .miqui),
            .init(type: .close, timeInterval: times05042022["9am"]!, from: .miqui)
        ]
        
        let timeSpent = sut.timeSpent(attemtps: attempts)
        
        XCTAssertEqual(timeSpent, 3600, "The difference should be 1h (3600s)")
    }
    
    // 3. Multiple open-close attempts should:
    // -- Sum multiple intervals and give a positive value: Define the intervals and the expected value.
    func test_timeSpent_multipleOpenClose() throws {
        
        let attempts: [Attempt] = [
            .init(type: .openApp, timeInterval: times05042022["5am"]!, from: .miqui),// open 1
            .init(type: .close, timeInterval: times05042022["6am"]!, from: .miqui),// close 1
            .init(type: .openIntercepted, timeInterval: times05042022["7am"]!, from: .miqui),
            .init(type: .openApp, timeInterval: times05042022["8am"]!, from: .miqui),//open 2
            .init(type: .close, timeInterval: times05042022["9am"]!, from: .miqui)//close 2
        ]
        
        let timeSpent = sut.timeSpent(attemtps: attempts)
        
        XCTAssertEqual(timeSpent, 3600*2, "The two time slots should be 2h (3600s)")
    }
    
    // 4. Multiple close attempts before open attempt should:
    // -- Return 0
    func test_timeSpent_multipleCloseBeforeClose() throws {
        
        let attempts: [Attempt] = [
            .init(type: .close, timeInterval: times05042022["5am"]!, from: .miqui),
            .init(type: .close, timeInterval: times05042022["6am"]!, from: .miqui),
            .init(type: .openApp, timeInterval: times05042022["8am"]!, from: .miqui),
        ]
        
        let timeSpent = sut.timeSpent(attemtps: attempts)
        
        XCTAssertEqual(timeSpent, 0, "No close after open should return 0s as time spent ")
    }
    
    // 5. Multiple close attempts before open attempt, then add multiple close attempts, should:
    // -- Calculate the time based on the open attempt and next close
    func test_timeSpent_multipleCloseThenOpenThenCloses() throws {
        
        let attempts: [Attempt] = [
            .init(type: .close, timeInterval: times05042022["5am"]!, from: .miqui),
            .init(type: .close, timeInterval: times05042022["6am"]!, from: .miqui),
            .init(type: .openApp, timeInterval: times05042022["7am"]!, from: .miqui),
            .init(type: .close, timeInterval: times05042022["8am"]!, from: .miqui),
            .init(type: .close, timeInterval: times05042022["9am"]!, from: .miqui),
        ]
        
        let timeSpent = sut.timeSpent(attemtps: attempts)
        
        XCTAssertEqual(timeSpent, 3600, "The difference should be 1h (3600s)")
    }
    
    // 6. Multiple disordered open-close attempts should:
    // -- Be sorted before calculating
    // -- Give the right result no matter the order
    func test_timeSpent_disorderedOpenCloseAttempts() throws {
        
        let attempts: [Attempt] = [
            .init(type: .close, timeInterval: times05042022["10am"]!, from: .miqui), // close 2
            .init(type: .openApp, timeInterval: times05042022["5am"]!, from: .miqui), // open 1
            .init(type: .openApp, timeInterval: times05042022["9am"]!, from: .miqui), // open 2
            .init(type: .close, timeInterval: times05042022["6am"]!, from: .miqui), // close 1
            .init(type: .openIntercepted, timeInterval: times05042022["8am"]!, from: .miqui),
            .init(type: .close, timeInterval: times05042022["7am"]!, from: .miqui)
        ]
        
        let timeSpent = sut.timeSpent(attemtps: attempts)
        
        XCTAssertEqual(timeSpent, 3600*2, "Time should be 2h (7200s)")
    }
    
}
