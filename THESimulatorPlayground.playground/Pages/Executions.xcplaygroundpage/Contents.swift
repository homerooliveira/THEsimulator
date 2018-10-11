import Foundation
import THESimulatorFramework


let parser = FileParser()
let (initialEvents, queues) = parser.parse(fileName: "example")

let scheduler = EventScheduler(queues: queues, initialEvents: initialEvents)
let executeInfo = scheduler.execute(iterations: 10)

executeInfo.queues
    .forEach { (queue) in
        print("id: \(queue.id) states: \(queue.states)")
}
