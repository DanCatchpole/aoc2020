//
//  main.swift
//  aoc2020
//
//  Created by Dan on 01/12/2020.
//

import Foundation

var currentDay : Day = Day1()

let startA = DispatchTime.now().uptimeNanoseconds
let ansA = currentDay.partA();
let startB = DispatchTime.now().uptimeNanoseconds
let ansB = currentDay.partB();
let endB = DispatchTime.now().uptimeNanoseconds

print("A: " + ansA + " in (ms): " + String(Double(startB - startA) / 1000000))
print("B: " + ansB + " in (ms): " + String(Double(endB - startB) / 1000000))
