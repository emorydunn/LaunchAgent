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
    
    let agent = LaunchAgent(label: "TestAgent.PythonServer", program: "python", "-m", "SimpleHTTPServer", "8000")
    
    override func setUp() {
        try! LaunchControl.shared.write(agent, called: "TestAgent.plist")
    }
    
    override func tearDown() {
        LaunchControl.shared.stop(agent)
        sleep(1)
        LaunchControl.shared.unload(agent)
        sleep(1)
        try! FileManager.default.removeItem(at: agent.url!)
    }
    
    func testLoad() {
        LaunchControl.shared.load(agent)
        sleep(1)
        
        XCTAssertEqual(agent.status(), AgentStatus.loaded)
    }
    
    func testUnload() {
        LaunchControl.shared.load(agent)
        sleep(1)
        LaunchControl.shared.unload(agent)
        sleep(1)
        
        XCTAssertEqual(agent.status(), AgentStatus.unloaded)
    }
    
    func testStartStop() {
        LaunchControl.shared.load(agent)
        sleep(1)
        LaunchControl.shared.start(agent)
        sleep(1)
        
        XCTAssertEqual(agent.status(), AgentStatus.running)
        LaunchControl.shared.stop(agent)
        sleep(1)
        
        XCTAssertEqual(agent.status(), AgentStatus.loaded)
    }
    
}
