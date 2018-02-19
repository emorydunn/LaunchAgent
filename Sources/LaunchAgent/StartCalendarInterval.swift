//
//  StartCalendarInterval.swift
//  LaunchAgentPackageDescription
//
//  Created by Emory Dunn on 2018-02-19.
//

import Foundation

class StartCalendarInterval: Codable {
    
    var month: Int?
    var weekday: Int?
    
    var day: Int?
    var hour: Int?
    var minute: Int?
    
    init(month: Int? = nil, weekday: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil) {
        self.month = month
        self.weekday = weekday
        self.day = day
        self.hour = hour
        self.minute = minute
    }
    
}
