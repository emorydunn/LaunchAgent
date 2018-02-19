//
//  StartCalendarIntervalTests.swift
//  LaunchAgentTests
//
//  Created by Emory Dunn on 2018-02-19.
//

import XCTest
import LaunchAgent

class StartCalendarIntervalTests: XCTestCase {

    func testInit() {
        let interval = StartCalendarInterval()
        
        XCTAssertNil(interval.day)
        XCTAssertNil(interval.hour)
        XCTAssertNil(interval.minute)
        XCTAssertNil(interval.month)
        XCTAssertNil(interval.weekday)
    }
    
}
