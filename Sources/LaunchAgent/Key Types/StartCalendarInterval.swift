//
//  StartCalendarInterval.swift
//  LaunchAgentPackageDescription
//
//  Created by Emory Dunn on 2018-02-19.
//

import Foundation

/// This optional key causes the job to be started every calendar interval as
/// specified.
///
/// Missing arguments are considered to be wildcard. The semantics
/// are similar to crontab(5) in how firing dates are specified. Multiple
/// dictionaries may be specified in an array to schedule multiple calendar intervals.
///
/// Unlike cron which skips job invocations when the computer is asleep,
/// launchd will start the job the next time the computer wakes up.  If multiple
/// intervals transpire before the computer is woken, those events will
/// be coalesced into one event upon wake from sleep.
///
/// - Note: StartInterval and StartCalendarInterval are not aware of each
/// other. They are evaluated completely independently by the system.
public class StartCalendarInterval: Codable {
    
    /// The month (1-12) on which this job will be run.
    public var month: StartMonth?
    
    /// The weekday on which this job will be run (0 and 7 are Sunday).
    ///
    /// If both Day and Weekday are specificed, then the job will be started
    /// if either one matches the current date.
    public var weekday: StartWeekday?
    
    /// Day of the month
    ///
    /// - Note: Bound to `1...31`. Values outside the range will be set to the closest valid value.
    public var day: Int? {
        didSet {
            guard let newInt = day else {
                return
            }
            if newInt < 1 {
                day = 1
            } else if newInt > 31 {
                day = 31
            }
        }
    }
    
    /// Hour of the day
    ///
    /// - Note: Bound to `0...23`. Values outside the range will be set to the closest valid value.
    public var hour: Int? {
        didSet {
            guard let newInt = hour else {
                return
            }
            if newInt < 0 {
                hour = 0
            } else if newInt > 23 {
                hour = 23
            }
        }
    }
    
    /// Minute of the hour
    ///
    /// - Note: Bound to `0...59`. Values outside the range will be set to the closest valid value.
    public var minute: Int? {
        didSet {
            guard let newInt = minute else {
                return
            }
            if newInt < 0 {
                minute = 0
            } else if newInt > 59 {
                minute = 59
            }
        }
    }
    
    /// Set a calendar interval on which to start the job. `nil` values represent any occurance of that key.
    ///
    /// - Parameters:
    ///   - month: month of the year to run the job
    ///   - weekday: day of the week to run the job
    ///   - day: day of the month to run the job
    ///   - hour: hour of the day to run the job
    ///   - minute: minute of the hour to run the job
    public init(month: StartMonth? = nil, weekday: StartWeekday? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil) {
        self.month = month
        self.weekday = weekday
        self.day = day
        self.hour = hour
        self.minute = minute
    }
    
    /// launchd.plist keys
    public enum CodingKeys: String, CodingKey {
        /// Month
        case month = "Month"
        /// Weekday
        case weekday = "Weekday"
        
        /// Day
        case day = "Day"
        /// Hour
        case hour = "Hour"
        /// Minute
        case minute = "Minute"
    }
    
}

/// Represents the month in the StartCalendarInterval key
public enum StartMonth: Int, Codable {
    /// January
    case january = 1
    /// February
    case february = 2
    /// March
    case march = 3
    /// April
    case april = 4
    /// May
    case may = 5
    /// June
    case june = 6
    /// July
    case july = 7
    /// August
    case august = 8
    /// September
    case september = 9
    /// October
    case october = 10
    /// November
    case november = 11
    /// December
    case december = 12
}

/// Represents the weekday in the StartCalendarInterval key
public enum StartWeekday: Int, Codable {
    /// Monday
    case monday = 1
    /// Tuesday
    case tuesday = 2
    /// Wednesday
    case wednesday = 3
    /// Thursday
    case thursday = 4
    /// Friday
    case friday = 5
    /// Saturday
    case saturday = 6
    /// Sunday
    case sunday = 7
}
