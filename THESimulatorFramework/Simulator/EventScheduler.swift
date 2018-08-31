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
    var history: ContiguousArray<Event> = []
    var executeEvents: ContiguousArray<Event> = []
    var lostEvents: Int = 0
    var time: Double = 0
    var queue: Queue
    public let randomStartegy: RandomStrategy
    
    public init(queue: Queue, initialArrivalTime: Double, randomStartegy: RandomStrategy = LinearCongruentialGenerator()) {
        self.queue = queue
        self.agenda = [Event(type: .arrival, time: initialArrivalTime)]
        self.history = [Event(type: .arrival, time: initialArrivalTime)]
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
        history.append(event)
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
    
    public func execute(iterations: Int) -> ExecutionInfo {
        for _ in 0..<iterations {
            let event = agenda.remove(at: 0)
            executeEvents.append(event)
            switch event.type {
            case .arrival:
                executeArrival(event: event)
            case .exit:
                executeExit(event: event)
            }
        }
        
        return ExecutionInfo(agenda: agenda,
                             executeEvents: executeEvents,
                             history: history,
                             lostEvents: lostEvents,
                             time: time,
                             states: queue.states
        )
    }
}
