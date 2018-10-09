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
    var time: TimeInterval = 0
    var queues: [Queue] = []
    public let randomStartegy: RandomStrategy
    
    public init(queues: [Queue], initialEvents: [Event], randomStartegy: RandomStrategy = LinearCongruentialGenerator()) {
        self.queues = queues
        self.agenda = initialEvents
        self.history = ContiguousArray(initialEvents)
        self.randomStartegy = randomStartegy
    }
    
    func accountForProbabilities(event: Event) {
        queues.accountForProbabilities(event: event, time: time)
        time = event.time
    }
    
    func schedule(for type: EventType, time: Double) {
        let event = Event(type: type, time: time)
        precondition(event.time > self.time, "event.time = \(event.time) - globalTime = \(self.time)")
        agenda.insertOrdered(elem: event)
        history.append(event)
    }
    
    func executeArrival(event: Event, queue: Queue) {
        accountForProbabilities(event: event)
        if queue.size < queue.numberOfStates {
            queue.size += 1
            if queue.size <= queue.numberOfServer {
                if queue.outputs.isEmpty {
                    schedule(for: .exit(to: queue), time: time + randomStartegy.conversion(queue.exitRange))
                } else {
                    shedulePercentageOutpus(queue)
                }
            }
        } else {
            lostEvents += 1
        }
        schedule(for: .arrival(to: queue), time: time + randomStartegy.conversion(queue.arrivalRange))
    }
    
    fileprivate func shedulePercentageOutpus(_ queue: Queue) {
        let randomNumber = randomStartegy.random()
        var previousNumber: Double = 0
        queue
            .outputs
            .forEach { (output) in
                if previousNumber..<output.percentage ~= randomNumber {
                    if output.to == nil {
                        schedule(for: .exit(to: queue), time: time + randomStartegy.conversion(queue.exitRange))
                    } else {
                        // TODO: faz schedule para outra fila
                    }
                }
                previousNumber = output.percentage
        }
    }
    
    func executeExit(event: Event, queue: Queue) {
        accountForProbabilities(event: event)
        queue.size -= 1
        if queue.size >= queue.numberOfServer {
            schedule(for: .exit(to: queue), time: time + randomStartegy.conversion(queue.exitRange))
        }
    }
    
    public func execute(iterations: Int) -> ExecutionInfo {
        for _ in 0..<iterations {
            let event = agenda.remove(at: 0)
            executeEvents.append(event)
            switch event.type {
            case .arrival(let to):
                executeArrival(event: event, queue: to)
            case .exit(let to):
                executeExit(event: event, queue: to)
            }
        }
        
        return ExecutionInfo(agenda: agenda,
                             executeEvents: executeEvents,
                             history: history,
                             lostEvents: lostEvents,
                             time: time,
                             states: queues.first!.states
        )
    }
}
