//
//  Program.swift
//  LaunchAgent
//
//  Created by Emory Dunn on 2018-02-19.
//

import Foundation

public class Program: Codable {
    
    public var program: String? = nil {
        didSet {
            if program != nil {
                ProgramArguments = nil
            }
            
        }
    }
    
    public var ProgramArguments: [String]? = nil {
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

    public init(program: [String]) {
        if program.count == 1 {
            self.program = program.first
        } else {
            self.ProgramArguments = program
        }
        
    }
    
    public convenience init(program: String...) {
        self.init(program: program)
    }
    
}

extension Program: CustomStringConvertible {
    public var description: String {
        return program ?? ProgramArguments?.joined(separator: " ") ?? "<no program set>"
    }
}
