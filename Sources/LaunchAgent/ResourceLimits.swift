//
//  SoftResourceLimits.swift
//  LaunchAgent
//
//  Created by Emory Dunn on 2018-02-20.
//

import Foundation

public class ResourceLimits: Codable {
    
    public var cpu: Int?
    public var core: Int?
    public var data: Int?
    public var fileSize: Int?
    public var memoryLock: Int?
    public var numberOfFiles: Int?
    public var numberOfProcesses: Int?
    public var residentSetSize: Int?
    public var stack: Int?
    
    public init(cpu: Int? = nil, core: Int? = nil, data: Int? = nil, fileSize: Int? = nil, memoryLock: Int? = nil, numberOfFiles: Int? = nil, numberOfProcesses: Int? = nil, residentSetSize: Int? = nil, stack: Int? = nil) {
        self.cpu = cpu
        self.core = core
        self.data = data
        self.fileSize = fileSize
        self.memoryLock = memoryLock
        self.numberOfFiles = numberOfFiles
        self.numberOfProcesses = numberOfProcesses
        self.residentSetSize = residentSetSize
        self.stack = stack
    }
    
    public enum CodingKeys: String, CodingKey {
        case cpu = "CPU"
        case core = "Core"
        case data = "Data"
        case fileSize = "FileSize"
        case memoryLock = "MemoryLock"
        case numberOfFiles = "NumberOfFiles"
        case numberOfProcesses = "NumberOfProcesses"
        case residentSetSize = "ResidentSetSize"
        case stack = "Stack"
    }
}
