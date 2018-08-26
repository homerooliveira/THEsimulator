//
//  RandomStartegy.swift
//  THESimulatorFramework
//
//  Created by Homero Oliveira on 19/08/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

public protocol RandomStrategy {
    func random() -> Double
}

public extension RandomStrategy {
    func conversion(_ range: ClosedRange<Double>) -> Double {
        return (range.upperBound - range.lowerBound) * random() + range.lowerBound
    }
}

public final class CustomRandom: RandomStrategy {
    let randomNumbers: [Double]
    var count = 0
    
    public init(_ randomNumbers: [Double]) {
        self.randomNumbers = randomNumbers
    }
    
    public func random() -> Double {
        defer {
            count += 1
        }
        if count >= randomNumbers.count {
          return 0
        }
        return randomNumbers[count]
    }
}

public struct CocoaRandom: RandomStrategy {
    public init (){
    }
    
    public func random() -> Double {
        return Double(arc4random()) / Double(UInt32.max)
    }
}

public class LinearCongruentialGenerator: RandomStrategy {
    public var previous: Double
    public let a: Double = 27644437
    public let c: Double = 11
    public let m: Double = Double(UInt64.max)
    
    public init(seed: UInt64 = DispatchTime.now().uptimeNanoseconds){
        previous = Double(seed)
    }
    
    public func random() -> Double {
        let randomNumber = (previous * a + c).truncatingRemainder(dividingBy: m)
        previous = randomNumber
        return randomNumber / Double(UInt64.max)
    }
}
