//
//  ExpenseCategoryViewController.swift
//  financially
//
//  Created by Sarath P on 05/12/21.
//

import UIKit

class ExpenseCategoryViewController: UIViewController {
    let context = CoreDataManager.shared.persistentContainer.viewContext
    var expenseCategory: [ExpenseCategory]?
    @IBOutlet weak var expenseCategoryTable: UITableView!
    @IBOutlet weak var expenseCategoryTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "EXPENSE CATEGORIES"
        expenseCategoryTable.delegate = self
        expenseCategoryTable.dataSource = self
        fetchExpenseTransactions()
    }
    
    @IBAction func addExpenseCategoryClicked(_ sender: Any) {
        let expenceCategory = ExpenseCategory(context: self.context)
        expenceCategory.categoryName = expenseCategoryTextField.text
        expenseCategoryTextField.text = ""
        expenseCategoryTextField.endEditing(true)
        do {
            try self.context.save()
        } catch {
            print("Failed to save income category")
        }
        self.fetchExpenseTransactions()
        expenseCategoryTable.reloadData()
        
    }
    func fetchExpenseTransactions() {
        //fetch saved data from database
        
        do {
            self.expenseCategory = try context.fetch(ExpenseCategory.fetchRequest())
            
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
}
extension ExpenseCategoryViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenseCategory?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCategoryCell", for: indexPath)
        let list = expenseCategory?[indexPath.row]
        cell.textLabel?.text = list!.categoryName
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            print("Delete Action Tapped")
            let category = self.expenseCategory?[indexPath.row]
            self.context.delete(category!)
            
            do {
                try self.context.save()
                
            } catch{}
            //refetch the data
            
            self.fetchExpenseTransactions()
            self.expenseCategoryTable.reloadData()
            for i in 0 ..< self.expenseCategory!.count {
                let list = self.expenseCategory![i]
                print(list.categoryName!)
                   
                    
                }
                }
                deleteAction.backgroundColor = .red
                let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
                return configuration
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        expenseCategoryTextField.endEditing(true)
        print(expenseCategoryTextField.text!)
        return true
    }
    
}
