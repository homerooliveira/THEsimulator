//
//  Parser.swift
//  THESimulatorFramework
//
//  Created by Homero Oliveira on 11/10/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

public final class FileParser {
    
    public init() {
    }
    
    public func parse(fileName: String) -> (initialEvents: [Event], queues: [Queue]) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "txt") else {
            fatalError("Arquivo não encontrado.")
        }
        
        var queues: [Substring: Queue] = [:]
        var initialEvents: [Event] = []
        
        do {
            let content = try String(contentsOf: url, encoding: .utf8).split(separator: "\n")
            
            for line in content {
                let words = line.split(separator: " ")
                let fromWord = words[0]
                
                if (words.count == 3 || words.count == 4),
                   let from = queues[fromWord]  {
                    let to = words[2]
                    if words[1] == "->" {
                        let percentage = words.last.flatMap { Double($0) } ?? 1
                        if to == "exit" {
                            from.outputs.append(.exit(percentage: percentage))
                        } else if let to = queues[to] {
                            from.outputs.append(.transition(to: to, percentage: percentage))
                        }
                    } else if words[1] == "CH", let time = Double(words[2]) {
                        initialEvents.append(Event(type: .arrival(to: from), time: time))
                    }
                } else if words.count == 5,
                    let numberOfServers = Int(words[1]),
                    let numberOfStates = Int(words[2]) {
                    let arrivalRangeString = words[3].split(separator: "-")
                    let exitRangeString = words[4].split(separator: "-")
                    
                    guard let lowerBoundArrivalRange = arrivalRangeString.first.flatMap({ Double($0) }),
                        let upperBoundArrivalRange = arrivalRangeString.last.flatMap({ Double($0) }),
                        let lowerBoundExitRange = exitRangeString.first.flatMap({ Double($0) }),
                        let upperBoundExitRange = exitRangeString.last.flatMap ({ Double($0) }) else  {
                            continue
                    }
                    
                    let queue = Queue(id: String(fromWord),
                                      numberOfServer: numberOfServers,
                                      numberOfStates: numberOfStates,
                                      arrivalRange: lowerBoundArrivalRange...upperBoundArrivalRange,
                                      exitRange: lowerBoundExitRange...upperBoundExitRange)
                    queues[fromWord] = queue
                } else {
                    print(line)
                    print("Linha inválida.")
                }
            }
        } catch {
            fatalError(error.localizedDescription)
        }
        
        let queuesFrom = Array(queues.values.sorted(by: { $0.id < $1.id }))
        
        for queue in queuesFrom {
            queue.outputs.sort(by: { $0.percentage < $1.percentage })
        }
        
        return (initialEvents, queuesFrom)
    }
}
