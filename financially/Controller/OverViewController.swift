//
//  OverViewController.swift
//  financially
//
//  Created by Sarath P on 14/12/21.
//

import UIKit
import CoreData

class OverViewController: UIViewController {
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var totalBalanceCard: UIView!
    @IBOutlet weak var totalBalanceTextField: UILabel!
    @IBOutlet weak var totalIncome: UILabel!
    @IBOutlet weak var totalExpense: UILabel!
    @IBOutlet weak var transactionsTable: UITableView!
    @IBOutlet weak var expenseCard: UIView!
    @IBOutlet weak var incomeCard: UIView!
    @IBOutlet weak var minimumDatePicker: UIDatePicker!
    @objc var transactions: [Transaction]?
    @IBOutlet weak var maximumDatePicker: UIDatePicker!
    
    let context = CoreDataManager.shared.persistentContainer.viewContext
    override func viewWillAppear(_ animated: Bool) {
        bothTransaction()
        let incomeTotalFloat = Float(incomeTotal())
        let expenseTotalFloat = Float(expenseTotal())
        let totalBalance = incomeTotalFloat! - expenseTotalFloat!
        totalBalanceTextField.text = String(totalBalance)
        transactionsTable.reloadData()
        bgImage.layer.cornerRadius = 25
        bgImage.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        totalBalanceCard.layer.cornerRadius = 10
        incomeCard.layer.cornerRadius = 10
        expenseCard.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
        transactionsTable.reloadData()
        transactionsTable.delegate = self
        transactionsTable.dataSource = self
        minimumDatePicker.maximumDate = Date().addingTimeInterval(-86400)
        maximumDatePicker.minimumDate = Date()
    }
    func incomeTotal() -> String {
        var total: Float = 0
        for i in 0 ..< transactions!.count {
            let list = transactions![i]
            if list.isIncome == true {
                
                total = total + list.amount
                print(total)
            }
            
        }
        var totalString: String {
            return String(format: "%.1f", total)
        }
        self.totalIncome.text = totalString
        return totalString
    }
    func expenseTotal() -> String {
        var total: Float = 0
        for i in 0 ..< transactions!.count {
            let list = transactions![i]
            if list.isIncome == false {
                
                total = total + list.amount
                print(total)
            }
            
        }
        var totalString: String {
            return String(format: "%.1f", total)
        }
        self.totalExpense.text = totalString
        return totalString
    }
    @IBAction func uiDatePickerClicked(_ sender: Any) {
        
        self.dismiss(animated: true) {
            self.sortDate()
        }
    }
    func bothTransaction() {
        
        
        do {
            let request = Transaction.fetchRequest() as NSFetchRequest<Transaction>
            self.transactions = try context.fetch(request)
            
            DispatchQueue.main.async {
                self.transactionsTable.reloadData()
            }
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
    @IBAction func minimumDatepickerClicked(_ sender: Any) {
        DispatchQueue.main.async {
            self.maximumDatePicker.minimumDate = self.minimumDatePicker.date
        }
    }
    func sortDate() {
        
        
        do {
            let request = Transaction.fetchRequest() as NSFetchRequest<Transaction>
            let pred = NSPredicate(format: "dateAndTime >= %@ && dateAndTime <= %@", minimumDatePicker.date as Date as CVarArg, maximumDatePicker.date as Date as CVarArg)
            request.predicate = pred
            //            let sort = NSSortDescriptor(key: "title", ascending: false)
            //            request.sortDescriptors = [sort]
            self.transactions = try context.fetch(request)
            
            DispatchQueue.main.async {
                let incomeTotalFloat = Float(self.incomeTotal())
                let expenseTotalFloat = Float(self.expenseTotal())
                let totalBalance = incomeTotalFloat! - expenseTotalFloat!
                self.totalBalanceTextField.text = String(totalBalance)
                self.transactionsTable.reloadData()
            }
            //            let sort = NSSortDescriptor(key: #keyPath(transactions.title), ascending: true)
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
}
extension OverViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "overviewCell", for: indexPath) as! OverViewTableViewCell
        let reversedTransactions: [Transaction] = Array(transactions!.reversed())
        
        let list = reversedTransactions[indexPath.row]
        cell.transactionTitle.text = list.title
        var amount: String {
            return String(format: "%.1f", list.amount)
        }
        if list.isIncome == true {
            cell.transactionAmount.text = "+ ₹\(amount)"
            cell.transactionAmount.textColor = .green
        } else {
            cell.transactionAmount.text = "- ₹\(amount)"
            cell.transactionAmount.textColor = .red
        }
        if list.category == nil {
            cell.transactionCategory.text = "-"
        } else {
            cell.transactionCategory.text = list.category
        }
        
        
        cell.transactionDate.text = list.dateAndTime?.formatted(date: .abbreviated, time: .omitted)
        cell.layer.cornerRadius = 8
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
