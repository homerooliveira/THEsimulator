//
//  Queu.swift
//  THESimulatorFramework
//
//  Created by Homero Oliveira on 22/08/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

public final class Queue: Equatable {
    public enum Output {
        case exit(percentage: Double)
        case transition(to: Queue, percentage: Double)
    }
    
    public let id: String
    public let numberOfServer: Int
    public let numberOfStates: Int
    public let arrivalRange: ClosedRange<Double>
    public let exitRange: ClosedRange<Double>
    public var states: [Double]
    public var size: Int = 0
    public var outputs: [Output]
    
    public init(id: String,
                numberOfServer: Int,
                numberOfStates: Int,
                arrivalRange: ClosedRange<Double>,
                exitRange: ClosedRange<Double>,
                outputs: [Output] = []) {
        self.id = id
        self.numberOfServer = numberOfServer
        self.numberOfStates = numberOfStates
        self.arrivalRange = arrivalRange
        self.exitRange = exitRange
        self.states = Array(repeating: 0, count: numberOfStates + 1)
        self.outputs = outputs
    }
    
    public func accountForProbabilities(event: Event, time: TimeInterval) {
        states[size] = event.time - time + states[size]
    }
    
    public static func == (lhs: Queue, rhs: Queue) -> Bool {
        return lhs.numberOfServer == rhs.numberOfServer
                && lhs.numberOfStates == rhs.numberOfStates
                && lhs.arrivalRange == rhs.arrivalRange
                && lhs.exitRange == rhs.exitRange
                && lhs.states == rhs.states
        
    }
}

extension Array where Element == Queue {
    public func accountForProbabilities(event: Event, time: TimeInterval) {
        forEach { (queue) in
            queue.accountForProbabilities(event: event, time: time)
        }
    }
}

extension Queue.Output {
    var percentage: Double {
        switch self {
        case .exit(let percentage):
            return percentage
        case .transition(_, let percentage):
            return percentage
        }
    }
}
