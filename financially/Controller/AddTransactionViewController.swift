//
//  AddTransactionViewController.swift
//  financially
//
//  Created by Sarath P on 04/12/21.
//

import UIKit

class AddTransactionViewController: UIViewController {
    var textField = UITextField()
    var categoryItems = ["MacBook", "Food", "Party", "Petrol", "Car Loan", "EMI", "Biryani", "Clothes"]
    //context manager
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
    @IBOutlet weak var transactionTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateAndTimePicker: UIDatePicker!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var addTransactionClicked: UIButton!
    @IBOutlet weak var notesTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "ADD TRANSACTIONS"
        titleTextField?.layer.cornerRadius = 9.0
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        titleTextField.delegate = self
        amountTextField.delegate = self
        notesTextField.delegate = self
    }
    
    @IBAction func addTransactionClicked(_ sender: Any) {
        //create object
        print(titleTextField.text!)
        
        if transactionTypeSegmentedControl.selectedSegmentIndex == 0 {
//            var incomeAmount: Float = amountTextField
            let incomeExpenseObject = IncomeTransaction(context: self.context)
            incomeExpenseObject.title = titleTextField.text
//            incomeExpenseObject.amount = incomeAmount
            incomeExpenseObject.note = notesTextField.text
            incomeExpenseObject.dateAndTime = dateAndTimePicker.date
            print("Income")
            
            do {
                try self.context.save()
            } catch {
                print("error")
            }
            print(incomeExpenseObject)
        } else if transactionTypeSegmentedControl.selectedSegmentIndex == 1 {
            print("Expense")
        }
        print(dateAndTimePicker.date.formatted())
        print(notesTextField.text!)
        print(amountTextField.text!)
        textField.text = ""
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


