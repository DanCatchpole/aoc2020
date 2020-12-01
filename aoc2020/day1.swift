//
//  day1.swift
//  aoc2020
//
//  Created by Dan on 01/12/2020.
//

import Foundation

class Day1 : Day {
    
    var input: [Int]
    
    override init() {
        // read the file
        let path = FileManager.default.homeDirectoryForCurrentUser.path + "/aoc2020input/day1a.txt"
        let data = try! String(contentsOfFile: path, encoding: .utf8)
        // remove empty string at the end of the file
        let input = data.components(separatedBy: .newlines).filter{ $0 != "" }
        // map them to integers
        self.input = input.map{ Int($0)! }
        self.input.sort()
    }
    
    override func partA() -> String {
        for i in 0..<self.input.count {
            let curr = self.input[i]
            if self.input[i...].contains(2020 - curr) {
                return String(curr * (2020 - curr))
            }
        }
        return ""
    }

    override func partB() -> String {
        for i in 0..<self.input.count {
            let curr1 = self.input[i]
            for j in i+1..<self.input.count {
                let curr2 = self.input[j]
                let sumSoFar = curr1 + curr2
                
                if self.input[(j+1)...].contains(2020 - sumSoFar) {
                    return String(curr1 * curr2 * (2020 - sumSoFar))
                }
            }
        }
        return ""
    }

}

