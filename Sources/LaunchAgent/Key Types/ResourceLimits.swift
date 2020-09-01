//
//  SoftResourceLimits.swift
//  LaunchAgent
//
//  Created by Emory Dunn on 2018-02-20.
//

import Foundation

/// Resource limits to be imposed on the job. These adjust variables set with setrlimit(2).
public class ResourceLimits: Codable {
    
    /// The maximum amount of cpu time (in seconds) to be used by each process.
    public var cpu: Int?
    
    /// The largest size (in bytes) core file that may be created.
    public var core: Int?
    
    /// The maximum size (in bytes) of the data segment for a process; this
    /// defines how far a program may extend its break with the sbrk(2)
    /// system call.
    public var data: Int?
    
    /// The largest size (in bytes) file that may be created.
    public var fileSize: Int?
    
    /// The maximum size (in bytes) which a process may lock into memory
    /// using the mlock(2) function.
    public var memoryLock: Int?
    
    /// The maximum number of open files for this process.
    ///
    /// Setting this value in a system wide daemon will set the sysctl(3) kern.maxfiles
    /// (SoftResourceLimits) or kern.maxfilesperproc (HardResourceLimits)
    /// value in addition to the setrlimit(2) values.
    public var numberOfFiles: Int?
    
    /// The maximum number of simultaneous processes for this UID.
    ///
    /// Setting this value in a system wide daemon will set the sysctl(3) kern.max-
    /// proc (SoftResourceLimits) or kern.maxprocperuid (HardResourceLimits)
    /// value in addition to the setrlimit(2) values.
    public var numberOfProcesses: Int?
    
    /// The maximum size (in bytes) to which a process's resident set size
    /// may grow.
    ///
    /// This imposes a limit on the amount of physical memory to
    /// be given to a process; if memory is tight, the system will prefer
    /// to take memory from processes that are exceeding their declared
    /// resident set size.
    public var residentSetSize: Int?
    
    /// The maximum size (in bytes) of the stack segment for a process;
    /// this defines how far a program's stack segment may be extended.
    ///
    /// Stack extension is performed automatically by the system.
    public var stack: Int?
    
    /// Instantiate a new object.
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
    
    /// launchd.plist keys
    public enum CodingKeys: String, CodingKey {
        /// CPU
        case cpu = "CPU"
        /// Core
        case core = "Core"
        /// Data
        case data = "Data"
        /// FileSize
        case fileSize = "FileSize"
        /// MemoryLock
        case memoryLock = "MemoryLock"
        /// NumberOfFiles
        case numberOfFiles = "NumberOfFiles"
        /// NumberOfProcesses
        case numberOfProcesses = "NumberOfProcesses"
        /// ResidentSetSize
        case residentSetSize = "ResidentSetSize"
        /// Stack
        case stack = "Stack"
    }
}
