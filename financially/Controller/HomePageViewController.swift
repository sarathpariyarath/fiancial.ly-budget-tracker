//
//  HomePageViewController.swift
//  financially
//
//  Created by Sarath P on 13/12/21.
//

import UIKit

class HomePageViewController: UIViewController {

    @IBOutlet weak var totalBalaceCard: UIView!
    @IBOutlet weak var incomeTotalView: UIView!
    @IBOutlet weak var expenseTotalView: UIView!
    @IBOutlet weak var expenseTotaltextField: UILabel!
    @IBOutlet weak var totalBalanceTextField: UILabel!
    @IBOutlet weak var incomeTotalTextField: UILabel!
    @IBOutlet weak var transactionsTable: UITableView!
    var transactions: [Transaction]?
    let context = CoreDataManager.shared.persistentContainer.viewContext
    override func viewWillAppear(_ animated: Bool) {
        fetchTransactions()
        let incomeTotalFloat = Float(incomeTotal())
        let expenseTotalFloat = Float(expenseTotal())
        let totalBalance = incomeTotalFloat! - expenseTotalFloat!
        totalBalanceTextField.text = String(totalBalance)
        transactionsTable.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        totalBalaceCard.layer.cornerRadius = 10
        incomeTotalView.layer.cornerRadius = 10
        expenseTotalView.layer.cornerRadius = 10
        fetchTransactions()
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
        self.incomeTotalTextField.text = totalString
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
        self.expenseTotaltextField.text = totalString
      return totalString
    }
    func fetchTransactions() {
        
        
        do {
            self.transactions = try context.fetch(Transaction.fetchRequest())
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
    @IBAction func addNewExpenseClicked(_ sender: Any) {
        let inside = self.storyboard?.instantiateViewController(withIdentifier: "AddTransactionViewControllerID") as! AddTransactionViewController
        self.navigationController?.pushViewController(inside, animated: true)
    }
    
    @IBAction func addNewCategoryClicked(_ sender: Any) {
        let inside = (self.storyboard?.instantiateViewController(withIdentifier: "categoryTabBar"))!
        self.navigationController?.pushViewController(inside, animated: true)
    }
    

}
extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as! TransactionTableViewCell
        let list = transactions![indexPath.row]
        cell.titleLabel.text = list.title
        var amount: String {
            return String(format: "%.1f", list.amount)
            }
        if list.isIncome == true {
            cell.amountLabel.text = "+ ₹\(amount)"
        } else {
            cell.amountLabel.text = "- ₹\(amount)"
            cell.amountLabel.textColor = .red
        }
        if list.category == nil {
            cell.categoryLabel.text = "-nil"
            cell.categoryLabel.textColor = .red
        } else {
            cell.categoryLabel.text = list.category
        }
        
        
        cell.dateLabel.text = list.dateAndTime?.formatted(date: .abbreviated, time: .omitted)
        cell.layer.cornerRadius = 8
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
