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
//    return Double(arc4random()) / Double(UInt32.max)
    defer {
       count += 1
    }
    return randomNumbers[count]
}

func conversion(lowerBound: Double, upperBound: Double) -> Double {
    return (upperBound - lowerBound) * random() + lowerBound
}

var agenda: [Event] = [Event(type: .arrival, time: 2.5)]
var sizeOfQueue: Int = 0
var states: [Double] = [0, 0, 0, 0, 0]
var time: Double = 0

func accountForProbabilities() {
    guard let event = agenda.filter({ $0.time > time })
        .min(by: { $0.time < $1.time }) else {
                    return
    }
    states[sizeOfQueue] = event.time
    time = event.time
//    print("event: \(event.type)")
//    print("state: \(states)")
//    print("time: \(time)")
}

func scheduleExit(time: Double) {
    agenda.append(Event(type: .exit, time: time))
}

func scheduleArrival(time: Double) {
    agenda.append(Event(type: .arrival, time: time))
}

func executeArrival() {
    accountForProbabilities()
    if sizeOfQueue < 4 {
        sizeOfQueue += 1
        if sizeOfQueue <= 1 {
            scheduleExit(time: time + conversion(lowerBound: 3, upperBound: 5))
        }
    }
    scheduleArrival(time: time + conversion(lowerBound: 2, upperBound: 3))
}

func executeExit() {
    accountForProbabilities()
    sizeOfQueue -= 1
    if sizeOfQueue >= 1 {
        scheduleExit(time: time + conversion(lowerBound: 3, upperBound: 5))
    }
}

for i in 0..<7 {
    if let event = agenda.filter({ $0.time > time })
        .min(by: { $0.time < $1.time }) {
//        print("\(i) - \(event.type) - \(event.time) - currentTime: \(time)")
        switch event.type {
        case .arrival:
            executeArrival()
        case .exit:
            executeExit()
        }
    }
}

print("states: \(states)")
print("final time: \(time)")
agenda.forEach { (event) in
    print("\(event.type) \(event.time)")
}
