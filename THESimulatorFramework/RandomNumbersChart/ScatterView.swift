//
//  ScatterView.swift
//  THESimulatorFramework
//
//  Created by Homero Oliveira on 22/08/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation
import Charts

public extension ScatterChartView {
    public static func makeDefault(frame: CGRect) -> ScatterChartView {
        let chartView = ScatterChartView(frame: frame)
        chartView.backgroundColor = .white
        chartView.pinchZoomEnabled = true
        chartView.xAxis.labelPosition = .bottom
        chartView.legend.enabled = false
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        
        return chartView
    }
    
    public func setRandomStrategy(_ randomStrategy: RandomStrategy, iterations: Int) {
        let values = (0..<iterations).map { ChartDataEntry(x: Double($0), y: randomStrategy.random()) }
        
        let set = ScatterChartDataSet(values: values)
        set.setColor(ChartColorTemplates.colorful()[0])
        set.setScatterShape(.cross)
        set.scatterShapeSize = 5
        
        data = ScatterChartData(dataSets: [set])
    }
}




