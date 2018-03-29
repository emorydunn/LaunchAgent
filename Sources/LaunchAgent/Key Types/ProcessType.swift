//
//  ProcessType.swift
//  LaunchAgent
//
//  Created by Emory Dunn on 2/19/18.
//

import Foundation

public enum ProcessType: String, Codable {
    case standard = "Standard"
    case background = "Background"
    case adaptive = "Adaptive"
    case interactive = "Interactive"
}
