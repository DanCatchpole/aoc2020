//
//  main.swift
//  aoc2020
//
//  Created by Dan on 01/12/2020.
//

import Foundation

/**
 Add XOR for booleans
 */
infix operator ^^
extension Bool {
    static func ^^(lhs:Bool, rhs:Bool) -> Bool {
        if (lhs && !rhs) || (!lhs && rhs) {
            return true
        }
        return false
    }
}

/**
 Add the possibility to get a single character in a position in a string, wrapped as a string to facilitate easy comparisons
 */
extension String {
    func atPos(i: Int) -> String {
        if let index = self.index(self.startIndex, offsetBy: i, limitedBy: self.endIndex) {
            return String(self[index])
        } else {
            return ""
        }
    }
}

let startPreprocessing = DispatchTime.now().uptimeNanoseconds
var currentDay : Day = Day3()
let startA = DispatchTime.now().uptimeNanoseconds
let ansA = currentDay.partA();
let startB = DispatchTime.now().uptimeNanoseconds
let ansB = currentDay.partB();
let endB = DispatchTime.now().uptimeNanoseconds

print("Read + preprocess in (ms): " + String(Double(startA - startPreprocessing) / 1000000))
print("A: " + ansA + " in (ms): " + String(Double(startB - startA) / 1000000))
print("B: " + ansB + " in (ms): " + String(Double(endB - startB) / 1000000))
