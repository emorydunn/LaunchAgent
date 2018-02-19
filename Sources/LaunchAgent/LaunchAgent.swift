//
//  LaunchAgentswift
//  LaunchAgentPackageDescription
//
//  Created by Emory Dunn on 2018-02-19.
//

import Foundation

class LaunchAgent: Codable {
    
    var label: String? = nil
    var program: String? = nil
    var ProgramArguments: [String]?  = nil
    
    // Program
    var workingDirectory: String? = nil
    var standardInPath: String? = nil
    var standardOutPath: String? = nil
    var standardErrorPath: String? = nil
    var environmentVariables: [String: String]? = nil
    
    // Run Conditions
    var runAtLoad: Bool? = nil
    var startInterval: Int? = nil
    var startCalendarInterval: StartCalendarInterval? = nil
    var startOnMount: Bool? = nil
    var onDemand: Bool? = nil
    var keepAlive: Bool? = nil
    var watchPaths: [String]? = nil
    var queueDirectories: [String]? = nil
    
    // Security
    var umask: Int? = nil
    
    // Run Constriants
    var launchOnlyOnce: Bool? = nil
    var limitLoadToSessionType: [String]? = nil
    var limitLoadToHosts: [String]? = nil
    var limitLoadFromHosts: [String]? = nil
    
    
    // Control
    
    // IPC
    
    // Debug
    
    // Performance
    
    
    init() {
        
    }
    
    enum CodingKeys: String, CodingKey {
        case label = "Label"
        case program = "Program"
        case ProgramArguments = "ProgramArguments"
        
        // Program
        case workingDirectory = "WorkingDirectory"
        case standardInPath = "StandardInPath"
        case standardOutPath = "StandardOutPath"
        case standardErrorPath = "StandardErrorPath"
        case environmentVariables = "EnvironmentVariables"
        
        // Run Conditions
        case runAtLoad = "RunAtLoad"
        case startInterval = "StartInterval"
        case startCalendarInterval = "StartCalendarInterval"
        case startOnMount = "StartOnMount"
        case onDemand = "OnDemand"
        case keepAlive = "KeepAlive"
        case watchPaths = "WatchPaths"
        case queueDirectories = "QueueDirectories"
        
        // Security
        case umask = "Umask"
        
        // Run Constriants
        case launchOnlyOnce = "LaunchOnlyOnce"
        case limitLoadToSessionType = "LimitLoadToSessionType"
        case limitLoadToHosts = "LimitLoadToHosts"
        case limitLoadFromHosts = "LimitLoadFromHosts"
        
        // Control
        
        // IPC
        
        // Debug
        
        // Performance
        
    }
    
}

