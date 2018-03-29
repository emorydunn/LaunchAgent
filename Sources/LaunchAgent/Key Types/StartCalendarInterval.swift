//
//  StartCalendarInterval.swift
//  LaunchAgentPackageDescription
//
//  Created by Emory Dunn on 2018-02-19.
//

import Foundation

public class StartCalendarInterval: Codable {
    
    public var month: StartMonth?
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
    
    public enum CodingKeys: String, CodingKey {
        case month = "Month"
        case weekday = "Weekday"
        
        case day = "Day"
        case hour = "Hour"
        case minute = "Minute"
    }
    
}

/// Represents the month in the StartCalendarInterval key
public enum StartMonth: Int, Codable {
    case january = 1
    case february = 2
    case march = 3
    case april = 4
    case may = 5
    case june = 6
    case july = 7
    case august = 8
    case september = 9
    case october = 10
    case november = 11
    case december = 12
}

/// Represents the weekday in the StartCalendarInterval key
public enum StartWeekday: Int, Codable {
    case monday = 1
    case tuesday = 2
    case wednesday = 3
    case thursday = 4
    case friday = 5
    case saturday = 6
    case sunday = 7
}
