//
//  ProgressViewController.swift
//  Cleverfit
//
//  Created by Jose Luis Molina on 2/4/17.
//  Copyright © 2017 SebastianAndersen. All rights reserved.
//

import UIKit
import Charts

class ProgressViewController: CleverFitViewController {

    @IBOutlet weak var barChartView: BarChartView!
    
    var months: [String]!
    var dataEntries: [BarChartDataEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "PROGRESS_VIEW_TITLE".localized

        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        setChart(dataPoints: months, values: unitsSold)
        
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart."
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [values[i]])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        
        let chartData = BarChartData(dataSet: chartDataSet)
        
        barChartView.data = chartData
        
        // VIEW
        
        chartDataSet.colors = [UIColor.white]
        barChartView.tintColor = UIColor.white
        barChartView.drawBarShadowEnabled = false
        barChartView.borderLineWidth = 0.0
        barChartView.drawValueAboveBarEnabled = false
        barChartView.xAxis.axisLineWidth = 0.0
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.drawLabelsEnabled = false
        barChartView.rightAxis.enabled = false
        barChartView.leftAxis.enabled = false
        barChartView.legend.enabled = false
        
    }
    
}
