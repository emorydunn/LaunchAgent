//
//  LaunchControlTests.swift
//  LaunchAgentTests
//
//  Created by Emory Dunn on 2018-02-19.
//

import XCTest
@testable import LaunchAgent

class LaunchControlTests: XCTestCase {

    func testWrite_withPlist() {
        let agent = LaunchAgent(label: "TestAgent")
        
        XCTAssertNoThrow(try LaunchControl.shared.write(agent, called: "TestAgent.plist"))

    }
    
    func testWrite_withoutPlist() {
        let agent = LaunchAgent(label: "TestAgent")
        
        XCTAssertNoThrow(try LaunchControl.shared.write(agent, called: "TestAgent"))
        XCTAssertEqual(agent.url?.lastPathComponent, "TestAgent.plist")
        
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
        XCTAssertNoThrow(try LaunchControl.shared.unload(agent))
        sleep(1)
        try! FileManager.default.removeItem(at: agent.url!)
    }
    
    func testLoad() {
        XCTAssertNoThrow(try LaunchControl.shared.load(agent))
        sleep(1)
        
        XCTAssertEqual(agent.status(), AgentStatus.loaded)
    }
    
    func testLoadError() {
        let testAgent = LaunchAgent(label: "TestAgent")
        XCTAssertThrowsError(try LaunchControl.shared.load(testAgent))
    }
    
    func testUnload() {
        XCTAssertNoThrow(try LaunchControl.shared.load(agent))
        sleep(1)
        XCTAssertNoThrow(try LaunchControl.shared.unload(agent))
        sleep(1)
        
        XCTAssertEqual(agent.status(), AgentStatus.unloaded)
    }
    
    func testUnloadError() {
        let testAgent = LaunchAgent(label: "TestAgent")
        XCTAssertThrowsError(try LaunchControl.shared.unload(testAgent))
    }
    
    func testStartStop() {
        XCTAssertNoThrow(try LaunchControl.shared.load(agent))
        sleep(1)
        LaunchControl.shared.start(agent)
        sleep(1)
        
        switch agent.status() {
        case .running(_):
            XCTAssert(true)
        default:
            XCTAssert(false)
        }
        
        LaunchControl.shared.stop(agent)
        sleep(1)
        
        XCTAssertEqual(agent.status(), AgentStatus.loaded)
    }
    
}
