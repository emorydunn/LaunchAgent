//
//  LaunchAgentswift
//  LaunchAgentPackageDescription
//
//  Created by Emory Dunn on 2018-02-19.
//

import Foundation

/// The primary class used to control a Launch Agent
///
/// For detailed information on agents see [https://www.launchd.info](https://www.launchd.info).
public class LaunchAgent: Codable {
    
    /// Location on disk of the agent
    ///
    /// `LaunchControl` can be used to attempt to set the URL automatically:
    ///
    /// ```
    /// LaunchControl.shared.setURL(for: agent)
    /// ```
    public var url: URL? = nil
    
    // Basic Properties
    /// Contains a unique string that identifies your daemon to launchd.
    public var label: String
    
    /// Whether the agent is enabled.
    ///
    /// This must be `true` in order to load or start the agent.
    public var disabled: Bool? = nil
    
    /// Whether to enable shell globbing.
    ///
    /// - Important: Support for globbing was removed in macOS 10.10
    public var enableGlobbing: Bool? = nil
    
    /// The program to be executed
    public var program: String? = nil
    
    /// Contains the arguments used to launch your daemon
    ///
    /// - Note: If `program` is empty the first item is used as the path to the executable.
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
    /// This optional key is used to specify a directory to chdir(2) to before
    /// running the job.
    public var workingDirectory: String? = nil
    
    /// This optional key specifies that the given path should be mapped to the
    /// job's stdin(4), and that the contents of that file will be readable from
    /// the job's stdin(4).
    ///
    /// If the file does not exist, no data will be deliv-
    /// ered to the process' stdin(4)
    public var standardInPath: String? = nil
    
    /// This optional key specifies that the given path should be mapped to the
    /// job's stdout(4), and that any writes to the job's stdout(4) will go to
    /// the given file.
    ///
    /// If the file does not exist, it will be created with
    /// writable permissions and ownership reflecting the user and/or group specified
    /// as the UserName and/or GroupName, respectively (if set) and permissions
    /// reflecting the umask(2) specified by the Umask key, if set.
    public var standardOutPath: String? = nil
    
    /// This optional key specifies that the given path should be mapped to the
    /// job's stderr(4), and that any writes to the job's stderr(4) will go to
    /// the given file.
    ///
    /// Note that this file is opened as readable and writable as
    /// mandated by the POSIX specification for unclear reasons.  If the file
    /// does not exist, it will be created with ownership reflecting the user
    /// and/or group specified as the UserName and/or GroupName, respectively (if
    /// set) and permissions reflecting the umask(2) specified by the Umask key,
    /// if set.
    public var standardErrorPath: String? = nil
    
    /// This optional key is used to specify additional environmental variables
    /// to be set before running the job. Each key in the dictionary is the name
    /// of an environment variable, with the corresponding value being a string
    /// representing the desired value.  NOTE: Values other than strings will be
    /// ignored.
    public var environmentVariables: [String: String]? = nil
    
    // Run Conditions
    /// This optional key is used to control whether your job is launched once at
    /// the time the job is loaded.
    public var runAtLoad: Bool? = nil
    
    /// This optional key causes the job to be started every N seconds.
    ///
    /// If the system is asleep during the time of the next scheduled interval firing,
    /// that interval will be missed due to shortcomings in kqueue(3).  If the
    /// job is running during an interval firing, that interval firing will like-wise be missed.
    public var startInterval: Int? = nil
    
    /// This optional key causes the job to be started every calendar interval as
    /// specified.
    ///
    /// Missing arguments are considered to be wildcard. The semantics
    /// are similar to crontab(5) in how firing dates are specified. Multiple
    /// dictionaries may be specified in an array to schedule multiple calendar
    /// intervals.
    public var startCalendarInterval: StartCalendarInterval? = nil
    
    /// This optional key causes the job to be started every time a filesystem is
    /// mounted.
    public var startOnMount: Bool? = nil
    
