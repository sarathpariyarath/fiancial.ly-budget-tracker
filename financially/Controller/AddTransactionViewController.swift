//
//  AddTransactionViewController.swift
//  financially
//
//  Created by Sarath P on 04/12/21.
//

import UIKit

class AddTransactionViewController: UIViewController {
    //context manager
    let context = CoreDataManager.shared.persistentContainer.viewContext
    var incomeTransactions: [Transaction]?
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
        fetchIncomeTransactions()
        categoryPicker.selectRow((incomeTransactions!.count/2), inComponent: 0, animated: true)
    }
    func clearTextField() {
        titleTextField.text = ""
        amountTextField.text = ""
        notesTextField.text = ""
    }
    func fetchIncomeTransactions() {
        //fetch saved data from database
        
        do {
            self.incomeTransactions = try context.fetch(Transaction.fetchRequest())
            
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
    @IBAction func addTransactionClicked(_ sender: Any) {
        if transactionTypeSegmentedControl.selectedSegmentIndex == 0 {
            let incomeExpenseObject = Transaction(context: self.context)
            incomeExpenseObject.isIncome = true
            incomeExpenseObject.title = titleTextField.text
            if let incomeAmount = Float(amountTextField.text!) {
                incomeExpenseObject.amount = incomeAmount
            }
            
            incomeExpenseObject.note = notesTextField.text
            incomeExpenseObject.dateAndTime = dateAndTimePicker.date
            clearTextField()
            do {
                try self.context.save()
                fetchIncomeTransactions()
            } catch {
                print("Error on save context")
            }
            for i in 0 ..< incomeTransactions!.count {
                let list = incomeTransactions![i]
                if list.isIncome == true {
                    print(list.title!)
                    print(list.amount)
                    print(list.dateAndTime!.formatted())
                    print(list.note!)
                    print(list.isIncome)
                    print("-----------------------------------")
                    
                }
              
            }
        } else if transactionTypeSegmentedControl.selectedSegmentIndex == 1 {
            print("Expense :")
            let incomeExpenseObject = Transaction(context: self.context)
            incomeExpenseObject.isIncome = false
            incomeExpenseObject.title = titleTextField.text
            if let incomeAmount = Float(amountTextField.text!) {
                incomeExpenseObject.amount = incomeAmount
            }
            
            incomeExpenseObject.note = notesTextField.text
            incomeExpenseObject.dateAndTime = dateAndTimePicker.date
            clearTextField()
            do {
                try self.context.save()
                fetchIncomeTransactions()
            } catch {
                print("Error on save context")
            }
            for i in 0 ..< incomeTransactions!.count {
                let list = incomeTransactions![i]
                if list.isIncome == false {
                    print(list.title!)
                    print(list.amount)
                    print(list.dateAndTime!.formatted())
                    print(list.note!)
                    print(list.isIncome)
                    print("-----------------------------------")
                    
                }
              
            }
        }
    }
    
}

extension AddTransactionViewController: UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return incomeTransactions?.count ?? 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let list = incomeTransactions?[row]
        return list!.title
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}


