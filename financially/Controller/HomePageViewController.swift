//
//  HomePageViewController.swift
//  financially
//
//  Created by Sarath P on 13/12/21.
//

import UIKit

class HomePageViewController: UIViewController {

    @IBOutlet weak var backgroundImg: UIImageView!

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
        reloadBalanceCards()
       
        transactionsTable.reloadData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalBalaceCard.layer.cornerRadius = 10
        incomeTotalView.layer.cornerRadius = 10
        expenseTotalView.layer.cornerRadius = 10
        backgroundImg.layer.cornerRadius = 30
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
    func reloadBalanceCards() {
        let incomeTotalFloat = Float(incomeTotal())
        let expenseTotalFloat = Float(expenseTotal())
        let totalBalance = incomeTotalFloat! - expenseTotalFloat!
        totalBalanceTextField.text = String(totalBalance)
    }

}
extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as! TransactionTableViewCell
        let reversedTransactions: [Transaction] = Array(transactions!.reversed())
        let list = reversedTransactions[indexPath.row]
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
            cell.categoryLabel.text = "-"
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
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            print("Delete Action Tapped")
            let alert = UIAlertController.init(title: "Delete", message: "Confirm to delete this transaction", preferredStyle: .alert)
            
            let deleteButton = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                let reversedTransactions: [Transaction] = Array(self.transactions!.reversed())
                let transactionSelected = reversedTransactions[indexPath.row]
                self.context.delete(transactionSelected)
                
                
                do {
                    try self.context.save()
                    
                    
                } catch{}
                //refetch the data
                
                self.fetchTransactions()
                self.transactionsTable.reloadData()
                self.reloadBalanceCards()
                for i in 0 ..< self.transactions!.count {
                    let list = self.transactions![i]
                    print(list)
                       
                        
                    }
            }
            let cancelButton = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alert.addAction(deleteButton)
            alert.addAction(cancelButton)
            self.present(alert, animated: true, completion: nil)
            
        }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])

        return configuration
    }
}