    /// This key does nothing if set to true. If set to false, this key is equiv-
    /// alent to specifying a true value for the KeepAlive key. This key should
    /// not be used. Please remove this key from your launchd.plist.
    public var onDemand: Bool? = nil
    
    /// This key specifies whether your daemon launches on-demand or must always be running.
    /// It is recommended that you design your daemon to be launched on-demand.
    public var keepAlive: Bool? = nil
    
    /// This optional key causes the job to be started if any one of the listed
    /// paths are modified.
    public var watchPaths: [String]? = nil
    
    /// This optional key keeps the job alive as long as the directory or direc-
    /// tories specified are not empty.
    public var queueDirectories: [String]? = nil
    
    // Security
    /// This optional key specifies what value should be passed to umask(2)
    /// before running the job.
    ///
    /// If the value specified is an integer, it must be
    /// a decimal representation of the desired umask, as property lists do not
    /// support encoding integers in octal. If a string is given, the string will
    /// be converted into an integer as per the rules described in strtoul(3),
    /// and an octal value may be specified by prefixing the string with a '0'.
    /// If a string that does not cleanly convert to an integer is specified, the
    /// behavior will be to set a umask(2) according to the strtoul(3) parsing
    /// rules.
    public var umask: Int? = nil
    // System Daemon Security
    
    /// This key specifies that the job should be spawned into a new security
    /// audit session rather than the default session for the context is belongs
    /// to. See `auditon(2)` for details.
    public var sessionCreate: Bool? = nil
    
    /// This optional key specifies the group to run the job as.
    ///
    /// This key is only applicable for services that are loaded into the privileged system
    /// domain. If UserName is set and GroupName is not, then the group will be
    /// set to the primary group of the user.
    public var groupName: String? = nil
    
    /// This optional key specifies the user to run the job as.
    ///
    /// This key is only applicable for services that are loaded into the privileged system
    /// domain.
    public var userName: String? = nil
    
    /// This optional key specifies whether initgroups(3) to initialize the group
    /// list for the job.
    ///
    /// The default is true. This key will be ignored if the
    /// UserName key is not set. Note that for agents, the UserName key is ignored.
    public var initGroups: Bool? = nil
    
    /// This optional key is used to specify a directory to chroot(2) to before
    /// running the job.
    public var rootDirectory: String? = nil
    
    
    // Run Constriants
    /// This optional key specifies whether the job can only be run once and only
    /// once.
    ///
    /// In other words, if the job cannot be safely respawned without a
    /// full machine reboot, then set this key to be true.
    public var launchOnlyOnce: Bool? = nil
    
    /// This configuration file only applies to sessions of the type(s) speci-
    /// fied.
    ///
    /// This key only applies to jobs which are agents. There are no distinct
    /// sessions in the privileged system context.
    public var limitLoadToSessionType: [String]? = nil
    
    /// This configuration file only applies to the hosts listed with this key.
    ///
    /// - Important: This key is no longer supported.
    public var limitLoadToHosts: [String]? = nil
    
    /// This configuration file only applies to hosts NOT listed with this key.
    ///
    /// - Important: This key is no longer supported.
    public var limitLoadFromHosts: [String]? = nil
    
    
    // Control
    /// When a job dies, launchd kills any remaining processes with the same
    /// process group ID as the job.
    ///
    /// Setting this key to true disables that behavior.
    public var abandonProcessGroup: Bool? = nil
    
    
    /// This key opts the job into the system's Pressured Exit facility.
    ///
    /// Use of this key implies EnableTransactions , and also lets the system consider
    /// process eligible for reclamation under memory pressure when it's inac-
    /// tive. See `xpc_main(3)` for details. Jobs that opt into Pressured Exit will
    /// be automatically relaunched if they exit or crash while holding open
    /// transactions.
    ///
    /// - NOTE: `launchd(8)` does not respect EnablePressuredExit for jobs that have
    /// KeepAlive set to true.
    /// - IMPORTANT: Jobs which opt into Pressured Exit will ignore SIGTERM rather
    /// than exiting by default, so a `dispatch(3)` source must be used when han-
    /// dling this signal.
    public var enablePressuredExit: Bool? = nil
    
