import Foundation


enum EventType {
    case arrival
    case exit
}

struct Event {
    let type: EventType
    let time: Double
}

var count: Int = 0
var randomNumbers: [Double] = [0.1195, 0.3491, 0.9832, 0.7731, 0.8935, 0.2103, 0.0392, 0.1782]

func random() -> Double {
    return Double(arc4random()) / Double(UInt32.max)
    defer {
       count += 1
    }
    return randomNumbers[count]
}

func conversion(lowerBound: Double, upperBound: Double) -> Double {
    return (upperBound - lowerBound) * random() + lowerBound
}

struct Queue {
    
    var agenda: [Event] = [Event(type: .arrival, time: 2.5)]
    var sizeOfQueue: Int = 0
    var states: [Double] = Array(repeating: 0, count: 5)
    var time: Double = 0
    var currentEvent: Event?

    
    mutating func accountForProbabilities() {
    guard let event = currentEvent else {
                    return
    }
    states[sizeOfQueue] = event.time - time + states[sizeOfQueue]
    time = event.time
}


    mutating func schedule(for type: EventType, time: Double) {
    agenda.append(Event(type: type, time: time))
}

    mutating func executeArrival() {
    accountForProbabilities()
    if sizeOfQueue < 4 {
        sizeOfQueue += 1
        if sizeOfQueue <= 1 {
            schedule(for: .exit, time: time + conversion(lowerBound: 3, upperBound: 5))
        }
    }
    schedule(for: .arrival, time: time + conversion(lowerBound: 2, upperBound: 3))
}

    mutating func executeExit() {
    accountForProbabilities()
    sizeOfQueue -= 1
    if sizeOfQueue >= 1 {
        schedule(for: .exit, time: time + conversion(lowerBound: 3, upperBound: 5))
    }
}
    mutating func execute(){
        for i in 0..<1000 {
            currentEvent = agenda.filter({ $0.time > time })
                .min(by: { $0.time < $1.time })
            if let event = currentEvent {
                switch event.type {
                case .arrival:
                    executeArrival()
                case .exit:
                    executeExit()
                }
            }
        }
        states.enumerated().forEach { (index, state) in
            print("state \(index): \((states[index] / time) * 100 )")
        }
        print("total: \(time)")
        print()
        agenda.forEach { (event) in
            print("\(event.type) \(event.time)")
        }
    }
}

var queue = Queue()
queue.execute()


