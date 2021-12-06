//
//  AddTransactionViewController.swift
//  financially
//
//  Created by Sarath P on 04/12/21.
//

import UIKit

class AddTransactionViewController: UIViewController {
    var categoryItems = ["MacBook", "Food", "Party", "Petrol", "Car Loan", "EMI", "Biryani", "Clothes"]
    //context manager
    let context = CoreDataManager.shared.persistentContainer.viewContext
    var incomeTransactions: [IncomeTransaction]?
    @IBOutlet weak var transactionTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateAndTimePicker: UIDatePicker!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var addTransactionClicked: UIButton!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "ADD TRANSACTIONS"
        titleTextField?.layer.cornerRadius = 9.0
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        titleTextField.delegate = self
        amountTextField.delegate = self
        notesTextField.delegate = self
        categoryPicker.selectRow(3, inComponent: 0, animated: true)
    }
    func fetchIncomeTransactions() {
            //fetch the data from tableview
            do {
                self.incomeTransactions = try context.fetch(IncomeTransaction.fetchRequest())
                
            } catch {
                print("error \(error.localizedDescription)")
            }
            
            
        }
    
    @IBAction func addTransactionClicked(_ sender: Any) {
        
        if transactionTypeSegmentedControl.selectedSegmentIndex == 0 {
            let incomeExpenseObject = IncomeTransaction(context: self.context)
            incomeExpenseObject.title = titleTextField.text
            if let incomeAmount = Float(amountTextField.text!) {
                incomeExpenseObject.amount = incomeAmount
            }
            
            incomeExpenseObject.note = notesTextField.text
            incomeExpenseObject.dateAndTime = dateAndTimePicker.date
            print("Income")
            
            do {
                try self.context.save()
                fetchIncomeTransactions()
            } catch {
                print("Error on save context")
            }
            print(incomeExpenseObject)
            print(incomeExpenseObject.dateAndTime!.formatted())
            for i in 0 ..< incomeTransactions!.count {
                let list = incomeTransactions![i]
                print(list.title!)
                print(list.amount)
                print(list.dateAndTime!)
                print(list.note!)
            }
        } else if transactionTypeSegmentedControl.selectedSegmentIndex == 1 {
            print("Expense")
        }
    }
    
}

extension AddTransactionViewController: UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryItems.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryItems[row]
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}


