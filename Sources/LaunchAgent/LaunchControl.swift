//
//  LaunchControl.swift
//  LaunchAgent
//
//  Created by Emory Dunn on 2018-02-19.
//

import Foundation

public enum LaunchControlError: Error {
    case urlNotSet
}

public class LaunchControl {
    public static let shared = LaunchControl()
    
    static let launchctl = "/bin/launchctl"
    
    
    let encoder = PropertyListEncoder()
    let decoder = PropertyListDecoder()
    
    init() {
        encoder.outputFormat = .xml
    }
    
    /// Provides the user's LaunchAgent directory
    ///
    /// - Note: If run in a sandbox the directory returned will be inside the application's container
    ///
    /// - Returns: ~/Library/LaunchAgent
    /// - Throws: FileManager errors
    func launchAgentsURL() throws -> URL {
        let library = try FileManager.default.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false)

        return library.appendingPathComponent("LaunchAgents")
    }
    
    /// Read a LaunchAgent from the user's LaunchAgents directory
    ///
    /// - Parameter called: file name of the job
    /// - Returns: a LaunchAgent instance
    /// - Throws: errors on decoding the property list
    public func read(agent called: String) throws -> LaunchAgent {
        let url = try launchAgentsURL().appendingPathComponent(called)
        
        return try read(from: url)
    }
    
    /// Read a LaunchAgent from disk
    ///
    /// - Parameter url: url of the property list
    /// - Returns:a LaunchAgent instance
    /// - Throws: errors on decoding the property list
    public func read(from url: URL) throws -> LaunchAgent {
        return try decoder.decode(LaunchAgent.self, from: Data(contentsOf: url))
    }

    /// Writes a LaunchAgent to disk as a property list into the user's LaunchAgents directory
    ///
    /// - Parameters:
    ///   - agent: the agent to encode
    ///   - called: the file name of the job
    /// - Throws: errors on encoding the property list
    public func write(_ agent: LaunchAgent, called: String) throws {
        let url = try launchAgentsURL().appendingPathComponent(called)
        
        try write(agent, to: url)
    }
    
    /// Writes a LaunchAgent to disk as a property list to the specified URL
    ///
    /// - Parameters:
    ///   - agent: the agent to encode
    ///   - called: the url at which to write
    /// - Throws: errors on encoding the property list
    public func write(_ agent: LaunchAgent, to url: URL) throws {
        try encoder.encode(agent).write(to: url)
        
        agent.url = url
    }
    
    /// Sets the provided LaunchAgent's URL based on its `label`
    ///
    /// - Parameter agent: the LaunchAgent
    /// - Throws: errors when reading directory contents
    public func setURL(for agent: LaunchAgent) throws {
        let contents = try FileManager.default.contentsOfDirectory(
            at: try launchAgentsURL(),
            includingPropertiesForKeys: nil,
            options: [.skipsPackageDescendants, .skipsHiddenFiles, .skipsSubdirectoryDescendants]
        )
        
        contents.forEach { url in
            let testAgent = try? self.read(from: url)
            
            if agent.label == testAgent?.label {
                agent.url = url
                return
            }
        }
        
        
    }
    
}

// MARK: - Job control
extension LaunchControl {
    /// Run `launchctl start` on the agent
    ///
    /// Check the status of the job with `.status(_: LaunchAgent)`
    public func start(_ agent: LaunchAgent) {
        let arguments = ["start", agent.label]
        Process.launchedProcess(launchPath: LaunchControl.launchctl, arguments: arguments)
    }
    
    /// Run `launchctl stop` on the agent
    ///
    /// Check the status of the job with `.status(_: LaunchAgent)`
    public func stop(_ agent: LaunchAgent) {
        let arguments = ["stop", agent.label]
        Process.launchedProcess(launchPath: LaunchControl.launchctl, arguments: arguments)
    }
    
    /// Run `launchctl load` on the agent
    ///
    /// Check the status of the job with `.status(_: LaunchAgent)`
    public func load(_ agent: LaunchAgent) throws {
        guard let agentURL = agent.url else {
            throw LaunchControlError.urlNotSet
        }
        
        let arguments = ["load", agentURL.path]
        Process.launchedProcess(launchPath: LaunchControl.launchctl, arguments: arguments)
    }
    
    /// Run `launchctl unload` on the agent
    ///
    /// Check the status of the job with `.status(_: LaunchAgent)`
    public func unload(_ agent: LaunchAgent) throws {
        guard let agentURL = agent.url else {
            throw LaunchControlError.urlNotSet
        }
        
        let arguments = ["unload", agentURL.path]
        Process.launchedProcess(launchPath: LaunchControl.launchctl, arguments: arguments)
    }
    
    /// Retreives the status of the LaunchAgent from `launchctl`
    ///
    /// - Returns: the agent's status
    public func status(_ agent: LaunchAgent) -> AgentStatus {
        // Adapted from https://github.com/zenonas/barmaid/blob/master/Barmaid/LaunchControl.swift
        
        let launchctlTask = Process()
        let grepTask = Process()
        let cutTask = Process()
        
        launchctlTask.launchPath = "/bin/launchctl"
        launchctlTask.arguments = ["list"]
        
        grepTask.launchPath = "/usr/bin/grep"
        grepTask.arguments = [agent.label]
        
        cutTask.launchPath = "/usr/bin/cut"
        cutTask.arguments = ["-f1"]
        
        let pipeLaunchCtlToGrep = Pipe()
        launchctlTask.standardOutput = pipeLaunchCtlToGrep
        grepTask.standardInput = pipeLaunchCtlToGrep
        
        let pipeGrepToCut = Pipe()
        grepTask.standardOutput = pipeGrepToCut
        cutTask.standardInput = pipeGrepToCut
        
        let pipeCutToFile = Pipe()
        cutTask.standardOutput = pipeCutToFile
        
        let fileHandle: FileHandle = pipeCutToFile.fileHandleForReading as FileHandle
        
        launchctlTask.launch()
        grepTask.launch()
        cutTask.launch()
        
        
        let data = fileHandle.readDataToEndOfFile()
        let stringResult = String(data: data, encoding: .utf8)?.replacingOccurrences(of: "\n", with: "") ?? ""
        
        //        if let pid = Int(stringResult) {
        //            return .running(pid: pid)
        //        }
        
        switch stringResult {
        case "-":
            return .loaded
        case "":
            return .unloaded
        default:
            return .running
        }
    }
}
