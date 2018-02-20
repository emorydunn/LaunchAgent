//
//  LaunchAgent+Status.swift
//  LaunchAgent
//
//  Created by Emory Dunn on 2018-02-19.
//

import Foundation

public enum AgentStatus {
    case running
    case loaded
    case unloaded
    
}

extension LaunchAgent {
    
    // MARK: LaunchControl
    
    public func start() {
        let arguments = ["start", label]
        Process.launchedProcess(launchPath: LaunchControl.launchctl, arguments: arguments)
    }
    
    public func stop() {
        let arguments = ["stop", label]
        Process.launchedProcess(launchPath: LaunchControl.launchctl, arguments: arguments)
    }
    
    public func load() {
        guard let agentURL = url else {
            return
        }
        
        let arguments = ["load", agentURL.path]
        Process.launchedProcess(launchPath: LaunchControl.launchctl, arguments: arguments)
    }
    
    public func unload() {
        guard let agentURL = url else {
            return
        }
        
        let arguments = ["unload", agentURL.path]
        Process.launchedProcess(launchPath: LaunchControl.launchctl, arguments: arguments)
    }
    
    public func status() -> AgentStatus {
        // Adapted from https://github.com/zenonas/barmaid/blob/master/Barmaid/LaunchControl.swift
        
        let launchctlTask = Process()
        let grepTask = Process()
        let cutTask = Process()
        
        launchctlTask.launchPath = "/bin/launchctl"
        launchctlTask.arguments = ["list"]
        
        grepTask.launchPath = "/usr/bin/grep"
        grepTask.arguments = [label]
        
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

