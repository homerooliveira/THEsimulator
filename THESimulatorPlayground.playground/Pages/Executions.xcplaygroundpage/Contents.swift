import Foundation
import THESimulatorFramework

let randomNumbers: [Double] = [ 0.5876, 0.1421, 0.8794, 0.2003, 0.0021, 0.5783, 0.3256]
let random = CustomRandom(randomNumbers)

let queue = Queue(numberOfServer: 2, numberOfStates: 3, arrivalRange: 1...2, exitRange: 3...6)
let scheduler = EventScheduler(queue: queue, initialArrivalTime: 2)

let executeInfo = scheduler.execute(iterations: 5)

print(executeInfo)