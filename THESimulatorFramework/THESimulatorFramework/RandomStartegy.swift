//
//  RandomStartegy.swift
//  THESimulatorFramework
//
//  Created by Homero Oliveira on 19/08/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

public protocol RandomStartegy {
    func random() -> Double
}

public extension RandomStartegy {
    func conversion(_ range: ClosedRange<Double>) -> Double {
        return (range.upperBound - range.lowerBound) * random() + range.lowerBound
    }
}

public final class CustomRandom: RandomStartegy {
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
    public init (){
        
    }
    
    public func random() -> Double {
        return Double(arc4random()) / Double(UInt32.max)
    }
}
