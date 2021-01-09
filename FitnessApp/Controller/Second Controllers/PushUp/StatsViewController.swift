//
//  StatsViewController.swift
//  FitnessApp
//
//  Created by Syimyk on 1/8/21.
//  Copyright © 2021 Syimyk. All rights reserved.
//

import UIKit
import RealmSwift
import Charts

class StatsViewController: UIViewController{
    
    let realm = try! Realm()
    
    @IBOutlet weak var lineChart: LineChartView!
    
    weak var axisFormatDelegate: IAxisValueFormatter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        axisFormatDelegate = self
        loadData()
        designLineChartView()
    }
    
    
    
    
    
    
    
    
    
    func loadData(){
        var dataEntries : [ChartDataEntry] = []
        let progressions = getProgressFromDataBase()
        for i in 0..<progressions.count{
            let timeIntervalForDate: TimeInterval = progressions[i].date.timeIntervalSince1970
            let dataEntry =  ChartDataEntry(x: Double(timeIntervalForDate), y: Double(progressions[i].totalPushUps))
            dataEntries.append(dataEntry)
        }
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "Total Push Ups: \(progressions.last?.totalPushUps ?? 1000)")
        chartDataSet.drawCirclesEnabled = true
        chartDataSet.valueFont = UIFont(name: "Verdana", size: 14.0)!
        
        
        
        
        
        let chartData = LineChartData(dataSet: chartDataSet)
        lineChart.data = chartData
        
        let xaxis = lineChart.xAxis
        xaxis.valueFormatter = axisFormatDelegate
    }
    
    
    
    
    func getProgressFromDataBase() ->  Results<Progression>{
        return realm.objects(Progression.self)
    }
    
    
    
    func designLineChartView(){
        lineChart.backgroundColor = .white
        lineChart.rightAxis.enabled = false
        
        let yAxis = lineChart.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .black
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .outsideChart
        
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.labelFont = .boldSystemFont(ofSize: 10)
        lineChart.xAxis.setLabelCount(1, force: false)
        lineChart.xAxis.labelTextColor = .black
        lineChart.xAxis.axisLineColor = .systemBlue

        
        let legend = lineChart.legend
        legend.font = UIFont(name: "Verdana", size: 16.0)!
    }
    
    
}



    


extension StatsViewController : IAxisValueFormatter{
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
    
    
}
