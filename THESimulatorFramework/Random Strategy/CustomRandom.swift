//
//  CustomRandom.swift
//  THESimulatorFramework
//
//  Created by Homero Oliveira on 26/08/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

public final class CustomRandom: RandomStrategy {
    var randomNumbers: [Double] {
        didSet {
            count = 0
        }
    }
    var count = 0
    
    public init(_ randomNumbers: [Double] = []) {
        self.randomNumbers = randomNumbers
    }
    
    public func random() -> Double {
        defer {
            count += 1
        }
        
        guard count < randomNumbers.count else {
            return 0
        }
        
        return randomNumbers[count]
    }
}
