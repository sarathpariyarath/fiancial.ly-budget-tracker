//
//  OverViewController.swift
//  financially
//
//  Created by Sarath P on 14/12/21.
//

import UIKit

class OverViewController: UIViewController {

    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var totalBalanceCard: UIView!
    @IBOutlet weak var totalBalanceTextField: UILabel!
    @IBOutlet weak var totalIncome: UILabel!
    @IBOutlet weak var totalExpense: UILabel!
    @IBOutlet weak var transactionsTable: UITableView!
    @IBOutlet weak var expenseCard: UIView!
    @IBOutlet weak var incomeCard: UIView!
    var transactions: [Transaction]?
    let context = CoreDataManager.shared.persistentContainer.viewContext
    override func viewWillAppear(_ animated: Bool) {
        fetchTransactions()
        let incomeTotalFloat = Float(incomeTotal())
        let expenseTotalFloat = Float(expenseTotal())
        let totalBalance = incomeTotalFloat! - expenseTotalFloat!
        totalBalanceTextField.text = String(totalBalance)
        transactionsTable.reloadData()
        bgImage.layer.cornerRadius = 30
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
    func fetchTransactions() {
        
        
        do {
            self.transactions = try context.fetch(Transaction.fetchRequest())
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
