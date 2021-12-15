//
//  IncomePieViewController.swift
//  financially
//
//  Created by Sarath P on 14/12/21.
//

import UIKit
import Charts

class IncomePieViewController: UIViewController, ChartViewDelegate {
    var pieChart = PieChartView()
    @IBOutlet weak var pieChartView: UIView!
    var transactions: [Transaction]?
    let context = CoreDataManager.shared.persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChart.delegate = self
        fetchTransactions()
    }
    func fetchTransactions() {
        
        
        do {
            self.transactions = try context.fetch(Transaction.fetchRequest())
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pieChart.chartDescription?.textColor = .white
        pieChart.transparentCircleColor = .red
        pieChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        pieChart.center = pieChartView.center
        view.addSubview(pieChart)
        var entries = [ChartDataEntry]()
        for x in 0..<transactions!.count {
            let list = transactions![x]
            if list.isIncome == true {
                entries.append(PieChartDataEntry(value: Double(list.amount), label: list.title))
                let set = PieChartDataSet(entries: entries, label: " ")
                set.colors = ChartColorTemplates.colorful()
                let data = PieChartData(dataSet: set)
                pieChart.data = data
            }
            
        }
        
    }
    
}

