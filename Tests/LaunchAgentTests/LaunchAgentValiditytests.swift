//
//  LaunchAgentValiditytests.swift
//  LaunchAgentTests
//
//  Created by Emory Dunn on 2018-02-20.
//

import XCTest
import LaunchAgent

extension LaunchAgent {
    func checksum() -> String {
        let agent = self
        
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        
        guard let data = try? encoder.encode(agent) else {
            XCTAssert(false, "Could not encode LaunchAgent")
            return ""
        }
        
        guard let string = String(data: data, encoding: .utf8) else {
            XCTAssert(false, "Could not encode plist as string")
            return ""
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
        
        return stdOutString ?? ""
    }
}

class LaunchAgentValiditytests: XCTestCase {

    
    func testBasicConfig() {
        let launchAgent = LaunchAgent(label: "Launch Agent Test", program: "/bin/echo", "LaunchAgentTests")
        
        launchAgent.disabled = false
        launchAgent.enableGlobbing = true
        
        XCTAssertEqual(launchAgent.checksum(), "2ae0c4badbcbf024c4b2f611a8e9d9b2")
    }
    
    func testProgram() {
        let launchAgent = LaunchAgent(label: "Launch Agent Test", program: "/bin/echo", "LaunchAgentTests")
        
        launchAgent.workingDirectory = "/"
        launchAgent.standardInPath = "/tmp/LaunchAgentTest.stdin"
        launchAgent.standardOutPath = "/tmp/LaunchAgentTest.stdout"
        launchAgent.standardErrorPath = "/tmp/LaunchAgentTest.stderr"
        launchAgent.environmentVariables = ["envVar": "test"]
        
        XCTAssertEqual(launchAgent.checksum(), "938144a1ef925797bb644687877fd128")
    }
    
    func testRunConditions() {
        let launchAgent = LaunchAgent(label: "Launch Agent Test", program: "/bin/echo", "LaunchAgentTests")
        
        let interval = StartCalendarInterval(
            month: .january,
            weekday: .monday,
            day: 1,
            hour: 1,
            minute: 1
        )
        
        launchAgent.runAtLoad = true
        launchAgent.startInterval = 300
        launchAgent.startCalendarInterval = interval
        launchAgent.startOnMount = true
        launchAgent.onDemand = true
        launchAgent.keepAlive = false
        launchAgent.watchPaths = ["/"]
        launchAgent.queueDirectories = ["/"]
        
        XCTAssertEqual(launchAgent.checksum(), "5965ee695f88a12c7992b07ecda43199")
    }
    
    func testSecurity() {
        let launchAgent = LaunchAgent(label: "Launch Agent Test", program: "/bin/echo", "LaunchAgentTests")
        
        launchAgent.umask = 18
        
        XCTAssertEqual(launchAgent.checksum(), "ba2edc2f91676815fc0c0d5326a28653")
    }
    
    func testRunConstriants() {
        let launchAgent = LaunchAgent(label: "Launch Agent Test", program: "/bin/echo", "LaunchAgentTests")
        
        launchAgent.launchOnlyOnce = false
        launchAgent.limitLoadToSessionType = ["Aqua", "LoginWindow"]
        launchAgent.limitLoadToHosts = ["testHost"]
        launchAgent.limitLoadFromHosts = ["testHost II"]
        
        XCTAssertEqual(launchAgent.checksum(), "0848687c86bd4f91c008e927f62996d6")
    }
    
    func testControl() {
        let launchAgent = LaunchAgent(label: "Launch Agent Test", program: "/bin/echo", "LaunchAgentTests")
        
        let softResource = ResourceLimits(cPU: 1, core: 1, data: 1, fileSize: 1, memoryLock: 1, numberOfFiles: 1, numberOfProcesses: 1, residentSetSize: 1, stack: 1)
        
        let hardResource = ResourceLimits(cPU: 2, core: 2, data: 2, fileSize: 2, memoryLock: 2, numberOfFiles: 2, numberOfProcesses: 2, residentSetSize: 2, stack: 2)
        
        launchAgent.abandonProcessGroup = true
        launchAgent.enablePressuredExit = true
        launchAgent.enableTransactions = true
        launchAgent.exitTimeOut = 30
        launchAgent.inetdCompatibility = inetdCompatibility(wait: true)
        launchAgent.softResourceLimits = softResource
        launchAgent.hardResourceLimits = hardResource
        launchAgent.timeOut = 30
        launchAgent.throttleInterval = 30
        
        XCTAssertEqual(launchAgent.checksum(), "056be4d7e234fc3d17b6f849f8f3b412")
    }
    
    func testIPC() {
        let launchAgent = LaunchAgent(label: "Launch Agent Test", program: "/bin/echo", "LaunchAgentTests")
        
        launchAgent.machServices = [
            "local.svc": MachService(hideUntilCheckIn: true, resetAtClose: true)
        ]
        
        
        XCTAssertEqual(launchAgent.checksum(), "f183b615ad0dee50a5790af4b7d773ed")
    }
    
    func testDebug() {
        let launchAgent = LaunchAgent(label: "Launch Agent Test", program: "/bin/echo", "LaunchAgentTests")
        
        launchAgent.debug = true
        launchAgent.waitForDebugger = true
        
        XCTAssertEqual(launchAgent.checksum(), "a6018f910f828883096f789d4293db67")
    }
    
    func testPerformance() {
        let launchAgent = LaunchAgent(label: "Launch Agent Test", program: "/bin/echo", "LaunchAgentTests")
        
        launchAgent.legacyTimers = true
        launchAgent.lowPriorityIO = true
        launchAgent.lowPriorityBackgroundIO = true
        launchAgent.nice = 10
        launchAgent.processType = .background
        
        XCTAssertEqual(launchAgent.checksum(), "82cef72d83be053985d51db4c33565b9")
    }

}
