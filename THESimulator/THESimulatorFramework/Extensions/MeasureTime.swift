//
//  MesureTime.swift
//  THESimulatorFramework
//
//  Created by Homero Oliveira on 23/08/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

public func measureTime(_ block: () -> Void) {
    let start = DispatchTime.now()
    block()
    let end = DispatchTime.now()
    let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
    let timeInterval = Double(nanoTime) / 1_000_000_000
    print("Time to evaluate \(timeInterval) seconds")
}
