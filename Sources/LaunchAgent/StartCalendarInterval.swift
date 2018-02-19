//
//  StartCalendarInterval.swift
//  LaunchAgentPackageDescription
//
//  Created by Emory Dunn on 2018-02-19.
//

import Foundation

public class StartCalendarInterval: Codable {
    
    public var month: Int?
    public var weekday: Int?
    
    public var day: Int?
    public var hour: Int?
    public var minute: Int?
    
    public init(month: Int? = nil, weekday: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil) {
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
