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
        let testProgram = Program(program: ["Program", "--arg"])
        
        XCTAssertNil(testProgram.program)
        XCTAssertNotNil(testProgram.ProgramArguments)
        XCTAssertEqual(testProgram.ProgramArguments!, ["Program", "--arg"])
    }
    
    func test_Init_SingleStringArray() {
        let testProgram = Program(program: ["SingleString"])
        
        XCTAssertEqual(testProgram.program, "SingleString")
        XCTAssertNil(testProgram.ProgramArguments)
    }
    
    func test_Init_SingleString() {
        let testProgram = Program(program: "SingleString")
        
        XCTAssertEqual(testProgram.program, "SingleString")
        XCTAssertNil(testProgram.ProgramArguments)
    }
    
    func test_Init_VariadicString() {
        let testProgram = Program(program: "Program", "--arg")
        
        XCTAssertNil(testProgram.program)
        XCTAssertNotNil(testProgram.ProgramArguments)
        XCTAssertEqual(testProgram.ProgramArguments!, ["Program", "--arg"])
    }
    
    // Mark: Test Description
    
    func test_Description_Program() {
        let testProgram = Program(program: "SingleString")
        
        XCTAssertEqual(testProgram.description, "SingleString")
    }
    
    func test_Description_ProgramArgumanets() {
        let testProgram = Program(program: "Program", "--arg")
        
        XCTAssertEqual(testProgram.description, "Program --arg")
    }
    
    func test_Description_NilProgram() {
        let testProgram = Program(program: "")
        
        testProgram.program = nil
        testProgram.ProgramArguments = nil
        
        XCTAssertEqual(testProgram.description, "<no program set>")
        
    }
    
    // MARK: Test Program didSet
    
    func test_SetSingleProgram() {
        let testProgram = Program(program: ["Many", "Args"])
        
        XCTAssertNil(testProgram.program)
        XCTAssertNotNil(testProgram.ProgramArguments)
        
        testProgram.program = "SingleProgram"
        
        XCTAssertNil(testProgram.ProgramArguments)
        XCTAssertEqual(testProgram.program, "SingleProgram")
        
    }
    
    func test_SetProgramArguments_SingleArray() {
        let testProgram = Program(program: "SingleProgram")
        
        XCTAssertNotNil(testProgram.program)
        XCTAssertNil(testProgram.ProgramArguments)
        
        testProgram.ProgramArguments = ["NewSingleProgram"]
        
        XCTAssertEqual(testProgram.program, "NewSingleProgram")
        XCTAssertNil(testProgram.ProgramArguments)
        
    }
    
    func test_SetProgramArguments_Array() {
        let testProgram = Program(program: "SingleProgram")
        
        XCTAssertNotNil(testProgram.program)
        XCTAssertNil(testProgram.ProgramArguments)
        
        testProgram.ProgramArguments = ["NewProgram", "--arg"]
        
        XCTAssertNil(testProgram.program, "NewSingleProgram")
        XCTAssertNotNil(testProgram.ProgramArguments)
        XCTAssertEqual(testProgram.ProgramArguments!, ["NewProgram", "--arg"])
        
    }

}
