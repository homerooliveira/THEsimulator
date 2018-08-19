import Foundation
import THESimulatorFramework

var queue = Queue(numberOfStates: 4, numberOfServer: 1)
queue.execute(iterations: 1_000_000)[0]
    .forEach { print($0) }


