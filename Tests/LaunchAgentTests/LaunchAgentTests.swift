import XCTest
@testable import LaunchAgent

class LaunchAgentTests: XCTestCase {
    
    func testNice() {
        let agent = LaunchAgent(label: "NiceTest")
        
        // Test minimum value
        agent.nice = -20
        XCTAssertEqual(agent.nice, -20)
        
        // Test maximum value
        agent.nice = 20
        XCTAssertEqual(agent.nice, 20)
        
        // Test less than minimum value
        agent.nice = -21
        XCTAssertEqual(agent.nice, -20)
        
        // Test greater than maximum value
        agent.nice = 21
        XCTAssertEqual(agent.nice, 20)
    }

}


class LaunchAgentControlTests: XCTestCase {
    let agent = LaunchAgent(label: "TestAgent.PythonServer", program: "python", "-m", "SimpleHTTPServer", "8000")
    
    override func setUp() {
        try! LaunchControl.shared.write(agent, called: "TestAgent.plist")
    }
    
    override func tearDown() {
        agent.stop()
        try! agent.unload()
        sleep(1)
        try! FileManager.default.removeItem(at: agent.url!)
    }
    
    func testLoad() {
        XCTAssertNoThrow(try agent.load())
        sleep(1)
        XCTAssertEqual(agent.status(), AgentStatus.loaded)
    }
    
    func testUnload() {
        XCTAssertNoThrow(try agent.load())
        sleep(1)
        XCTAssertNoThrow(try agent.unload())
        sleep(1)
        
        XCTAssertEqual(agent.status(), AgentStatus.unloaded)
    }

    func testStartStop() {
        XCTAssertNoThrow(try agent.load())
        sleep(1)
        XCTAssertNoThrow(agent.start())
        sleep(1)
        
        switch agent.status() {
        case .running(_):
            XCTAssert(true)
        default:
            XCTAssert(false)
        }

        agent.stop()
        sleep(1)
        
        XCTAssertEqual(agent.status(), AgentStatus.loaded)
    }
}
