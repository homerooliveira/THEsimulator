//: [Previous](@previous)

import Foundation
import PlaygroundSupport
import THESimulatorFramework
import Charts

let chartView = ScatterChartView.makeDefault(frame: CGRect(origin: .zero, size: CGSize(width: 400, height: 400)))

let random: RandomStrategy = CocoaRandom()
chartView.setRandomStrategy(random, iterations: 1_000)

PlaygroundPage.current.liveView = chartView

//: [Next](@next)
