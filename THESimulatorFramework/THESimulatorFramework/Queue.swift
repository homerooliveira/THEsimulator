//
//  Queue.swift
//  THESimulatorFramework
//
//  Created by Homero Oliveira on 19/08/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

public final class Queue {
    
    var agenda: [Event] = [Event(type: .arrival, time: 2.5)]
    public var sizeOfQueue: Int = 0
    public var states: [Double]
    public var time: Double = 0
    let numberOfStates: Int
    let numberOfServer: Int
    let randomStartegy: RandomStrategy
    
    public init(numberOfStates: Int, numberOfServer: Int, randomStartegy: RandomStrategy = CocoaRandom()) {
        self.numberOfStates = numberOfStates
        self.numberOfServer = numberOfServer
        states = Array(repeating: 0, count: numberOfStates + 1)
        self.randomStartegy = randomStartegy
    }
    
    func accountForProbabilities(event: Event) {
        states[sizeOfQueue] = event.time - time + states[sizeOfQueue]
        time = event.time
    }
    
    
    func schedule(for type: EventType, time: Double) {
        agenda.append(Event(type: type, time: time))
    }
    
    func executeArrival(event: Event) {
        accountForProbabilities(event: event)
        if sizeOfQueue < numberOfStates {
            sizeOfQueue += 1
            if sizeOfQueue <= numberOfServer {
                schedule(for: .exit, time: time + randomStartegy.conversion(3...5))
            }
        }
        schedule(for: .arrival, time: time + randomStartegy.conversion(2...3))
    }
    
    func executeExit(event: Event) {
        accountForProbabilities(event: event)
        sizeOfQueue -= 1
        if sizeOfQueue >= numberOfServer {
            schedule(for: .exit, time: time + randomStartegy.conversion(3...5))
        }
    }
    
    @discardableResult
    public func execute(iterations: Int) -> [[String]] {
        for _ in 0..<iterations {
            agenda = agenda.filter({ $0.time > time })
            if let event = agenda.min(by: { $0.time < $1.time }) {
                switch event.type {
                case .arrival:
                    executeArrival(event: event)
                case .exit:
                    executeExit(event: event)
                }
            }
        }
        
        
        var statesAsString = states.enumerated().map { (index, state) in
            "state \(index)| \(state) | \((state / time) * 100 )%"
        }
        statesAsString.append("total: \(time) | 100%")
        
        let agendaAsString = agenda.enumerated().map { (index, event) in
            "\(index) - \(event.type) \(event.time)"
        }
        
        return [statesAsString, agendaAsString]
    }
}
