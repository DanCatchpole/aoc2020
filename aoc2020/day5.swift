//
//  day5.swift
//  aoc2020
//
//  Created by Dan on 06/12/2020.
//

import Foundation

class Day5 : Day {
    
    var input: [String]
    
    var numRows = 128
    var numCols = 8
    
    override init() {
        self.input = []
        let path = FileManager.default.homeDirectoryForCurrentUser.path + "/aoc2020input/day5.txt"
        let data = try! String(contentsOfFile: path, encoding: .ascii)
        // remove empty string at the end of the file
        self.input = data.components(separatedBy: .newlines).filter{ $0 != "" }
    }
    
    func stringToID(str: String) -> Int {
        var possibleRows = Array(0...127)
        var possibleCols = Array(0...7)
        for char in str {
            if char == "B" {
                possibleRows = Array(possibleRows.dropFirst(possibleRows.count/2))
            }
            if char == "F" {
                possibleRows = Array(possibleRows.dropLast(possibleRows.count/2))
            }
            if char == "R" {
                possibleCols = Array(possibleCols.dropFirst(possibleCols.count/2))
            }
            if char == "L" {
                possibleCols = Array(possibleCols.dropLast(possibleCols.count/2))

            }
        }
        return possibleRows[0] * 8 + possibleCols[0]
    }
    
    override func partA() -> String {
        return String(self.input.map {stringToID(str: $0)}.max()!)
    }
    
    override func partB() -> String {
        let possibleSeats = Array(0...(127*8 + 7))
        let actualSeats = self.input.map {stringToID(str: $0)}
        return String(possibleSeats.filter { actualSeats.contains($0 - 1) && actualSeats.contains($0 + 1) && !actualSeats.contains($0) }[0])
    }

}
