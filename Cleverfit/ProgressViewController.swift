//
//  ProgressViewController.swift
//  Cleverfit
//
//  Created by Jose Luis Molina on 2/4/17.
//  Copyright © 2017 Jose Luis Molina. All rights reserved.
//

import UIKit
import Charts

// TODO - IMPROVE DESIGN
class ProgressViewController: CleverFitViewController {

    @IBOutlet weak var barChartView: BarChartView!
    
    var dataEntries: [BarChartDataEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = LocalizedString.ProgressView.title
        
        generateChart()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showNavigationBar()
    }
    
    func generateChart() {
        var points = [String]()
        var units = [Double]()
        let entries: [ProgressLogEntry]? = DatabaseManager.sharedInstance.load()
        
        if entries != nil {
            for entry in entries! {
                units.append(entry.weight)
                points.append(String(Calendar.current.component(.month, from: entry.date as Date)))
            }
        }
        
        setChart(dataPoints: points, values: units)

    }
    
    
    func setChart(dataPoints: [String], values: [Double]) {
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [values[i]])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: LocalizedString.ProgressView.month)
        let chartData = BarChartData(dataSet: chartDataSet)
        
        barChartView.data = chartData
        
        chartDataSet.colors = [UIColor.white]
        barChartView.chartDescription?.text = LocalizedString.ProgressView.weightEvolution
        barChartView.chartDescription?.textColor = UIColor.white
        barChartView.tintColor = UIColor.white
        barChartView.noDataTextColor = UIColor.white
        barChartView.borderColor = UIColor.white
        barChartView.drawBarShadowEnabled = false
        barChartView.drawValueAboveBarEnabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.drawLabelsEnabled = false
        barChartView.rightAxis.enabled = false
        barChartView.leftAxis.enabled = false
        barChartView.legend.enabled = false
        barChartView.borderLineWidth = 0.0
        barChartView.xAxis.axisLineWidth = 0.0

    }

    
}
