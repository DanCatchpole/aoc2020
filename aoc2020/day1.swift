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
        // can remove anything bigger than the gap if we have to use the smallest item
        let filtered = self.input.filter {$0 < 2020 - self.input[0]}
        for i in 0..<filtered.count {
            let curr = filtered[i]
            if filtered[(i+1)...].contains(2020 - curr) {
                return String(curr * (2020 - curr))
            }
        }
        return ""
    }

    override func partB() -> String {
        // can remove anything bigger than the gap if we use the smallest two items
        let filtered = self.input.filter {$0 < 2020 - self.input[0] - self.input[1]}
        for i in 0..<filtered.count {
            let curr1 = filtered[i]
            for j in i+1..<filtered.count {
                let curr2 = filtered[j]
                let lookingFor = 2020 - curr1 - curr2
                
                if filtered[(j+1)...].contains(lookingFor) {
                    return String(curr1 * curr2 * (lookingFor))
                }
            }
        }
        return ""
    }

}

