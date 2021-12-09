//
//  AddTransactionViewController.swift
//  financially
//
//  Created by Sarath P on 04/12/21.
//

import UIKit

class AddTransactionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //context manager
    let context = CoreDataManager.shared.persistentContainer.viewContext
    var transactions: [Transaction]?
    @IBOutlet weak var transactionTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateAndTimePicker: UIDatePicker!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var addTransactionClicked: UIButton!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var userTransactionImage: UIImageView!
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
        fetchTransactions()
        categoryPicker.selectRow((transactions!.count/2), inComponent: 0, animated: true)
    }
    // Function to clear all textfields
    func clearTextField() {
        titleTextField.text = ""
        amountTextField.text = ""
        notesTextField.text = ""
    }
    
    // When attach image button clicked
    @IBAction func attachImageButtonClicked(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        
        picker.delegate = self
        
        present(picker, animated: true)
    }
    
    // Function for Image Picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        userTransactionImage?.image = image
        dismiss(animated: true)
    }
    
    //Fetch all datas saved in database
    func fetchTransactions() {
        
        
        do {
            self.transactions = try context.fetch(Transaction.fetchRequest())
            
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
    // Add transaction button clicked
    @IBAction func addTransactionClicked(_ sender: Any) {
        if transactionTypeSegmentedControl.selectedSegmentIndex == 0 {
            let transactionObject = Transaction(context: self.context)
            transactionObject.isIncome = true
            transactionObject.title = titleTextField.text
            if let incomeAmount = Float(amountTextField.text!) {
                transactionObject.amount = incomeAmount
            }
            if let imageData = userTransactionImage.image?.pngData() {
                transactionObject.image = imageData
            }
            
            transactionObject.note = notesTextField.text
            transactionObject.dateAndTime = dateAndTimePicker.date
            clearTextField()
            do {
                try self.context.save()
                fetchTransactions()
            } catch {
                print("Error on save context")
            }
            for i in 0 ..< transactions!.count {
                let list = transactions![i]
                if list.isIncome == true {
                    print(list.title!)
                    print(list.amount)
                    print(list.dateAndTime!.formatted())
                    print(list.note!)
                    print(list.isIncome)
                    if list.image != nil {
                        print(list.image!)
                    }
                    print("-----------------------------------")
                   
                    
                    
                }
              
            }
        } else if transactionTypeSegmentedControl.selectedSegmentIndex == 1 { //when expense category selected in segmented control
            print("Expense :")
            let transactionObject = Transaction(context: self.context)
            transactionObject.isIncome = false
            transactionObject.title = titleTextField.text
            if let expenseAmount = Float(amountTextField.text!) {
                transactionObject.amount = expenseAmount
            }
            
            transactionObject.note = notesTextField.text
            transactionObject.dateAndTime = dateAndTimePicker.date
            clearTextField()
            do {
                try self.context.save()
                fetchTransactions()
            } catch {
                print("Error on save context")
            }
            
            // Just to print all items in database
            for i in 0 ..< transactions!.count {
                let list = transactions![i]
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
        return transactions?.count ?? 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let list = transactions?[row]
        return list!.title
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}


