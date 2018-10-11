//
//  ExcutionInfo.swift
//  THESimulatorFramework
//
//  Created by Homero Oliveira on 24/08/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

public struct ExecutionInfo {
    public let agenda: [Event]
    public let executeEvents: ContiguousArray<Event>
    public let history: ContiguousArray<Event>
    public let lostEvents: Int
    public let time: Double
    public let queues: [Queue]
}