    /// This key instructs launchd that the job uses `xpc_transaction_begin(3)` and
    /// `xpc_transaction_end(3)` to track outstanding transactions.
    ///
    /// When a process has an outstanding transaction, it is considered active, otherwise inac-
    /// tive. A transaction is automatically created when an XPC message expect-
    /// ing a reply is received, until the reply is sent or the request message
    /// is discarded. When launchd stops an active process, it sends SIGTERM
    /// first, and then SIGKILL after a reasonable timeout. If the process is
    /// inactive, SIGKILL is sent immediately.
    public var enableTransactions: Bool? = nil
    
    /// The amount of time launchd waits between sending the SIGTERM signal and
    /// before sending a SIGKILL signal when the job is to be stopped.
    ///
    /// The default value is system-defined. The value zero is interpreted as infinity and
    /// should not be used, as it can stall system shutdown forever.
    public var exitTimeOut: Int? = nil
    
    /// The presence of this key specifies that the daemon expects to be run as
    /// if it were launched from inetd.
    ///
    /// - Important: For new projects, this key should be avoided.
    public var inetdCompatibility: inetdCompatibility? = nil
    
    /// Resource limits to be imposed on the job. These adjust variables set with setrlimit(2).
    public var hardResourceLimits: ResourceLimits? = nil
    
    /// Resource limits to be imposed on the job. These adjust variables set with setrlimit(2).
    public var softResourceLimits: ResourceLimits? = nil
    
    /// The recommended idle time out (in seconds) to pass to the job.
    ///
    /// This key never did anything interesting and is no longer implemented. Jobs seeking
    /// to exit when idle should use the EnablePressuredExit key to opt into the
    /// system mechanism for reclaiming killable jobs under memory pressure.
    public var timeOut: Int? = nil
    
    /// This key lets one override the default throttling policy imposed on jobs
    /// by launchd.
    ///
    /// The value is in seconds, and by default, jobs will not be
    /// spawned more than once every 10 seconds. The principle behind this is
    /// that jobs should linger around just in case they are needed again in the
    /// near future. This not only reduces the latency of responses, but it
    /// encourages developers to amortize the cost of program invocation.
    public var throttleInterval: Int? = nil
    
    // IPC
    /// This optional key is used to specify Mach services to be registered with
    /// the Mach bootstrap namespace.
    ///
    /// Each key in this dictionary should be the
    /// name of a service to be advertised. The value of the key must be a
    /// boolean and set to true or a dictionary in order for the service to be
    /// advertised.
    public var machServices: [String: MachService]? = nil
    
    // Debug
    /// This optional key specifies that launchd should adjust its log mask temporarily
    /// to LOG_DEBUG while dealing with this job.
    public var debug: Bool? = nil
    
    /// This optional key specifies that launchd should launch the job in a suspended
    /// state so that a debugger can be attached to the process as early as possible (at the first instruction).
    public var waitForDebugger: Bool? = nil
    
    // Performance
    
    /// This optional key controls the behavior of timers created by the job.
    ///
    /// By default on OS X Mavericks version 10.9 and later, timers created by
    /// launchd jobs are coalesced. Batching the firing of timers with similar
    /// deadlines improves the overall energy efficiency of the system. If this
    /// key is set to true, timers created by the job will opt into less effi-
    /// cient but more precise behavior and not be coalesced with other timers.
    /// This key may have no effect if the job's ProcessType is not set to Interactive.
    public var legacyTimers: Bool? = nil
    
    /// This optional key specifies whether the kernel should consider this
    /// daemon to be low priority when doing filesystem I/O.
    public var lowPriorityIO: Bool? = nil
    
    /// This optional key specifies whether the kernel should consider this
    /// daemon to be low priority when doing filesystem I/O when the process is
    /// throttled with the Darwin-background classification.
    public var lowPriorityBackgroundIO: Bool? = nil
    
    ///  This optional key specifies what nice(3) value should be applied to the daemon.
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
    
