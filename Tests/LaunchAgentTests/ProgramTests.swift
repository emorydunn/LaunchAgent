//
//  ProgramTests.swift
//  LaunchAgentTests
//
//  Created by Emory Dunn on 2018-02-19.
//

import XCTest
import LaunchAgent

class ProgramTests: XCTestCase {

    // MARK: Test Init
    
    func test_Init_StringArray() {
        let testProgram = LaunchAgent(program: ["Program", "--arg"])
        
        XCTAssertNil(testProgram.program)
        XCTAssertNotNil(testProgram.programArguments)
        XCTAssertEqual(testProgram.programArguments!, ["Program", "--arg"])
    }
    
    func test_Init_SingleStringArray() {
        let testProgram = LaunchAgent(program: ["SingleString"])
        
        XCTAssertEqual(testProgram.program, "SingleString")
        XCTAssertNil(testProgram.programArguments)
    }
    
    func test_Init_SingleString() {
        let testProgram = LaunchAgent(program: "SingleString")
        
        XCTAssertEqual(testProgram.program, "SingleString")
        XCTAssertNil(testProgram.programArguments)
    }
    
    func test_Init_VariadicString() {
        let testProgram = LaunchAgent(program: "Program", "--arg")
        
        XCTAssertNil(testProgram.program)
        XCTAssertNotNil(testProgram.programArguments)
        XCTAssertEqual(testProgram.programArguments!, ["Program", "--arg"])
    }
    
    // Mark: Test Description
    
//    func test_Description_Program() {
//        let testProgram = LaunchAgent(program: "SingleString")
//
//        XCTAssertEqual(testProgram.description, "SingleString")
//    }
//
//    func test_Description_ProgramArgumanets() {
//        let testProgram = LaunchAgent(program: "Program", "--arg")
//
//        XCTAssertEqual(testProgram.description, "Program --arg")
//    }
//
//    func test_Description_NilProgram() {
//        let testProgram = LaunchAgent(program: "")
//
//        testProgram.program = nil
//        testProgram.programArguments = nil
//
//        XCTAssertEqual(testProgram.description, "<no program set>")
//
//    }
    
    // MARK: Test Program didSet
    
    func test_SetSingleProgram() {
        let testProgram = LaunchAgent(program: ["Many", "Args"])
        
        XCTAssertNil(testProgram.program)
        XCTAssertNotNil(testProgram.programArguments)
        
        testProgram.program = "SingleProgram"
        
        XCTAssertNil(testProgram.programArguments)
        XCTAssertEqual(testProgram.program, "SingleProgram")
        
    }
    
    func test_SetProgramArguments_SingleArray() {
        let testProgram = LaunchAgent(program: "SingleProgram")
        
        XCTAssertNotNil(testProgram.program)
        XCTAssertNil(testProgram.programArguments)
        
        testProgram.programArguments = ["NewSingleProgram"]
        
        XCTAssertEqual(testProgram.program, "NewSingleProgram")
        XCTAssertNil(testProgram.programArguments)
        
    }
    
    func test_SetProgramArguments_Array() {
        let testProgram = LaunchAgent(program: "SingleProgram")
        
        XCTAssertNotNil(testProgram.program)
        XCTAssertNil(testProgram.programArguments)
        
        testProgram.programArguments = ["NewProgram", "--arg"]
        
        XCTAssertNil(testProgram.program, "NewSingleProgram")
        XCTAssertNotNil(testProgram.programArguments)
        XCTAssertEqual(testProgram.programArguments!, ["NewProgram", "--arg"])
        
    }

}
