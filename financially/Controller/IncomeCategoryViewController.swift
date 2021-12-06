//
//  IncomeCategoryViewController.swift
//  financially
//
//  Created by Sarath P on 05/12/21.
//

import UIKit

class IncomeCategoryViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var addIncomeTextField: UITextField! //income category textfield
    @IBOutlet weak var incomeCategoryTable: UITableView! //table showing income categories
    
    
    var categoryItems = ["MacBook", "Food", "Party", "Petrol", "Car Loan", "EMI", "Biryani", "Clothes"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "INCOME CATEGORIES"
        incomeCategoryTable.delegate = self
        incomeCategoryTable.dataSource = self
        addIncomeTextField.delegate = self
    }
    
}
extension IncomeCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "incomeCategoryCell", for: indexPath)
        cell.textLabel?.text = categoryItems[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
                    print("Delete Action Tapped")
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
