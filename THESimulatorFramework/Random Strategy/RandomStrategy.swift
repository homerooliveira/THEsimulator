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
