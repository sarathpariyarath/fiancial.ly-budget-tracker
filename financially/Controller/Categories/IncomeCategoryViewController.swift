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
    
    var incoCategory: [IncomeCategory]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "INCOME CATEGORIES"
        incomeCategoryTable.delegate = self
        incomeCategoryTable.dataSource = self
        addIncomeTextField.delegate = self
        fetchIncomeTransactions()
        
    }
    
    @IBAction func incomeCategoryAddButtonClicked(_ sender: Any) {
        let incomeCategory = IncomeCategory(context: self.context)
        incomeCategory.categoryName = addIncomeTextField.text
        addIncomeTextField.text = ""
        addIncomeTextField.endEditing(true)
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
            self.incoCategory = try context.fetch(IncomeCategory.fetchRequest())
            
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
}
extension IncomeCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return incoCategory?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "incomeCategoryCell", for: indexPath)
        let list = incoCategory?[indexPath.row]
        cell.textLabel?.text = list!.categoryName
        return cell
        
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            print("Delete Action Tapped")
            let alert = UIAlertController.init(title: "Delete", message: "Confirm to delete category", preferredStyle: .alert)
            
            let deleteButton = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                let category = self.incoCategory?[indexPath.row]
                self.context.delete(category!)
                
                do {
                    try self.context.save()
                    
                } catch{}
                //refetch the data
                
                self.fetchIncomeTransactions()
                self.incomeCategoryTable.reloadData()
                for i in 0 ..< self.incoCategory!.count {
                    let list = self.incoCategory![i]
                    print(list.categoryName!)
                       
                        
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addIncomeTextField.endEditing(true)
        print(addIncomeTextField.text!)
        return true
    }
    
}
