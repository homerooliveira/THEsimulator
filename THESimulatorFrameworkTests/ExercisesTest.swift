//
//  Exercise1Test.swift
//  THESimulatorFrameworkTests
//
//  Created by Homero Oliveira on 19/08/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import XCTest
@testable import THESimulatorFramework

class ExercisesTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testExercise1() {
        let randomNumbers: [Double] = [0.1195, 0.3491, 0.9832, 0.7731, 0.8935, 0.2103, 0.0392, 0.1782]
        let random = CustomRandom(randomNumbers)
        
        let queue = Queue(id: 1, numberOfServer: 1, numberOfStates: 4, arrivalRange: 2...3, exitRange: 3...5)
        let scheduler = EventScheduler(queues: [queue],
                                       initialEvents: [Event(type: .arrival(to: queue),
                                                             time: 2.5)],
                                       randomStartegy: random)
        
        let executeInfo = scheduler.execute(iterations: 7)
        
        let expectedStates = [2.5, 4.8830, 5.3820, 0.0, 0.0]
        
        XCTAssertEqual(expectedStates.count, executeInfo.queues.first?.states.count)
        
        zip(expectedStates, executeInfo.queues.first?.states ?? []).forEach { (expected, state) in
            XCTAssertEqual(expected, state, accuracy: 0.0000000001)
        }
        
        XCTAssertEqual(12.7650, scheduler.time, accuracy: 0.0000000001)
    }
    
    func testExercise2() {
        let randomNumbers: [Double] = [ 0.5876, 0.1421, 0.8794, 0.2003, 0.0021, 0.5783, 0.3256]
        let random = CustomRandom(randomNumbers)
        
        let queue = Queue(id: 1, numberOfServer: 2, numberOfStates: 3, arrivalRange: 1...2, exitRange: 3...6)
        let scheduler = EventScheduler(queues: [queue],
                                       initialEvents: [Event(type: .arrival(to: queue),
                                                             time: 2)],
                                       randomStartegy: random)
        
        let executeInfo = scheduler.execute(iterations: 5)
        
        let expectedStates = [2.0, 1.1421, 1.2003, 2.4204]
        
        XCTAssertEqual(expectedStates.count, executeInfo.queues.first?.states.count)
        
        zip(expectedStates, executeInfo.queues.first?.states ?? []).forEach { (expected, state) in
            XCTAssertEqual(expected, state, accuracy: 0.0000000001)
        }
        
        XCTAssertEqual(6.7628, scheduler.time, accuracy: 0.0000000001)
    }
}
