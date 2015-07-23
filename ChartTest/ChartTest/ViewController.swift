//
//  ViewController.swift
//  ChartTest
//
//  Created by Pawanpreet Singh on 22/07/15.
//  Copyright (c) 2015 Pawanpreet Singh. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {

    @IBOutlet weak var barChartView: BarChartView!
    var months: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        let unitsBought = [25.0, 5.0, 8.0, 7.0, 17.0, 19.0, 14.0, 19.0, 12.0, 14.0, 15.0, 14.0]
        
        setChart(months, values: unitsSold,otherValues: unitsBought)
       //setChart(months, values: unitsBought)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setChart(dataPoints: [String], values: [Double], otherValues:[Double]) {
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        var boughtDataEntries: [BarChartDataEntry] = []
        
        var finalData = [values,otherValues]
        
        
        var arr = [[Double]]()
    
            for j in 0..<dataPoints.count{
            let dataEntry = BarChartDataEntry(values: arr, xIndex: j)
            dataEntries.append(dataEntry)
            }
        
        for j in 0..<dataPoints.count{
            let dataEntry = BarChartDataEntry(values: otherValues, xIndex: j)
            dataEntries.append(dataEntry)
        }
            //let boughtDataEntry = BarChartDataEntry(value: otherValues[i], xIndex: i)
            //boughtDataEntries.append(boughtDataEntry)
            //dataEntries.append(boughtDataEntry)

            
        
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Units Sold")
        chartDataSet.colors = ChartColorTemplates.vordiplom()
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        
//        let boughtChartDataSet = BarChartDataSet(yVals: boughtDataEntries, label: "Units Bought")
//        boughtChartDataSet.colors = ChartColorTemplates.liberty()
//        let boughtChartData = BarChartData(xVals: months, dataSet: boughtChartDataSet)
        
        barChartView.data = chartData
     //barChartView.data = boughtChartData
      
        
    }


}

