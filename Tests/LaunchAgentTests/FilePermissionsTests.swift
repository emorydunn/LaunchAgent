//
//  FilePermissionsTests.swift
//  LaunchAgentTests
//
//  Created by Emory Dunn on 2018-04-06.
//

import XCTest
@testable import LaunchAgent


class PermissionBitTests: XCTestCase {
    
    func test_init() {
        XCTAssertEqual(PermissionBits.init(rawValue: 5), [.read, .execute])
    }
    
    func test_mac_init() {
        XCTAssertEqual(PermissionBits.init(umaskValue: 2), [.read, .execute])
    }
    
    func test_mac_octal() {
        let permissions: PermissionBits = [.read, .write, .execute]
        XCTAssertEqual(permissions.umaskValue, 0)
    }
    
    func test_description() {
        let read: PermissionBits = [PermissionBits.read]
        let readWrite: PermissionBits = [PermissionBits.read, .write]
        let readWriteExecute: PermissionBits = [PermissionBits.read, .write, .execute]
        let readExecute: PermissionBits = [PermissionBits.read, .execute]
        let writeExecute: PermissionBits = [PermissionBits.write, .execute]
        
        XCTAssertEqual(read.description, "r")
        XCTAssertEqual(readWrite.description, "rw")
        XCTAssertEqual(readWriteExecute.description, "rwx")
        XCTAssertEqual(readExecute.description, "rx")
        XCTAssertEqual(writeExecute.description, "wx")
        
    }
    
}

class FilePermissionsTests: XCTestCase {

    func test_init() {
        let file = FilePermissions(user: .read, group: .write, other: .execute)
        
        XCTAssertEqual(file.user, .read)
        XCTAssertEqual(file.group, .write)
        XCTAssertEqual(file.other, .execute)
    }
    
    func test_octal_init() {
        let file = FilePermissions(0o750)
        
        XCTAssertEqual(file.user, [.read, .write, .execute])
        XCTAssertEqual(file.group, [.read, .execute])
        XCTAssertEqual(file.other, [])
    }
    
    func test_decimal_init() {
        let file = FilePermissions(488)
        
        XCTAssertEqual(file.user, [.read, .write, .execute])
        XCTAssertEqual(file.group, [.read, .execute])
        XCTAssertEqual(file.other, [])
    }
    
    func test_octal() {
        let file = FilePermissions(user: [], group: .read, other: .write)
        XCTAssertEqual(file.octal, "042")
    }
    
    func test_decimal() {
        let file = FilePermissions(0o750)
        XCTAssertEqual(file.decimal, 488)
    }
    
    func test_symbolic() {
        let file = FilePermissions(0o751)
        XCTAssertEqual(file.symbolic, "u+rwx,g+rx,o+x")
    }
    
    func test_description() {
        let file = FilePermissions(0o750)
        XCTAssertEqual(file.description, "Permissions u+rwx,g+rx")
    }

}


class MacFilePermissionsTests: XCTestCase {
    func test_octal_init() {
        let file = FilePermissions(mac: 0o027)
        
        XCTAssertEqual(file.user, [.read, .write, .execute])
        XCTAssertEqual(file.group, [.read, .execute])
        XCTAssertEqual(file.other, [])
    }
    
    func test_octal() {
        let file = FilePermissions(user: [.read, .write, .execute], group: [.write, .execute], other: [.read, .execute])
        XCTAssertEqual(file.macOctal, "042")
    }
    
    func test_decimal() {
        let file = FilePermissions(0o750)
        XCTAssertEqual(file.macDecimal, 23)
    }
}
