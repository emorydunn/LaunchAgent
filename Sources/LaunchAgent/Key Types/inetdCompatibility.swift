//
//  inetdCompatibility.swift
//  LaunchAgent
//
//  Created by Emory Dunn on 2018-02-20.
//

import Foundation

/// The presence of this key specifies that the daemon expects to be run as
/// if it were launched from inetd.
///
/// - Important: For new projects, this key should be avoided.
public class inetdCompatibility: Codable {
    
    /// This flag corresponds to the "wait" or "nowait" option of inetd.
    ///
    /// If true, then the listening socket is passed via the `stdio(3)` file
    /// descriptors. If false, then `accept(2)` is called on behalf of the
    /// job, and the result is passed via the `stdio(3)` descriptors.
    public var wait: Bool
    
    /// Instantiate a new object
    public init(wait: Bool) {
        self.wait = wait
    }
    
    /// launchd.plist keys
    public enum CodingKeys: String, CodingKey {
        /// Wait
        case wait = "Wait"
    }
}
