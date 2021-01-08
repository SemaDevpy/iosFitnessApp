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

class StatsViewController: UIViewController , ChartViewDelegate{

    var lineChart = LineChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChart.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lineChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
            lineChart.center = view.center
            view.addSubview(lineChart)
            
            var entries = [ChartDataEntry]()
            
            for x in 0...10{
                entries.append(ChartDataEntry(x: Double(x), y: Double(x)))
            }
            
            let set = LineChartDataSet(entries: entries)
            
            set.colors = ChartColorTemplates.material()
            
            let data = LineChartData(dataSet: set)
            lineChart.data = data
    }

 

}
