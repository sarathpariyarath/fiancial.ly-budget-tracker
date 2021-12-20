//
//  DetailsViewController.swift
//  financially
//
//  Created by Sarath P on 16/12/21.
//

import UIKit

class DetailsViewController: UIViewController {
    var transactions: [Transaction]?
    let context = CoreDataManager.shared.persistentContainer.viewContext
    var position: Int?
    @IBOutlet weak var transactionImage: UIImageView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var amountView: UIView!
    @IBOutlet weak var transactionDate: UILabel!
    
    @IBOutlet weak var transactionTitle: UILabel!
    @IBOutlet weak var noteView: UIView!
    @IBOutlet weak var transactionImageView: UIImageView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var transactionView: UIView!
    @IBOutlet weak var transactionAmount: UILabel!
    @IBOutlet weak var isIncome: UILabel!
    @IBOutlet weak var transactionCategory: UILabel!
    @IBOutlet weak var transactionNote: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTransactions()
        titleView.layer.cornerRadius = 10
        amountView.layer.cornerRadius = 10
        transactionView.layer.cornerRadius = 10
        categoryView.layer.cornerRadius = 10
        dateView.layer.cornerRadius = 10
        noteView.layer.cornerRadius = 10
        let reversedTransactions: [Transaction] = Array(transactions!.reversed())
        let list = reversedTransactions[position!]
        transactionTitle.text = list.title
        transactionAmount.text = String(list.amount)
        if list.isIncome == true {
            isIncome.text = "INCOME"
        } else {
            isIncome.text = "EXPENSE"
        }
        if list.category != nil {
            transactionCategory.text = list.category
        } else {
            transactionCategory.text = "Nill"
        }
        transactionNote.text = list.note
        transactionDate.text = list.dateAndTime?.formatted(date: .long, time: .shortened)
        if list.image != nil {
            transactionImage.image = UIImage(data: list.image!)
        }
        
        
    }
    func fetchTransactions() {
        
        
        do {
            self.transactions = try context.fetch(Transaction.fetchRequest())
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    @IBAction func editButtonClicked(_ sender: Any) {
        let editPage = self.storyboard?.instantiateViewController(withIdentifier: "EditTransactionViewControllerID") as! EditTransactionViewController
        editPage.position = position
        self.navigationController?.pushViewController(editPage, animated: true)
    }
}
