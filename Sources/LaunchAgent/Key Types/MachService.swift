//
//  MachService.swift
//  LaunchAgent
//
//  Created by Emory Dunn on 2018-02-20.
//

import Foundation

/// This optional key is used to specify Mach services to be registered with
/// the Mach bootstrap namespace.
///
/// Each key in this dictionary should be the
/// name of a service to be advertised. The value of the key must be a
/// boolean and set to true or a dictionary in order for the service to be
/// advertised.
public class MachService: Codable {
    
    /// Reserve the name in the namespace, but cause `bootstrap_look_up()` to
    /// fail until the job has checked in with launchd.
    ///
    /// This option is incompatible with` xpc(3)`, which relies on the con-
    /// stant availability of services. This option also encourages polling
    /// for service availability and is therefore generally discouraged.
    /// Future implementations will penalize use of this option in subtle
    /// and creative ways.
    ///
    /// Jobs can dequeue messages from the MachServices they advertised
    /// with `xpc_connection_create_mach_service(3)` or `bootstrap_check_in()`
    /// API (to obtain the underlying port's receive right) and the Mach
    /// APIs to dequeue messages from that port.
    public var hideUntilCheckIn: Bool
    
    /// The default value for this key is false, and so the port is recy-
    /// cled, thus leaving clients to remain oblivious to the demand nature
    /// of the job.
    ///
    /// If the value is set to true, clients receive port death
    /// notifications when the job lets go of the receive right. The port
    /// will be recreated atomically with respect to `bootstrap_look_up()`
    /// calls, so that clients can trust that after receiving a port-death
    /// notification, the new port will have already been recreated. Set-
    /// ting the value to true should be done with care. Not all clients
    /// may be able to handle this behavior. The default value is false.
    
    /// - Note: This option is not compatible with `xpc(3)`, which automat-
    /// ically handles notifying clients of interrupted connections and
    /// server death.
    public var resetAtClose: Bool
    
    /// Instantiate a new object
    public init(hideUntilCheckIn: Bool, resetAtClose: Bool ) {
        self.hideUntilCheckIn = hideUntilCheckIn
        self.resetAtClose = resetAtClose
    }
    
    /// launchd.plist keys
    public enum CodingKeys: String, CodingKey {
        case hideUntilCheckIn = "HideUntilCheckIn"
        case resetAtClose = "ResetAtClose"
    }
    
}
