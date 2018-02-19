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
    
    func testDayRange() {
        let interval = StartCalendarInterval()
        
        // Test minimum value
        interval.day = 1
        XCTAssertEqual(interval.day, 1)
        
        // Test maximum value
        interval.day = 31
        XCTAssertEqual(interval.day, 31)
        
        // Test less than minimum value
        interval.day = 0
        XCTAssertEqual(interval.day, 1)
        
        // Test greater than maximum value
        interval.day = 32
        XCTAssertEqual(interval.day, 31)
    }
    
    func testHourRange() {
        let interval = StartCalendarInterval()
        
        // Test minimum value
        interval.hour = 0
        XCTAssertEqual(interval.hour, 0)
        
        // Test maximum value
        interval.hour = 23
        XCTAssertEqual(interval.hour, 23)
        
        // Test less than minimum value
        interval.hour = -1
        XCTAssertEqual(interval.hour, 0)
        
        // Test greater than maximum value
        interval.hour = 24
        XCTAssertEqual(interval.hour, 23)
    }
    
    func testMinuteRange() {
        let interval = StartCalendarInterval()
        
        // Test minimum value
        interval.minute = 0
        XCTAssertEqual(interval.minute, 0)
        
        // Test maximum value
        interval.minute = 59
        XCTAssertEqual(interval.minute, 59)
        
        // Test less than minimum value
        interval.minute = -1
        XCTAssertEqual(interval.minute, 0)
        
        // Test greater than maximum value
        interval.minute = 60
        XCTAssertEqual(interval.minute, 59)
    }
    
}
