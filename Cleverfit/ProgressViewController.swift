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
    @IBOutlet weak var imcChartView: BarChartView!
    
    var entries: [ProgressLogEntry]?
    var user: User?
    
    convenience init?(coder aDecoder: NSCoder, workoutExercise: WorkoutExercise) {
        self.init(coder: aDecoder)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.entries = DatabaseManager.sharedInstance.load()
        self.user = DatabaseManager.sharedInstance.load()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = LocalizedString.ProgressView.title
        
        generateWeightChart()
        generateIMCChart()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showNavigationBar()
    }
    
    func generateWeightChart() {
        var points = [String]()
        var units = [Double]()
        
        if entries != nil {
            for entry in entries! {
                units.append(entry.weight)
                points.append(String(Calendar.current.component(.month, from: entry.date as Date)))
            }
        }
        
        setChart(dataPoints: points, values: units, barChartView: barChartView, title: LocalizedString.ProgressView.weightEvolution)

    }
    
    func generateIMCChart() {
        var points = [String]()
        var units = [Double]()
        
        if entries != nil && user != nil {
            for entry in entries! {
                units.append(ObesityCalculator.calculateBasalMetabolism(height: Int(entry.height), weight: entry.weight, age: user!.calculateAge(), gender: user!.userGender) / 100)
                points.append(String(Calendar.current.component(.month, from: entry.date as Date)))
            }
        }
        
        setChart(dataPoints: points, values: units, barChartView: imcChartView, title: LocalizedString.ProgressView.weightEvolution)
        
    }
    
    func setChart(dataPoints: [String], values: [Double], barChartView: BarChartView, title: String) {
        var dataEntries = [BarChartDataEntry]()

        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [values[i]])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: LocalizedString.ProgressView.month)
        let chartData = BarChartData(dataSet: chartDataSet)
        
        barChartView.data = chartData
        
        chartDataSet.colors = [UIColor.white]
        barChartView.chartDescription?.text = title
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
