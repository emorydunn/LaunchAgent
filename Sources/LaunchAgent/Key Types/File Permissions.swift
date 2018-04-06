//
//  File Permissions.swift
//  LaunchAgent
//
//  Created by Emory Dunn on 2018-04-06.
//

import Foundation

public struct PermissionBits: OptionSet, Codable, CustomStringConvertible {
    public let rawValue: Int
    
    public static let read = PermissionBits(rawValue: 4)
    public static let write = PermissionBits(rawValue: 2)
    public static let execute = PermissionBits(rawValue: 1)
    
    public var macOctal: Int {
        return 7 - self.rawValue
    }
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public init(macOctal: Int) {
        self.rawValue = (7 - macOctal)
    }
    
    public var description: String {
        let r = self.contains(.read) ? "r" : ""
        let w = self.contains(.write) ? "w" : ""
        let x = self.contains(.execute) ? "x" : ""
        return r + w + x
        
    }
}

public class FilePermissions: CustomStringConvertible {
    public var user: PermissionBits
    public var group: PermissionBits
    public var other: PermissionBits
    
    public required init(user: PermissionBits, group: PermissionBits, other: PermissionBits) {
        self.user = user
        self.group = group
        self.other = other
    }
    
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
    
    public var octal: String {
        let octal = String(decimal, radix: 8)
        return octal.leftPadding(toLength: 3, withPad: "0")
    }
    
    public var decimal: Int {
        let userO =     user.rawValue    * 64
        let groupO =    group.rawValue   * 8
        let otherO =    other.rawValue   * 1
        
        return userO + groupO + otherO
    }
    
    public var symbolic: String {
        var perms: [String] = []
        
        if !user.isEmpty { perms.append("u+\(user)") }
        if !group.isEmpty { perms.append("g+\(group)") }
        if !other.isEmpty { perms.append("o+\(other)") }
        
        return perms.joined(separator: ",")
    }
    
    public var description: String {
        return "Permissions \(symbolic)"
    }
}

// The file permissions octal for LaunchAgents are inverted from unix
extension FilePermissions {
    
    public convenience init(mac number: Int) {
        let octal = String(number, radix: 8)
        let padded = octal.leftPadding(toLength: 3, withPad: "0")
        
        let userDigit = String(padded[0])
        let user = PermissionBits(macOctal: Int(userDigit)!)
        
        let groupDigit = String(padded[1])
        let group = PermissionBits(macOctal: Int(groupDigit)!)
        
        let otherDigit = String(padded[2])
        let other = PermissionBits(macOctal: Int(otherDigit)!)
        
        self.init(user: user, group: group, other: other)
        
    }
    
    public var macOctal: String {
        let octal = String(macDecimal, radix: 8)
        return octal.leftPadding(toLength: 3, withPad: "0")
    }
    
    public var macDecimal: Int {
        let userO =     user.macOctal    * 64
        let groupO =    group.macOctal   * 8
        let otherO =    other.macOctal   * 1
        
        return userO + groupO + otherO
    }
    
}

extension FilePermissions: Encodable {
    
    enum CodingKeys: String {
        case decimal
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
    }
}
