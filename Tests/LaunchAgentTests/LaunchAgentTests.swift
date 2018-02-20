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
        agent.unload()
        sleep(1)
        try! FileManager.default.removeItem(at: agent.url!)
    }
    
    func testLoad() {
        agent.load()
        
        XCTAssertEqual(agent.status(), AgentStatus.loaded)
    }
    
    func testUnload() {
        agent.load()
        sleep(1)
        agent.unload()
        sleep(1)
        
        XCTAssertEqual(agent.status(), AgentStatus.unloaded)
    }

    func testStartStop() {
        agent.load()
        sleep(1)
        agent.start()
        sleep(1)
        
        XCTAssertEqual(agent.status(), AgentStatus.running)
        agent.stop()
        sleep(1)
        
        XCTAssertEqual(agent.status(), AgentStatus.loaded)
    }
}
