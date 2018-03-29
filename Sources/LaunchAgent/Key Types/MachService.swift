//
//  MachService.swift
//  LaunchAgent
//
//  Created by Emory Dunn on 2018-02-20.
//

import Foundation

public class MachService: Codable {
    
    public var hideUntilCheckIn: Bool
    public var resetAtClose: Bool
    
    public init(hideUntilCheckIn: Bool, resetAtClose: Bool ) {
        self.hideUntilCheckIn = hideUntilCheckIn
        self.resetAtClose = resetAtClose
    }
    
    public enum CodingKeys: String, CodingKey {
        case hideUntilCheckIn = "HideUntilCheckIn"
        case resetAtClose = "ResetAtClose"
    }
    
}
