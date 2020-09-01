//
//  ProcessType.swift
//  LaunchAgent
//
//  Created by Emory Dunn on 2/19/18.
//

import Foundation

/// This optional key describes, at a high level, the intended purpose of the
/// job.
///
/// The system will apply resource limits based on what kind of job it
/// is. If left unspecified, the system will apply light resource limits to
/// the job, throttling its CPU usage and I/O bandwidth. This classification
/// is preferable to using the HardResourceLimits, SoftResourceLimits and
/// Nice keys.
public enum ProcessType: String, Codable {
    
    /// Standard jobs are equivalent to no ProcessType being set.
    case standard = "Standard"
    
    /// Background jobs are generally processes that do work that was not
    /// directly requested by the user.
    ///
    /// The resource limits applied to
    /// Background jobs are intended to prevent them from disrupting the
    /// user experience.
    case background = "Background"
    
    /// Adaptive jobs move between the Background and Interactive
    /// classifications based on activity over XPC connections.
    ///
    /// See `xpc_transaction_begin(3)` for details.
    case adaptive = "Adaptive"
    
    /// Interactive jobs run with the same resource limitations as apps,
    /// that is to say, none.
    ///
    /// Interactive jobs are critical to maintaining
    /// a responsive user experience, and this key should only be used if
    /// an app's ability to be responsive depends on it, and cannot be made
    /// Adaptive.
    case interactive = "Interactive"
}
