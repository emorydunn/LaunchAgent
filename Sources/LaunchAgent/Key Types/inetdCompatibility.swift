//
//  inetdCompatibility.swift
//  LaunchAgent
//
//  Created by Emory Dunn on 2018-02-20.
//

import Foundation

public class inetdCompatibility: Codable {
    public var wait: Bool
    
    public init(wait: Bool) {
        self.wait = wait
    }
    
    public enum CodingKeys: String, CodingKey {
        case wait = "Wait"
    }
}
