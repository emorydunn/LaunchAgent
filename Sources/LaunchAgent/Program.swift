//
//  Program.swift
//  LaunchAgent
//
//  Created by Emory Dunn on 2018-02-19.
//

import Foundation

class Program: Codable {
    
    var program: String? = nil {
        didSet {
            if program != nil {
                ProgramArguments = nil
            }
            
        }
    }
    
    var ProgramArguments: [String]? = nil {
        didSet {
            guard let args = ProgramArguments else {
                return
            }
            
            if args.count == 1 {
                self.program = args.first
                ProgramArguments = nil
            } else {
                program = nil
            }
            
        }
    }
    
    init(program: String) {
        self.program = program
    }
    
    init(program: [String]) {
        if program.count == 1 {
            self.program = program.first
        } else {
            self.ProgramArguments = program
        }
        
    }
    
    convenience init(program: String...) {
        self.init(program: program)
    }
    
}

extension Program: CustomStringConvertible {
    var description: String {
        return program ?? ProgramArguments?.joined(separator: " ") ?? "<no program set>"
    }
}
