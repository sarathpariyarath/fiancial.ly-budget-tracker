//
//  IncomeCategoryViewController.swift
//  financially
//
//  Created by Sarath P on 05/12/21.
//

import UIKit

class IncomeCategoryViewController: UIViewController, UITextFieldDelegate {
    let context = CoreDataManager.shared.persistentContainer.viewContext
    @IBOutlet weak var addIncomeTextField: UITextField! //income category textfield
    @IBOutlet weak var incomeCategoryTable: UITableView! //table showing income categories
    
    var category: [Category]?
    var categoryItems = ["MacBook", "Food", "Party", "Petrol", "Car Loan", "EMI", "Biryani", "Clothes"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "INCOME CATEGORIES"
        incomeCategoryTable.delegate = self
        incomeCategoryTable.dataSource = self
        addIncomeTextField.delegate = self
        fetchIncomeTransactions()
        
    }
    
    @IBAction func incomeCategoryAddButtonClicked(_ sender: Any) {
        let incomeCategory = Category(context: self.context)
        incomeCategory.categoryName = addIncomeTextField.text
        incomeCategory.isIncome = true
        
        do {
            try self.context.save()
        } catch {
            print("Failed to save income category")
        }
        self.fetchIncomeTransactions()
        incomeCategoryTable.reloadData()
        
    }
    func fetchIncomeTransactions() {
        //fetch saved data from database
        
        do {
            self.category = try context.fetch(Category.fetchRequest())
            
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
}
extension IncomeCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "incomeCategoryCell", for: indexPath)
        let list = category?[indexPath.row]
        if list?.isIncome == true {
            cell.textLabel?.text = list!.categoryName
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            print("Delete Action Tapped")
            let category = self.category?[indexPath.row]
            self.context.delete(category!)
            
            do {
                try self.context.save()
            } catch{}
            
            //refetch the data
            self.fetchIncomeTransactions()
            self.incomeCategoryTable.reloadData()
            
            
        }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addIncomeTextField.endEditing(true)
        print(addIncomeTextField.text!)
        return true
    }
    
}
