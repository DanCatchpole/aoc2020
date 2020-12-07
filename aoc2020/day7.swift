//
//  day7.swift
//  aoc2020
//
//  Created by Dan on 07/12/2020.
//

import Foundation

class Bag {
    let color: String
    var holds: [(Int, Bag)]
    
    init(color: String) {
        self.color = color
        self.holds = []
    }
    
    
}

class Day7 : Day {
        
    // Dictionary of String -> Bag
    var input: [String: Bag]
    
    override init() {
        // -- Read in the file --
        var input: [String: Bag] = Dictionary()
        let path = FileManager.default.homeDirectoryForCurrentUser.path + "/aoc2020input/day7.txt"
        let data = try! String(contentsOfFile: path, encoding: .ascii)
        // remove empty string at the end of the file
        let inp = data.components(separatedBy: .newlines).filter{$0 != ""}
        
        // -- Actual preprocessing from now --
        // Add all the bags to our list first so we have them ready to reference
        for str in inp {
            let split = str.components(separatedBy: " bags contain ")
            let color = split[0]
            input[color] = Bag(color: color)
        }
        // loop again to build up our tree of references
        for str in inp {
            let split = str.components(separatedBy: " bags contain ")
            let color = split[0]
            let contains = split[1]
            if contains != "no other bags." {
                // we contain some more bags
                // remove the 'bags', 'bag' and the full stop so we have strings of the form "1 light gray"
                let bags = contains.components(separatedBy: ", ").map{$0.replacingOccurrences(of: " bags", with: "").replacingOccurrences(of: " bag", with: "").replacingOccurrences(of: ".", with: "")}
                let amt = bags.map { (bag: String) -> (Int, Bag) in
                    // split only on the first space so we have a number and a colour
                    let s = bag.split(maxSplits: 1, omittingEmptySubsequences: false, whereSeparator: {$0 == " "})
                    return (Int(s[0])!, input[String(s[1])]!)
                }
                input[color]!.holds.append(contentsOf: amt)
            }
        }
        self.input = input
    }
    
    func recursivelyHolds(bag: Bag, color: String) -> Bool {
        if bag.holds.count == 0 {
            return false
        } else if bag.holds.contains(where: {$1.color == color}) {
            return true
        } else {
            for (_, newBag) in bag.holds {
                if recursivelyHolds(bag: newBag, color: color) {
                    return true
                }
            }
        }
        return false
    }
    
    func recursiveCount(bag: Bag) -> Int {
        if bag.holds.count == 0 {
            return 1
        } else {
            var currentCount = 1
            for (count, newBag) in bag.holds {
                currentCount += count * recursiveCount(bag: newBag)
            }
            return currentCount
        }
    }
        
    override func partA() -> String {
        return String(self.input.filter{ self.recursivelyHolds(bag: $1, color: "shiny gold")}.count )
    }
    
    override func partB() -> String {
        // -1 for the gold bag, we don't hold the bag inside the bag!
        return String(self.recursiveCount(bag: self.input["shiny gold"]!) - 1)
    }
    
}
