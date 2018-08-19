//
//  Event.swift
//  THESimulatorFramework
//
//  Created by Homero Oliveira on 19/08/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

public enum EventType {
    case arrival
    case exit
}

public struct Event {
    let type: EventType
    let time: Double
}
