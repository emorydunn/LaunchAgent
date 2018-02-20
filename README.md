# LaunchAgent

LaunchAgent provides an easy way to programatically create and maintain [`launchd`][launchd] agents and daemons without needing to manually build Property Lists. 

[launchd]: http://www.launchd.info

## LaunchAgent

A LaunchAgent can be createdinstantiated with either an array of program arguments:
```swift
LaunchAgent(label: "local.PythonServer", program: ["python", "-m", "SimpleHTTPServer", "8000"])
```

or with variadic parameters:
```swift
LaunchAgent(label: "local.PythonServer", program: "python", "-m", "SimpleHTTPServer", "8000")
```

The agent can also be created with only a label, but will be invalid if loaded:
```swift
LaunchAgent(label: "local.PythonServer")
```

### Using LaunchControl to read and write LaunchAgents

The `LaunchControl` class can read and write agents from and to `~/Library/LaunchAgents`. 
When using either method the `url` of the loaded agent will be set. 

### Controlling LaunchAgents

LaunchAgent has `load()`, `unload()`, `start()`, `stop()`, and `status()` methods which do what they say on the tin. 

Load & unload require the agent's URL parameter to be set, or `launchctl` won't be able to locate them. 
Start, stop, and status are called based on the label. 


## Supported Keys

LaunchAgent does not currently support all keys, and there are some caveats to some keys it does support. 

Most parameters in the `LaunchAgent` class are optional, and setting `nil` will remove the key from the encoded plist. 
Some keys use their own type to encapsulate a complex dictionary value.

## Basic Config
| Key Name         | Key type | Supported | Notes |
|------------------|----------|-----------|-------|
| Label            | String   | true      | |
| Disabled         | String   | true      | |
| Program          | String   | true      | Either `Program` or `ProgramArguments` can be set. |
| ProgramArguments | [String] | true      | Either `Program` or `ProgramArguments` can be set. |
| EnableGlobbing   | Bool     | true      | deprecated in macOS |

### Program
| Key Name             | Key type         | Supported | Notes |
|----------------------|------------------|-----------|-------|
| workingDirectory     | String           | true      | |
| standardInPath       | String           | true      | |
| standardOutPath      | String           | true      | |
| standardErrorPath    | String           | true      | |
| environmentVariables | [String: String] | true      | |

### Run Conditions
| Key Name              | Key type              | Supported | Notes |
|-----------------------|-----------------------|-----------|-------|
| runAtLoad             | Bool                  | true     | |
| startInterval         | Int                   | true     | |
| startCalendarInterval | StartCalendarInterval | true     | |
| startOnMount          | Bool                  | true     | |
| onDemand              | Bool                  | true     | |
| keepAlive             | Bool                  | true     | |
| watchPaths            | [String]              | true     | |
| queueDirectories      | [String]              | true     | |

### Security
| Key Name | Key type | Supported | Notes |
|----------|----------|-----------|-------|
| umask    | Int      | true      | user must provide decimal version of the permission octal |

### Run Constriants
| Key Name               | Key type | Supported | Notes |
|------------------------|----------|-----------|-------|
| launchOnlyOnce         | Bool     | true      | |
| limitLoadToSessionType | [String] | true      | Always encodes as an array |
| limitLoadToHosts       | [String] | true      | |
| limitLoadFromHosts     | [String] | true      | |


### Control
| Key Name            | Key type           | Supported | Notes |
|---------------------|--------------------|-----------|-------|
| AbandonProcessGroup | Bool               | true      |       |
| EnablePressuredExit | Bool               | true      |       |
| EnableTransactions  | Bool               | true      |       |
| ExitTimeOut         | Int                | true      |       |
| inetdCompatibility  | inetdCompatibility | true      |       |
| HardResourceLimits  | ResourceLimits     | true      |       |
| SoftResourceLimits  | ResourceLimits     | true      |       |
| TimeOut             | Int                | true      |       |
| ThrottleInterval    | Int                | true      |       |

### IPC
| Key Name     | Key type | Supported | Notes |
|--------------|----------|-----------|-------|
| MachServices |          | false     |       |
| Sockets      |          | false     |       |


### Debug
| Key Name        | Key type | Supported | Notes |
|-----------------|----------|-----------|-------|
| Debug           | Bool     | true      | Deprecated |
| WaitForDebugger | Bool     | true      |            |

### Performance
| Key Name                | Key type         | Supported | Notes |
|-------------------------|------------------|-----------|-------|
| LegacyTimers            | Bool             | true      | |
| LowPriorityIO           | Bool             | true      | |
| LowPriorityBackgroundIO | Bool             | true      | |
| Nice                    | Int              | true      | |
| ProcessType             | ProcessType enum | true      | |


## Custom Key Classes

### StartCalendarInterval

The `StartCalendarInterval` encapsulates the dictionary for setting calendar-based job intervals. 
By default all values are set to`nil`, meaning the job will run on any occurrence of that value. 

The Month and Weekday keys are represented by enums for each month and week, respectively. 
Day, Hour, and Minute values are simply integers. They are checked for validity in their 
respective time ranges, and will be set to the minimum or maximum value depending on which way they were out of bounds. 

## inetdCompatibility

Encapsulates the `inetdCompatibility` `wait` key. 

## ResourceLimits

Encapsulates the SoftResourceLimits and HardResourceLimits keys: 

- cPU
- core
- data
- fileSize
- memoryLock
- numberOfFiles
- numberOfProcesses
- residentSetSize
- stack


