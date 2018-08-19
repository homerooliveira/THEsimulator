//
//  RandomStartegy.swift
//  THESimulatorFramework
//
//  Created by Homero Oliveira on 19/08/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

var randomNumbers: [Double] = [0.1195, 0.3491, 0.9832, 0.7731, 0.8935, 0.2103, 0.0392, 0.1782]

public protocol RandomStartegy {
    func random() -> Double
}

public extension RandomStartegy {
    func conversion(_ range: ClosedRange<Double>) -> Double {
        return (range.upperBound - range.lowerBound) * random() + range.lowerBound
    }
}

public class CustomRandom: RandomStartegy {
    let randomNumbers: [Double]
    var count = 0
    
    init(_ randomNumbers: [Double]) {
        self.randomNumbers = randomNumbers
    }
    
    public func random() -> Double {
        defer {
            count += 1
        }
        return randomNumbers[count]
    }
}

public struct CocoaRandom: RandomStartegy {
    public func random() -> Double {
        return Double(arc4random()) / Double(UInt32.max)
    }
}
