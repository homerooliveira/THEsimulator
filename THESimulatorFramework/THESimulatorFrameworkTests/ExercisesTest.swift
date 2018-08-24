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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testExercise1() {
        let randomNumbers: [Double] = [0.1195, 0.3491, 0.9832, 0.7731, 0.8935, 0.2103, 0.0392, 0.1782]
        let random = CustomRandom(randomNumbers)
        let queue = Queue(numberOfServer: 1, numberOfStates: 4, arrivalRange: 2...3, exitRange: 3...5)
        let scheduler = EventScheduler(queue: queue, initialArrivalTime: 2.5, randomStartegy: random)
        scheduler.execute(iterations: randomNumbers.count - 1)
        
        let expectedStates = [2.5, 4.8830, 5.3820, 0.0, 0.0]
        XCTAssertEqual(expectedStates.count, scheduler.queue.states.count)
        expectedStates.enumerated().forEach { (index, expectedState) in
            XCTAssertEqual(expectedState, scheduler.queue.states[index], accuracy: 0.0000000001)
        }
        XCTAssertEqual(12.7650, scheduler.time, accuracy: 0.0000000001)
    }
    
    func testExercise2() {
        let randomNumbers: [Double] = [0.1195, 0.3491, 0.9832, 0.7731, 0.8935, 0.2103, 0.0392, 0.1782]
        let random = CustomRandom(randomNumbers)
        let queue = Queue(numberOfServer: 1, numberOfStates: 4, arrivalRange: 2...3, exitRange: 3...5)
        let scheduler = EventScheduler(queue: queue, initialArrivalTime: 2.5, randomStartegy: random)
        scheduler.execute(iterations: randomNumbers.count - 1)
        
        let expectedStates = [2.5, 4.8830, 5.3820, 0.0, 0.0]
        XCTAssertEqual(expectedStates.count, scheduler.queue.states.count)
        expectedStates.enumerated().forEach { (index, expectedState) in
            XCTAssertEqual(expectedState, scheduler.queue.states[index], accuracy: 0.0000000001)
        }
        XCTAssertEqual(12.7650, scheduler.time, accuracy: 0.0000000001)
    }
}
