import Foundation
import THESimulatorFramework

let queue = Queue(numberOfServer: 1, numberOfStates: 4, arrivalRange: 2...3, exitRange: 3...5)
let scheduler = EventScheduler(queue: queue, initialArrivalTime: 2.5)
let executions = scheduler.execute(iterations: 1_000_000)
executions[0].forEach { print($0) }
executions[1].forEach { print($0) }
executions[2].forEach { print($0) }

//let randomNumbers: [Double] = [0.1195, 0.3491, 0.9832, 0.7731, 0.8935, 0.2103, 0.0392, 0.1782]
//let random = CustomRandom(randomNumbers)
//let queue = Queue(numberOfStates: 4, numberOfServer: 1, randomStartegy: random)
//queue.execute(iterations: randomNumbers.count - 1)[0]
//    .forEach { print($0) }

