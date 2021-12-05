//
//  ExpenseCategoryViewController.swift
//  financially
//
//  Created by Sarath P on 05/12/21.
//

import UIKit

class ExpenseCategoryViewController: UIViewController {
    @IBOutlet weak var expenseCategoryTable: UITableView!
    var categoryItems = ["MacBook", "Food", "Party", "Petrol", "Car Loan", "EMI", "Biryani", "Clothes"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "EXPENSE CATEGORIES"
        expenseCategoryTable.delegate = self
        expenseCategoryTable.dataSource = self
    }
    

}
extension ExpenseCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCategoryCell", for: indexPath)
        cell.textLabel?.text = categoryItems[indexPath.row]
        return cell
    }
    
    
}
