import XCTest
@testable import LaunchAgent

class LaunchAgentTests: XCTestCase {
    
    let testJobMD5 = "fcdeb223b21face810670bdd83844ef8"
    
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

    func testValidity() {
        let launchAgent = LaunchAgent(label: "Launch Agent Test", program: "/bin/echo", "LaunchAgentTests")
        let interval = StartCalendarInterval(
            month: .january,
            weekday: .monday,
            day: 1,
            hour: 1,
            minute: 1
        )
        
        // Program
        launchAgent.workingDirectory = "/"
        launchAgent.standardInPath = "/tmp/LaunchAgentTest.stdin"
        launchAgent.standardOutPath = "/tmp/LaunchAgentTest.stdout"
        launchAgent.standardErrorPath = "/tmp/LaunchAgentTest.stderr"
        launchAgent.environmentVariables = ["envVar": "test"]
        
        // Run Conditions
        launchAgent.runAtLoad = true
        launchAgent.startInterval = 300
        launchAgent.startCalendarInterval = interval
        launchAgent.startOnMount = true
        launchAgent.onDemand = true
        launchAgent.keepAlive = false
        launchAgent.watchPaths = ["/"]
        launchAgent.queueDirectories = ["/"]
        
        // Security
        launchAgent.umask = 18
        
        // Run Constriants
        launchAgent.launchOnlyOnce = false
        launchAgent.limitLoadToSessionType = ["Aqua", "LoginWindow"]
        launchAgent.limitLoadToHosts = ["testHost"]
        launchAgent.limitLoadFromHosts = ["testHost II"]
        
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        
        do {
            let data = try encoder.encode(launchAgent)

            guard let string = String(data: data, encoding: .utf8) else {
                XCTAssert(false, "Could not encode plist as string")
                return
            }
            
            let md5er = Process()
            let stdOutPipe = Pipe()
            
            md5er.launchPath = "/sbin/md5"
            md5er.arguments = ["-q", "-s", string]
            md5er.standardOutput = stdOutPipe
            
            md5er.launch()
            
            // Process Pipe into a String
            let stdOutputData = stdOutPipe.fileHandleForReading.readDataToEndOfFile()
            let stdOutString = String(bytes: stdOutputData, encoding: String.Encoding.utf8)?.replacingOccurrences(of: "\n", with: "")
            
            md5er.waitUntilExit()

            XCTAssertEqual(testJobMD5, stdOutString)
            
        } catch {
            XCTAssert(false)
        }
        
    }
}


class LaunchAgentControlTests: XCTestCase {
    let agent = LaunchAgent(label: "TestAgent.PythonServer", program: "python", "-m", "SimpleHTTPServer", "8000")
    
    override func setUp() {
        try! LaunchControl.shared.write(agent, called: "TestAgent.plist")
    }
    
    override func tearDown() {
//        try! FileManager.default.removeItem(at: agent.url!)
    }
    
    func testLoad() {
        agent.load()
        
        XCTAssertEqual(agent.status(), AgentStatus.loaded)
    }
    
    func testUnload() {
        agent.load()
        sleep(1)
        agent.unload()
        
        XCTAssertEqual(agent.status(), AgentStatus.unloaded)
    }
    
    func testStartStop() {
        agent.load()
        agent.start()
        sleep(1)
        
        XCTAssertEqual(agent.status(), AgentStatus.running)
        agent.stop()
        sleep(1)
        
        XCTAssertEqual(agent.status(), AgentStatus.loaded)
    }
}
