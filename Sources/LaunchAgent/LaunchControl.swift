//
//  LaunchControl.swift
//  LaunchAgent
//
//  Created by Emory Dunn on 2018-02-19.
//

import Foundation

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
    func setURL(for agent: LaunchAgent) throws {
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
