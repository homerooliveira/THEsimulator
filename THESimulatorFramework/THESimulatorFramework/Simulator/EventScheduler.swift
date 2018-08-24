//
//  Queue.swift
//  THESimulatorFramework
//
//  Created by Homero Oliveira on 19/08/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

public final class EventScheduler {
    var agenda: [Event] = []
    public var lostEvents: Int = 0
    public var time: Double = 0
    public var queue: Queue
    public let randomStartegy: RandomStrategy
    
    public init(queue: Queue, initialArrivalTime: Double, randomStartegy: RandomStrategy = LinearCongruentialGenerator()) {
        self.queue = queue
        self.agenda = [Event(type: .arrival, time: initialArrivalTime)]
        self.randomStartegy = randomStartegy
    }
    
    func accountForProbabilities(event: Event) {
        queue.states[queue.size] = event.time - time + queue.states[queue.size]
        time = event.time
    }
    
    func schedule(for type: EventType, time: Double) {
        let event = Event(type: type, time: time)
        precondition(event.time > self.time, "event.time = \(event.time) - globalTime = \(self.time)")
        agenda.insertOrdered(elem: event)
    }
    
    func executeArrival(event: Event) {
        accountForProbabilities(event: event)
        if queue.size < queue.numberOfStates {
            queue.size += 1
            if queue.size <= queue.numberOfServer {
                schedule(for: .exit, time: time + randomStartegy.conversion(queue.exitRange))
            }
        } else {
            lostEvents += 1
        }
        schedule(for: .arrival, time: time + randomStartegy.conversion(queue.arrivalRange))
    }
    
    func executeExit(event: Event) {
        accountForProbabilities(event: event)
        queue.size -= 1
        if queue.size >= queue.numberOfServer {
            schedule(for: .exit, time: time + randomStartegy.conversion(queue.exitRange))
        }
    }
    
    @discardableResult
    public func execute(iterations: Int) -> [[String]] {
        for _ in 0..<iterations {
            let event = agenda.remove(at: 0)
            switch event.type {
            case .arrival:
                executeArrival(event: event)
            case .exit:
                executeExit(event: event)
            }
        }
        
        var statesAsString = queue.states.enumerated().map { (index, state) in
            "state \(index)| \(state) | \((state / time) * 100 )%"
        }
        statesAsString.append("total: \(time) | 100%")
        
        let agendaAsString = agenda.enumerated().map { (index, event) in
            "\(index) - \(event.type) \(event.time)"
        }
        
        let lostEventsString = "lostEvents - \(lostEvents)"
        return [statesAsString, agendaAsString, [lostEventsString]]
    }
}
