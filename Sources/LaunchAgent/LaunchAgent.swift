//
//  LaunchAgentswift
//  LaunchAgentPackageDescription
//
//  Created by Emory Dunn on 2018-02-19.
//

import Foundation

public class LaunchAgent: Codable {
    
    public var url: URL? = nil
    
    // Basic Properties
    public var label: String
    public var disabled: Bool? = nil
    public var enableGlobbing: Bool? = nil
    public var program: String? = nil {
        didSet {
            if program != nil {
                programArguments = nil
            }
            
        }
    }
    
    public var programArguments: [String]? = nil {
        didSet {
            guard let args = programArguments else {
                return
            }
            
            if args.count == 1 {
                self.program = args.first
                programArguments = nil
            } else {
                program = nil
            }
            
        }
    }
    
    // Program
    public var workingDirectory: String? = nil
    public var standardInPath: String? = nil
    public var standardOutPath: String? = nil
    public var standardErrorPath: String? = nil
    public var environmentVariables: [String: String]? = nil
    
    // Run Conditions
    public var runAtLoad: Bool? = nil
    public var startInterval: Int? = nil
    public var startCalendarInterval: StartCalendarInterval? = nil
    public var startOnMount: Bool? = nil
    public var onDemand: Bool? = nil
    public var keepAlive: Bool? = nil
    public var watchPaths: [String]? = nil
    public var queueDirectories: [String]? = nil
    
    // Security
    public var umask: Int? = nil
    
    // Run Constriants
    public var launchOnlyOnce: Bool? = nil
    public var limitLoadToSessionType: [String]? = nil
    public var limitLoadToHosts: [String]? = nil
    public var limitLoadFromHosts: [String]? = nil
    
    
    // Control
    public var abandonProcessGroup: Bool? = nil
    public var enablePressuredExit: Bool? = nil
    public var enableTransactions: Bool? = nil
    public var exitTimeOut: Int? = nil
    public var inetdCompatibility: inetdCompatibility? = nil
    public var hardResourceLimits: ResourceLimits? = nil
    public var softResourceLimits: ResourceLimits? = nil
    public var timeOut: Int? = nil
    public var throttleInterval: Int? = nil
    
    // IPC
    public var machServices: [String: MachService]? = nil
    
    // Debug
    public var debug: Bool? = nil
    public var waitForDebugger: Bool? = nil
    
    // Performance
    public var legacyTimers: Bool? = nil
    public var lowPriorityIO: Bool? = nil
    public var lowPriorityBackgroundIO: Bool? = nil
    public var nice: Int? = nil  {
        didSet {
            guard let newInt = nice else {
                return
            }
            if newInt < -20 {
                nice = -20
            } else if newInt > 20 {
                nice = 20
            }
        }
    }
    public var processType: ProcessType? = nil
    
    /// Instantiate a new LaunchAgent
    ///
    /// - Note: Globbing was deprecated in macOS 10.10, so full paths must be provided
    ///
    /// - Parameters:
    ///   - label: the job's label
    ///   - program: the job's program arguments
    public init(label: String, program: [String]) {
        self.label = label
        if program.count == 1 {
            self.program = program.first
        } else {
            self.programArguments = program
        }
        
    }
    
    /// Instantiate a new LaunchAgent
    ///
    /// - Note: Globbing was deprecated in macOS 10.10, so full paths must be provided
    ///
    /// - Parameters:
    ///   - label: the job's label
    ///   - program: the job's program arguments
    public convenience init(label: String, program: String...) {
        self.init(label: label, program: program)
    }
    
    public enum CodingKeys: String, CodingKey {
        case label = "Label"
        case disabled = "Disabled"
        case enableGlobbing = "EnableGlobbing"
        case program = "Program"
        case programArguments = "ProgramArguments"
        
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
        case abandonProcessGroup = "AbandonProcessGroup"
        case enablePressuredExit = "EnablePressuredExit"
        case enableTransactions = "EnableTransactions"
        case exitTimeOut = "ExitTimeOut"
        case inetdCompatibility = "inetdCompatibility"
        case hardResourceLimits = "HardResourceLimits"
        case softResourceLimits = "SoftResourceLimits"
        case timeOut = "TimeOut"
        case throttleInterval = "ThrottleInterval"
        
        // IPC
        case machServices = "MachServices"
        
        // Debug
        case debug = "Debug"
        case waitForDebugger = "WaitForDebugger"
        
        // Performance
        case legacyTimers = "LegacyTimers"
        case lowPriorityIO = "LowPriorityIO"
        case lowPriorityBackgroundIO = "LowPriorityBackgroundIO"
        case nice = "Nice"
        case processType = "ProcessType"
        
    }
    
}

