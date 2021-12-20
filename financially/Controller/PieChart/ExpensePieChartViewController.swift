//
//  ExpenseViewController.swift
//  financially
//
//  Created by Sarath P on 15/12/21.
//

import UIKit
import Charts
import CoreData
class ExpensePieChartViewController: UIViewController, ChartViewDelegate {
    var pieChart = PieChartView()
    var transactions: [Transaction]?
    @IBOutlet weak var expenseTransactionTable: UITableView!
    @IBOutlet weak var pieChartView: UIView!
    @IBOutlet weak var expenseCategoryTable: UITableView!
    @IBOutlet weak var minimumDatePicker: UIDatePicker!
    @IBOutlet weak var maximumDatePicker: UIDatePicker!
    let context = CoreDataManager.shared.persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTransactions()
        pieChart.delegate = self
        expenseTransactionTable.delegate = self
        expenseTransactionTable.dataSource = self
       
        minimumDatePicker.maximumDate = Date().addingTimeInterval(-86400)
        // Do any additional setup after loading the view.
    }
    @IBAction func uiMinimumDateClicked(_ sender: Any) {
        DispatchQueue.main.async {
            self.maximumDatePicker.minimumDate = self.minimumDatePicker.date
        }
    }
    @IBAction func uiDatePickerClicked(_ sender: Any) {
        
        self.dismiss(animated: true) {
            self.sortDate()
            self.viewDidLayoutSubviews()
        }
    }
    func sortDate() {
        
        
        do {
            let request = Transaction.fetchRequest() as NSFetchRequest<Transaction>
            let pred = NSPredicate(format: "isIncome == false && dateAndTime >= %@ && dateAndTime <= %@", minimumDatePicker.date as Date as CVarArg, maximumDatePicker.date as Date as CVarArg)
            request.predicate = pred
            //            let sort = NSSortDescriptor(key: "title", ascending: false)
            //            request.sortDescriptors = [sort]
            self.transactions = try context.fetch(request)
            expenseCategoryTable.reloadData()
            //            let sort = NSSortDescriptor(key: #keyPath(transactions.title), ascending: true)
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    func fetchTransactions() {
        
        
        do {
            let request = Transaction.fetchRequest() as NSFetchRequest <Transaction>
            let predicate = NSPredicate(format: "isIncome = false")
            request.predicate = predicate
            self.transactions = try context.fetch(request)
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

extension ExpensePieChartViewController: UITableViewDelegate, UITableViewDataSource {
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

                cell.transactionAmount.text = "- ₹\(amount)"

            if list.category == nil {
                cell.transactionCategory.text = "-"
            } else {
                cell.transactionCategory.text = list.category
            }
            
            
            cell.transactionDate.text = list.dateAndTime?.formatted(date: .abbreviated, time: .omitted)
        cell.transactionAmount.textColor = .red
            cell.layer.cornerRadius = 8
        
       
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
