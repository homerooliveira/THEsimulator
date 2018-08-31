//
//  LinearCongruentialGenerator.swift
//  THESimulatorFramework
//
//  Created by Homero Oliveira on 26/08/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

public final class LinearCongruentialGenerator: RandomStrategy {
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
        return randomNumber / m
    }
}
