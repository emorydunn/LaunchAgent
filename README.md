# LaunchAgent

LaunchAgent provides an easy way to programatically create and maintain [`launchd`][launchd] agents and daemons without needing to manually build Property Lists. 

[launchd]: http://www.launchd.info

## Supported Keys

LaunchAgent does not currently support all keys, and there are some caveats to some keys it does support. 

Most parameters in the `LaunchAgent` class are optional, and setting `nil` will remove the key from the encoded plist. 
Some keys use their own type to encapsulate a complex dictionary value. 

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
| Key Name            | Key type | Supported | Notes |
|---------------------|----------|-----------|-------|
| AbandonProcessGroup | Bool     | false     |       |
| EnablePressuredExit | Bool     | false     |       |
| EnableTransactions  | Bool     | false     |       |
| ExitTimeOut         | Int      | false     |       |
| inetdCompatibility  | Bool     | false     |       |
| HardResourceLimits  |          | false     |       |
| SoftResourceLimits  |          | false     |       |
| TimeOut             | Int      | false     |       |
| ThrottleInterval    | Int      | false     |       |

### IPC
| Key Name     | Key type | Supported | Notes |
|--------------|----------|-----------|-------|
| MachServices |          | false     |       |
| Sockets      |          | false     |       |


### Debug
| Key Name        | Key type | Supported | Notes |
|-----------------|----------|-----------|-------|
| Debug           | Bool     | false     | Deprecated |
| WaitForDebugger | Bool     | false     |            |

### Performance
| Key Name                | Key type | Supported | Notes |
|-------------------------|----------|-----------|-------|
| LegacyTimers            | Bool     | false     | |
| LowPriorityIO           | Bool     | false     | |
| LowPriorityBackgroundIO | Bool     | false     | |
| Nice                    | Int      | false     | |
| ProcessType             | String   | false     | |


## Custom Key Classes

### StartCalendarInterval

The `StartCalendarInterval` encapsulates the dictionary for setting calendar-based job intervals. 
By default all values are set to`nil`, meaning the job will run on any occurrence of that value. 

The Month and Weekday keys are represented by enums for each month and week, respectively. 
Day, Hour, and Minute values are simply integers. They are checked for validity in their 
respective time ranges, and will be set to the minimum or maximum value depending on which way they were out of bounds. 

