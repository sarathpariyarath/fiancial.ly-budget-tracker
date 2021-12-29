//
//  IncomePieViewController.swift
//  financially
//
//  Created by Sarath P on 14/12/21.
//

import UIKit
import Charts
import CoreData

class IncomePieViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var incomeTransactionTable: UITableView!
    var pieChart = PieChartView()
    @IBOutlet weak var minimumDatePicker: UIDatePicker!
    @objc var transactions: [Transaction]?
    @IBOutlet weak var maximumDatePicker: UIDatePicker!
    @IBOutlet weak var pieChartView: UIView!
    let context = CoreDataManager.shared.persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTransactions()
        pieChart.delegate = self
        incomeTransactionTable.delegate = self
        incomeTransactionTable.dataSource = self
        minimumDatePicker.maximumDate = Date().addingTimeInterval(-86400)
        
        
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
    func fetchTransactions() {
        
        
        do {
            let request = Transaction.fetchRequest() as NSFetchRequest <Transaction>
            let predicate = NSPredicate(format: "isIncome = true")
            request.predicate = predicate
            self.transactions = try context.fetch(request)
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    func sortDate() {
        
        
        do {
            let request = Transaction.fetchRequest() as NSFetchRequest<Transaction>
            let predicate = NSPredicate(format: "isIncome == true && dateAndTime >= %@ && dateAndTime <= %@", minimumDatePicker.date as Date as CVarArg, maximumDatePicker.date as Date as CVarArg)
            request.predicate = predicate
            //            let sort = NSSortDescriptor(key: "title", ascending: false)
            //            request.sortDescriptors = [sort]
            self.transactions = try context.fetch(request)
            incomeTransactionTable.reloadData()
            //            let sort = NSSortDescriptor(key: #keyPath(transactions.title), ascending: true)
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

extension IncomePieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transactions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "incomeOverviewCell", for: indexPath) as! IncomeOverviewTableViewCell
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
