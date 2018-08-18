import Foundation


enum EventType {
    case arrival
    case exit
}

struct Event {
    let type: EventType
    let time: Double
}
struct ExecutionInfo {
    
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

func conversion(_ range: ClosedRange<Double>) -> Double {
    return (range.upperBound - range.lowerBound) * random() + range.lowerBound
}

class Queue {
    
    var agenda: [Event] = [Event(type: .arrival, time: 2.5)]
    var sizeOfQueue: Int = 0
    var states: [Double]
    var time: Double = 0
    let numberOfStates: Int
    let numberOfServer: Int
    
    init(numberOfStates: Int, numberOfServer: Int) {
        self.numberOfStates = numberOfStates
        self.numberOfServer = numberOfServer
        states = Array(repeating: 0, count: numberOfStates + 1)
    }
    
    func accountForProbabilities(event: Event) {
        guard sizeOfQueue <= 4 else {
            return
        }
        states[sizeOfQueue] = event.time - time + states[sizeOfQueue]
        time = event.time
    }
    
    
    func schedule(for type: EventType, time: Double) {
        agenda.append(Event(type: type, time: time))
    }
    
    func executeArrival(event: Event) {
        accountForProbabilities(event: event)
        if sizeOfQueue < numberOfStates {
            sizeOfQueue += 1
            if sizeOfQueue <= numberOfServer {
                schedule(for: .exit, time: time + conversion(3...5))
            }
        }
        schedule(for: .arrival, time: time + conversion(2...3))
    }
    
    func executeExit(event: Event) {
        accountForProbabilities(event: event)
        sizeOfQueue -= 1
        if sizeOfQueue >= numberOfServer {
            schedule(for: .exit, time: time + conversion(3...5))
        }
    }
    
    func execute() -> [[String]] {
        for _ in 0..<100 {
            if let event = agenda.filter({ $0.time > time })
                .min(by: { $0.time < $1.time }) {
                switch event.type {
                case .arrival:
                    executeArrival(event: event)
                case .exit:
                    executeExit(event: event)
                }
            }
        }
        
        
        var statesAsString = states.enumerated().map { (index, state) in
            "state \(index)| \(state) | \((state / time) * 100 )%"
        }
        statesAsString.append("total: \(time) | 100%")
        
        let agendaAsString = agenda.enumerated().map { (index, event) in
            "\(index) - \(event.type) \(event.time)"
        }
        
        return [statesAsString, agendaAsString]
    }
}

var queue = Queue(numberOfStates: 4, numberOfServer: 1)
print(queue.execute()[0])


