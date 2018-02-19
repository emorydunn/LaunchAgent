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

public enum StartWeekday: Int, Codable {
    case monday = 1
    case tuesday = 2
    case wednesday = 3
    case thursday = 4
    case friday = 5
    case saturday = 6
    case sunday = 7
}
