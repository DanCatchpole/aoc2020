//
//  day6.swift
//  aoc2020
//
//  Created by Dan on 06/12/2020.
//

import Foundation

class Day6 : Day {
    
    var input: [String]
    let alphabet = "abcdefghijklmnopqrstuvwxyz"
    
    override init() {
        self.input = []
        let path = FileManager.default.homeDirectoryForCurrentUser.path + "/aoc2020input/day6.txt"
        let data = try! String(contentsOfFile: path, encoding: .ascii)
        // remove empty string at the end of the file
        self.input = data.components(separatedBy: "\n\n")
    }
    
    override func partA() -> String {
        let chars = self.input.map { Set($0.replacingOccurrences(of: "\n", with: "")).count }
    
        return String(chars.reduce(0, +))
    }
    
    override func partB() -> String {
        let grouped = self.input.map { $0.components(separatedBy: .newlines) }
        let vals = grouped.map { (lines: [String]) -> Int in
            return alphabet.filter { (letter: Character) -> Bool in
                lines.allSatisfy { (line: String) -> Bool in
                    line.contains(letter) || line == ""
            }}.count
        }
        print(grouped)
        print(vals)
        return String(vals.reduce(0, +))
    }
    
}