    /// This optional key describes, at a high level, the intended purpose of the
    /// job.
    ///
    /// The system will apply resource limits based on what kind of job it
    /// is. If left unspecified, the system will apply light resource limits to
    /// the job, throttling its CPU usage and I/O bandwidth. This classification
    /// is preferable to using the HardResourceLimits, SoftResourceLimits and
    /// Nice keys.
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
    
    /// launchd.plist keys
    public enum CodingKeys: String, CodingKey {
        /// Label
        case label = "Label"
        /// Disabled
        case disabled = "Disabled"
        /// EnableGlobbing
        case enableGlobbing = "EnableGlobbing"
        /// Program
        case program = "Program"
        /// ProgramArguments
        case programArguments = "ProgramArguments"
        
        // Program
        /// WorkingDirectory
        case workingDirectory = "WorkingDirectory"
        /// StandardInPath
        case standardInPath = "StandardInPath"
        /// StandardOutPath
        case standardOutPath = "StandardOutPath"
        /// StandardErrorPath
        case standardErrorPath = "StandardErrorPath"
        /// EnvironmentVariables
        case environmentVariables = "EnvironmentVariables"
        
        // Run Conditions
        /// RunAtLoad
        case runAtLoad = "RunAtLoad"
        /// StartInterval
        case startInterval = "StartInterval"
        /// StartCalendarInterval
        case startCalendarInterval = "StartCalendarInterval"
        /// StartOnMount
        case startOnMount = "StartOnMount"
        /// OnDemand
        case onDemand = "OnDemand"
        /// KeepAlive
        case keepAlive = "KeepAlive"
        /// WatchPaths
        case watchPaths = "WatchPaths"
        /// QueueDirectories
        case queueDirectories = "QueueDirectories"
        
        // Security
        /// Umask
        case umask = "Umask"
        /// SessionCreate
        case sessionCreate = "SessionCreate"
        /// GroupName
        case groupName = "GroupName"
        /// UserName
        case userName = "UserName"
        /// InitGroups
        case initGroups = "InitGroups"
        /// RootDirectory
        case rootDirectory = "RootDirectory"
        
        // Run Constriants
        /// LaunchOnlyOnce
        case launchOnlyOnce = "LaunchOnlyOnce"
        /// LimitLoadToSessionType
        case limitLoadToSessionType = "LimitLoadToSessionType"
        /// LimitLoadToHosts
        case limitLoadToHosts = "LimitLoadToHosts"
        /// LimitLoadFromHosts
        case limitLoadFromHosts = "LimitLoadFromHosts"
        
        // Control
        /// AbandonProcessGroup
        case abandonProcessGroup = "AbandonProcessGroup"
        /// EnablePressuredExit
        case enablePressuredExit = "EnablePressuredExit"
        /// EnableTransactions
        case enableTransactions = "EnableTransactions"
        /// ExitTimeOut
        case exitTimeOut = "ExitTimeOut"
        /// inetdCompatibility
        case inetdCompatibility = "inetdCompatibility"
        /// HardResourceLimits
        case hardResourceLimits = "HardResourceLimits"
        /// SoftResourceLimits
        case softResourceLimits = "SoftResourceLimits"
        /// TimeOut
        case timeOut = "TimeOut"
        /// ThrottleInterval
        case throttleInterval = "ThrottleInterval"
        
        // IPC
        /// MachServices
        case machServices = "MachServices"
        
        // Debug
        /// Debug
        case debug = "Debug"
        /// WaitForDebugger
        case waitForDebugger = "WaitForDebugger"
        
        // Performance
        /// LegacyTimers
        case legacyTimers = "LegacyTimers"
        /// LowPriorityIO
        case lowPriorityIO = "LowPriorityIO"
        /// LowPriorityBackgroundIO
        case lowPriorityBackgroundIO = "LowPriorityBackgroundIO"
        /// Nice
        case nice = "Nice"
        /// ProcessType
        case processType = "ProcessType"
        
    }
    
}

