//
//  day8.swift
//  aoc2020
//
//  Created by Dan on 08/12/2020.
//

import Foundation

struct Instruction {
    var command: String
    let amt: Int
}

class Day8 : Day {
    
    var input: [Instruction]
    
    override init() {
        // read the file
        let path = FileManager.default.homeDirectoryForCurrentUser.path + "/aoc2020input/day8.txt"
        let data = try! String(contentsOfFile: path, encoding: .utf8)
        // remove empty string at the end of the file
        let inp = data.components(separatedBy: .newlines).filter{ $0 != "" }
        self.input = inp.map({ (str: String) -> Instruction in
            let split = str.components(separatedBy: " ")
            return Instruction(command: split[0], amt: Int(split[1])!)
        })
    }
    
    /**
     Run a list of instructions until either:
        It hits an instruction we've hit before (returns (accumulator, true))
        It hits the end of the program (returns (accumulator, false))
     */
    func runProg(program: [Instruction]) -> (Int, Bool) {
        var accumulator = 0
        var currentPos = 0
        var visited = program.map { (_: Instruction) -> Bool in
            return false
        }
        while currentPos < program.count && !visited[currentPos] {
            visited[currentPos] = true
            let currentInstruction = program[currentPos]
            switch currentInstruction.command {
            case "nop":
                currentPos += 1
                break
            case "acc":
                currentPos += 1
                accumulator += currentInstruction.amt
                break
            case "jmp":
                currentPos += currentInstruction.amt
                break
            default:
                currentPos += 1
            }
        }
        return (accumulator, currentPos < program.count)
    }

    override func partA() -> String {
        let (ans, finishedEarly) = self.runProg(program: self.input)
        return String(ans) + ", " + String(finishedEarly)
    }
    
    override func partB() -> String {
        for i in 0..<self.input.count {
            if self.input[i].command == "nop" || self.input[i].command == "jmp" {
                // swap it for this iteration and attempt to run
                var newProg = self.input
                if newProg[i].command == "nop" {
                    newProg[i].command = "jmp"
                } else {
                    newProg[i].command = "nop"
                }
                let (val, terminated) =  self.runProg(program: newProg)
                if !terminated {
                    return String(val)
                }
            }
        }
        return "No valid swap found"
    }
    
}
