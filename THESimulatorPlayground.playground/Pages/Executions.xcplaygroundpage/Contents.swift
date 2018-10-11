import Foundation
import THESimulatorFramework

//let randomNumbers: [Double] = [0.2176, 0.0103, 0.1109, 0.3456, 0.9910, 0.2323, 0.9211, 0.0322,
//                              0.1211, 0.5131, 0.7208, 0.9172, 0.9922, 0.8324, 0.5011, 0.2931]
//let random = CustomRandom(randomNumbers)

let queue2 = Queue(id: 2, numberOfServer: 1, numberOfStates: 4, arrivalRange: 4...7, exitRange: 4...8)
let queue = Queue(id: 1, numberOfServer: 2, numberOfStates: 4, arrivalRange: 2...3, exitRange: 4...7, outputs: [  .exit(percentage: 0.3), .transition(to: queue2, percentage: 0.7)])
let scheduler = EventScheduler(queues: [queue, queue2],
                               initialEvents: [Event(type: .arrival(to: queue),
                                                     time: 3)])

let executeInfo = scheduler.execute(iterations: 100)

executeInfo.executeEvents
    .forEach { (event) in
        print(event)
}

executeInfo.queues
    .forEach { (queue) in
        print(queue.states)
}
