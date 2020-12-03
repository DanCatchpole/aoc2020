//
//  day3.swift
//  aoc2020
//
//  Created by Dan on 03/12/2020.
//

import Foundation

class Day3 : Day {
    
    var input: [[Bool]]
    var numCols: Int
    var numRows: Int
    
    override init() {
        self.input = [[Bool]]()
        let path = FileManager.default.homeDirectoryForCurrentUser.path + "/aoc2020input/day3.txt"
        let data = try! String(contentsOfFile: path, encoding: .ascii)
        // remove empty string at the end of the file
        let inp = data.components(separatedBy: .newlines).filter{ $0 != "" }
        // convert each line to a (Rule, String) pair.
        self.input = inp.map({ (a) -> [Bool] in a.map { $0 == "#" }})
        self.numCols = self.input[0].count
        self.numRows = self.input.count
    }
    
    func treesOnPath(right: Int, down: Int) -> Int64 {
        var count = 0
        var r = 0, c = 0
        while ((r + down) < self.numRows) {
            r += down
            c += right
            count += self.input[r][c % numCols] ? 1 : 0
        }
        return Int64(count)
    }
    
    override func partA() -> String {
        return String(treesOnPath(right: 3, down: 1))
    }
    
    override func partB() -> String {
        return String(treesOnPath(right: 1, down: 1)
            * treesOnPath(right: 3, down: 1)
            * treesOnPath(right: 5, down: 1)
            * treesOnPath(right: 7, down: 1)
            * treesOnPath(right: 1, down: 2))
    }
    
}
