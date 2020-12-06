//
//  day4.swift
//  aoc2020
//
//  Created by Dan on 04/12/2020.
//

import Foundation

class Day4 : Day {
    
    var input: [[String : String]]
    
    let requiredKeys = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
    
    let HCLregex: NSRegularExpression = try! NSRegularExpression(pattern: "#([a-f0-9]{6})", options: .caseInsensitive)
    
    let validECLs = ["amb","blu","brn","gry","grn","hzl", "oth"]
   
    override init() {
        self.input = []
        let path = FileManager.default.homeDirectoryForCurrentUser.path + "/aoc2020input/day4.txt"
        let data = try! String(contentsOfFile: path, encoding: .ascii)
        // remove empty string at the end of the file
        self.input = data.components(separatedBy: "\n\n").map { $0.replacingOccurrences(of: "\n", with: " ") }.filter{ $0 != "" }
            .map { $0.components(separatedBy: " ").reduce([String: String]()) { (dict, a: String) -> [String: String] in
                let splt = a.split(separator: ":")
                var dict = dict
                dict[String(splt[0])] = String(splt[1])
                return dict
            } }
    }
    
    func containsRequired(dict: [String: String]) -> Bool {
        return requiredKeys.allSatisfy { el -> Bool in dict.keys.contains(el)}
    }
    
    func validBYR(_ byr: String) -> Bool { byr.count == 4 && Int(byr)! >= 1920 && Int(byr)! <= 2002 }
    func validIYR(_ iyr: String) -> Bool { iyr.count == 4 && Int(iyr)! >= 2010 && Int(iyr)! <= 2020 }
    func validEYR(_ eyr: String) -> Bool { eyr.count == 4 && Int(eyr)! >= 2020 && Int(eyr)! <= 2030 }
    func validHGT(_ hgt: String) -> Bool {
        if let val = Int(hgt.prefix(hgt.count - 2)) {
            if hgt.hasSuffix("cm") {
                return val >= 150 && val <= 193
            } else if hgt.hasSuffix("in") {
                return val >= 59 && val <= 76
            }
            return false
        }
        return false
    }
    func validHCL(_ hcl: String) -> Bool { self.HCLregex.firstMatch(in: hcl, options: [], range: NSRange(location: 0, length: hcl.count)) != nil }
    func validECL(_ ecl: String) -> Bool { self.validECLs.contains(ecl) }
    func validPID(_ pid: String) -> Bool { pid.count == 9 && Int(pid) != nil }
    
    func isValid(dict: [String: String]) -> Bool {
        if !containsRequired(dict: dict) {
            return false
        }
        return validBYR(dict["byr"]!) && validIYR(dict["iyr"]!)
            && validEYR(dict["eyr"]!) && validHGT(dict["hgt"]!)
            && validHCL(dict["hcl"]!) && validECL(dict["ecl"]!)
            && validPID(dict["pid"]!)
    }
    
    override func partA() -> String {
        return String(self.input.filter {containsRequired(dict: $0)}.count)
    }
    
    override func partB() -> String {
        return String(self.input.filter {isValid(dict: $0)}.count)
    }
    
}
