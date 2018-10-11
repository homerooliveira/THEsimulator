import Foundation
import THESimulatorFramework


let parser = FileParser()
let (initialEvents, queues) = parser.parse(fileName: "example")

let scheduler = EventScheduler(queues: queues, initialEvents: initialEvents)
let executeInfo = scheduler.execute(iterations: 1_000_000)


executeInfo.queues
    .forEach { (queue) in
        print("id: \(queue.id) states: \(queue.states.map({ ($0 / executeInfo.time) * 100 }))")
}
print("Global Time: \(executeInfo.time)")
print("Lost Events: \(executeInfo.lostEvents)")
