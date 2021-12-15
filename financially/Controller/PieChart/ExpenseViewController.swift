//
//  ExpenseViewController.swift
//  financially
//
//  Created by Sarath P on 15/12/21.
//

import UIKit
import Charts
class ExpenseViewController: UIViewController, ChartViewDelegate {
    var pieChart = PieChartView()
    var transactions: [Transaction]?
    @IBOutlet weak var expenseTransactionTable: UITableView!
    @IBOutlet weak var pieChartView: UIView!
    @IBOutlet weak var expenseCategoryTable: UITableView!
    let context = CoreDataManager.shared.persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChart.delegate = self
        expenseTransactionTable.delegate = self
        expenseTransactionTable.dataSource = self
        fetchTransactions()
        // Do any additional setup after loading the view.
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
            if list.isIncome == false {
                entries.append(PieChartDataEntry(value: Double(list.amount), label: list.title))
                let set = PieChartDataSet(entries: entries, label: " ")
                set.colors = ChartColorTemplates.colorful()
                let data = PieChartData(dataSet: set)
                pieChart.data = data
            }
            
        }
        
    }

}

extension ExpenseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transactions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseOverViewCell", for: indexPath) as! ExpenseOverviewTableViewCell
        let reversedTransactions: [Transaction] = Array(transactions!.reversed())
        let list = reversedTransactions[indexPath.row]
            cell.transactionTitle.text = list.title
            var amount: String {
                return String(format: "%.1f", list.amount)
                }

                cell.transactionAmount.text = "+ ₹\(amount)"

            if list.category == nil {
                cell.transactionCategory.text = "-"
            } else {
                cell.transactionCategory.text = list.category
            }
            
            
            cell.transactionDate.text = list.dateAndTime?.formatted(date: .abbreviated, time: .omitted)
            cell.layer.cornerRadius = 8
        
       
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
