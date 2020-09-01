//
//  File Permissions.swift
//  LaunchAgent
//
//  Created by Emory Dunn on 2018-04-06.
//

import Foundation

/** Individual permission bits for read, write, and execute.

 ## Unix Permissions
 - Read: 4
 - Write: 2
 - Execute: 1

 In addition you can get the [umask](http://www.tutonics.com/2012/12/linux-file-permissions-chmod-umask.html) value.
 
*/
public struct PermissionBits: OptionSet, Codable, CustomStringConvertible {
    
    /// Raw value
    public let rawValue: Int
    
    /// Read permission bit
    public static let read = PermissionBits(rawValue: 4)
    
    /// Write permission bit
    public static let write = PermissionBits(rawValue: 2)
    
    /// Execute permission bit
    public static let execute = PermissionBits(rawValue: 1)
    
    
    /// `umask` value
    public var umaskValue: Int {
        return 7 - self.rawValue
    }
    
    /// Set permissions from a permission octal digit
    ///
    /// - Parameter rawValue: permission octal digit
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    /// Set permissions from a umask octal digit
    ///
    /// - Parameter umaskValue: umask octal digit
    public init(umaskValue: Int) {
        self.rawValue = (7 - umaskValue)
    }
    
    /// The symbolic representation of the permissions
    public var description: String {
        let r = self.contains(.read) ? "r" : "-"
        let w = self.contains(.write) ? "w" : "-"
        let x = self.contains(.execute) ? "x" : "-"
        return r + w + x
        
    }
}

/// Represents the permissions on a file
public class FilePermissions: CustomStringConvertible {
    
    /// User permissions
    public var user: PermissionBits
    
    /// Group permissions
    public var group: PermissionBits
    
    /// Other permissions
    public var other: PermissionBits
    
    /// Init from `PermissionBit`s
    ///
    /// - Parameters:
    ///   - user: user permissions
    ///   - group: group permissions
    ///   - other: other permissions
    public required init(user: PermissionBits, group: PermissionBits, other: PermissionBits) {
        self.user = user
        self.group = group
        self.other = other
    }
    
    /** Init from an integer, either decimal or octal.
     
    To use an octal representation, such as 755 enter `0o755`.
     
    To use an decimal representation, such as 488 enter `488`.
    
    - Parameter number: number representation of the permissions
    */
    public convenience init(_ number: Int) {
        let octal = String(number, radix: 8)
        let padded = octal.leftPadding(toLength: 3, withPad: "0")
        
        let userDigit = String(padded[0])
        let user = PermissionBits(rawValue: Int(userDigit)!)
        
        let groupDigit = String(padded[1])
        let group = PermissionBits(rawValue: Int(groupDigit)!)
        
        let otherDigit = String(padded[2])
        let other = PermissionBits(rawValue: Int(otherDigit)!)
        
        self.init(user: user, group: group, other: other)
        
    }
    
    /// The permissions octal, e.g. 755
    public var octal: String {
        let octal = String(decimal, radix: 8)
        return octal.leftPadding(toLength: 3, withPad: "0")
    }
    
    /// Decimal representation of the permissions, e.g. 488
    public var decimal: Int {
        let userO =     user.rawValue    * 64
        let groupO =    group.rawValue   * 8
        let otherO =    other.rawValue   * 1
        
        return userO + groupO + otherO
    }
    
    /// Symbolic representation of the permissions, e.g. -rwxr-xr-x
    public var symbolic: String {
        return "-" + user.description + group.description + other.description
    }
    
    /// The symbolic representation of the permissions
    public var description: String {
        return "Permissions u+\(user), g+\(group), o+\(other)"
    }
}

extension FilePermissions {
    
    /** Init from an umask integer, either decimal or octal.
     
    Each digit in the octal is subtracted from 7 to get its value.
     
    To use an octal representation, such as 027 enter `0o027`.
     
    To use an decimal representation, such as 23 enter `23`.
     
    - Parameter number: number representation of the permissions
     */
    public convenience init(umask number: Int) {
        let octal = String(number, radix: 8)
        let padded = octal.leftPadding(toLength: 3, withPad: "0")
        
        let userDigit = String(padded[0])
        let user = PermissionBits(umaskValue: Int(userDigit)!)
        
        let groupDigit = String(padded[1])
        let group = PermissionBits(umaskValue: Int(groupDigit)!)
        
        let otherDigit = String(padded[2])
        let other = PermissionBits(umaskValue: Int(otherDigit)!)
        
        self.init(user: user, group: group, other: other)
        
    }
    
    /// The umask octal, e.g. 027
    public var umaskOctal: String {
        let octal = String(umaskDecimal, radix: 8)
        return octal.leftPadding(toLength: 3, withPad: "0")
    }
    
    /// Decimal representation of the umask octal, e.g. 23
    public var umaskDecimal: Int {
        let userO =     user.umaskValue    * 64
        let groupO =    group.umaskValue   * 8
        let otherO =    other.umaskValue   * 1
        
        return userO + groupO + otherO
    }
    
}
