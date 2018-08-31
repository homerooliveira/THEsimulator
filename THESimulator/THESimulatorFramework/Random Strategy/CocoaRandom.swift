//
//  CocoaRandom.swift
//  THESimulatorFramework
//
//  Created by Homero Oliveira on 26/08/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

public struct CocoaRandom: RandomStrategy {
    public init (){
    }
    
    public func random() -> Double {
        return Double(arc4random()) / Double(UInt32.max)
    }
}
