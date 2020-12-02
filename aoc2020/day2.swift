//
//  day2.swift
//  aoc2020
//
//  Created by Dan on 02/12/2020.
//

import Foundation

struct Rule {
    let atLeast: Int
    let atMost: Int
    let character: String
}

func strToRule(str: String) -> Rule {
    let split = str.split(separator: " ")
    let vals = split[0].split(separator: "-")
    return Rule(atLeast: Int(vals[0])!, atMost: Int(vals[1])!, character: String(split[1]))
}

func ruleMatch(rule: Rule, str: String) -> Bool {
    let num = str.filter { String($0) == rule.character }.count
    return num >= rule.atLeast && num <= rule.atMost
}

func ruleMatch2(rule: Rule, str: String) -> Bool {
    return (str.atPos(i: rule.atLeast - 1) == rule.character)
        ^^ (str.atPos(i: rule.atMost - 1) == rule.character)
}

class Day2 : Day {
    
    var input: [(Rule, String)]
    
    override init() {
        self.input = []
        // read the file
        let path = FileManager.default.homeDirectoryForCurrentUser.path + "/aoc2020input/day2.txt"
        let data = try! String(contentsOfFile: path, encoding: .utf8)
        // remove empty string at the end of the file
        let inp = data.components(separatedBy: .newlines).filter{ $0 != "" }
        // convert each line to a (Rule, String) pair.
        self.input = inp.map { $0.split(separator: ":") }.map { (strToRule(str: String($0[0])), String($0[1]).trimmingCharacters(in: .whitespaces)) }
    }
    
    override func partA() -> String {
        let validPasses = self.input.filter { ruleMatch(rule: $0, str: $1) }
        return String(validPasses.count)
    }
    
    override func partB() -> String {
        let validPasses = self.input.filter { ruleMatch2(rule: $0, str: $1) }
        return String(validPasses.count)
    }
}
