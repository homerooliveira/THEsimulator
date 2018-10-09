//
//  Event.swift
//  THESimulatorFramework
//
//  Created by Homero Oliveira on 19/08/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

public enum EventType: Equatable {
    case arrival(to: Queue)
    case exit(to: Queue)
}

public struct Event: Comparable {
    let type: EventType
    let time: Double
}

public func < (lhs: Event, rhs: Event) -> Bool {
    return lhs.time < rhs.time
}

