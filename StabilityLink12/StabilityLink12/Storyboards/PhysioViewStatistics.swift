//
//  PhysioViewStatistics.swift
//  StabilityLink12
//
//  Created by Daimon Gill on 2019-11-29.
//  Copyright © 2019 Matthew Chute. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Charts

class PhysioViewStatistics: UIViewController {

    @IBOutlet weak var barChart: BarChartView!
    
    // Initialize variables
    var xValue:[String] = [] // exercise names
    var yValue:[String] = [] // number of times done (String)
    var yValue_Double:[Double] = [] // number of times done (Double)
    var ref:DatabaseReference?
    var exerName = ""
    var TimesCount = ""
    weak var axisFormatDelegate: IAxisValueFormatter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Pull ExerciseData using nested loop
        self.ref = Database.database().reference()
        self.ref?.child("users").child(currentPatient).child("routines").child(selectedRoutine).observeSingleEvent(of: DataEventType .value, with: { (snapshot) in
            for routine in snapshot.children.allObjects as![DataSnapshot]{
                let snap = routine.value as? [String : String]
                let exercisename = snap?["exercisename"]
                let timesdone = snap?["patientdone"]
                self.exerName = exercisename!
                self.TimesCount = timesdone!
                self.xValue.append(self.exerName)
                self.yValue.append(self.TimesCount)
                
            }
        })
        
        // Cast all values of string into double
        let yValue_Double = yValue.map { (value) -> Double? in
            return Double(value)
        }
        
        // Update the chart
        setChart(dataEntryX: xValue, dataEntryY: yValue_Double as! [Double])
    }
    
    func setChart(dataEntryX forX:[String],dataEntryY forY: [Double]) {
        barChart.noDataText = "You need to provide data for the chart."
        var dataEntries:[BarChartDataEntry] = []
        for i in 0..<forX.count{
           // print(forX[i])
           // let dataEntry = BarChartDataEntry(x: (forX[i] as NSString).doubleValue, y: Double(unitsSold[i]))
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(forY[i]) , data: xValue as AnyObject?)
            print(dataEntry)
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Number of Completions")
        let chartData = BarChartData(dataSet: chartDataSet)
        barChart.data = chartData
        let xAxisValue = barChart.xAxis
        xAxisValue.valueFormatter = axisFormatDelegate

        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension PhysioViewStatistics: IAxisValueFormatter {

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return xValue[Int(value)]
    }
}
