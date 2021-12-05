//
//  IncomeCategoryViewController.swift
//  financially
//
//  Created by Sarath P on 05/12/21.
//

import UIKit

class IncomeCategoryViewController: UIViewController {
    
    @IBOutlet weak var incomeCategoryTable: UITableView!
    var categoryItems = ["MacBook", "Food", "Party", "Petrol", "Car Loan", "EMI", "Biryani", "Clothes"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "INCOME CATEGORIES"
        incomeCategoryTable.delegate = self
        incomeCategoryTable.dataSource = self
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


}
