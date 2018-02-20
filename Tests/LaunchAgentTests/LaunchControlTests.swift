//
//  LaunchControlTests.swift
//  LaunchAgentTests
//
//  Created by Emory Dunn on 2018-02-19.
//

import XCTest
@testable import LaunchAgent

class LaunchControlTests: XCTestCase {

    func testWrite() {
        let agent = LaunchAgent(label: "TestAgent")
        
        XCTAssertNoThrow(try LaunchControl.shared.write(agent, called: "TestAgent.plist"))

    }
    
    func testRead() {
        XCTAssertNoThrow(try LaunchControl.shared.read(agent: "TestAgent.plist"))
    }
    
    func testSetURL() {
        let agent = LaunchAgent(label: "TestAgent")
        
        XCTAssertNoThrow(try LaunchControl.shared.write(agent, called: "TestAgent.plist"))
        agent.url = nil
        
        XCTAssertNil(agent.url)
        
        XCTAssertNoThrow(try LaunchControl.shared.setURL(for: agent))
        
        XCTAssertNotNil(agent.url)
        
    }
    
}
