//
//  Queu.swift
//  THESimulatorFramework
//
//  Created by Homero Oliveira on 22/08/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

public struct Queue {
    public let numberOfServer: Int
    public let numberOfStates: Int
    public let arrivalRange: ClosedRange<Double>
    public let exitRange: ClosedRange<Double>
    public var states: [Double]
    public var size: Int = 0
    
    public init(numberOfServer: Int,
         numberOfStates: Int,
         arrivalRange: ClosedRange<Double>,
         exitRange: ClosedRange<Double>) {
        self.numberOfServer = numberOfServer
        self.numberOfStates = numberOfStates
        self.arrivalRange = arrivalRange
        self.exitRange = exitRange
        self.states = Array(repeating: 0, count: numberOfStates + 1)
    }
    
    public mutating func updateState(with time: Double) {
        
    }
}
