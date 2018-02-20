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
    
    func launchAgentsURL() throws -> URL {
        let library = try FileManager.default.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false)

        return library.appendingPathComponent("LaunchAgents")
    }
    
    public func read(agent called: String) throws -> LaunchAgent {
        let url = try launchAgentsURL().appendingPathComponent(called)
        
        return try decoder.decode(LaunchAgent.self, from: Data(contentsOf: url))
    }

    public func write(_ agent: LaunchAgent, called: String) throws {
        let url = try launchAgentsURL().appendingPathComponent(called)
        try encoder.encode(agent).write(to: url)

        agent.url = url
    }
    
}
