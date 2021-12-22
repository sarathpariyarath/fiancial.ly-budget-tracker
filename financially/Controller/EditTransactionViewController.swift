//
//  EditTransactionViewController.swift
//  financially
//
//  Created by Sarath P on 20/12/21.
//

import UIKit

class EditTransactionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let context = CoreDataManager.shared.persistentContainer.viewContext
    var transactions: [Transaction]?
    var incoCategory: [IncomeCategory]?
    var expenseCategory: [ExpenseCategory]?
    var position: Int?
    @IBOutlet weak var transactionTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateAndTimePicker: UIDatePicker!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var addTransactionClicked: UIButton!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var userTransactionImage: UIImageView!
    @IBOutlet weak var categoryPicker: UIPickerView!
    var pickerSelection: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "EDIT TRANSACTIONS"
        fetchTransactions()
        let reversedTransactions: [Transaction] = Array(transactions!.reversed())
        let list = reversedTransactions[position!]
        amountTextField.text = String(list.amount)
        notesTextField.text = list.note!
        if list.image != nil {
            userTransactionImage.image = UIImage(data: list.image!)
        }
        titleTextField.text = list.title
        titleTextField?.layer.cornerRadius = 9.0
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        titleTextField.delegate = self
        amountTextField.delegate = self
        notesTextField.delegate = self
        pickerSelection = list.category
        categoryPicker.selectRow((transactions!.count/2), inComponent: 0, animated: true)
        if list.isIncome == false {
            transactionTypeSegmentedControl.selectedSegmentIndex = 1
        }
        // Do any additional setup after loading the view.
    }
    // Function to clear all textfields after end editing
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
    func fetchTransactions() {
        
        
        do {
            self.transactions = try context.fetch(Transaction.fetchRequest())
            self.incoCategory = try context.fetch(IncomeCategory.fetchRequest())
            self.expenseCategory = try context.fetch(ExpenseCategory.fetchRequest())
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    @IBAction func pickerViewClicked(_ sender: Any) {
        categoryPicker.reloadAllComponents()
    }
    // Add transaction button clicked
    @IBAction func editTransactionClicked(_ sender: Any) {
        if titleTextField.text?.isEmpty == false && notesTextField.text?.isEmpty == false && amountTextField.text?.isEmpty == false {
            if transactionTypeSegmentedControl.selectedSegmentIndex == 0 {
               
//                let incomeCategory = IncomeCategory(context: self.context)
                let reversedTransactions: [Transaction] = Array(transactions!.reversed())
                let transactionObject = reversedTransactions[position!]
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
                transactionObject.category = pickerSelection
                clearTextField()
                do {
                    try self.context.save()
                    fetchTransactions()
                } catch {
                    print("Error on save context")
                }

            } else if transactionTypeSegmentedControl.selectedSegmentIndex == 1 { //when expense category selected in segmented control
                print("Expense :")
                let reversedTransactions: [Transaction] = Array(transactions!.reversed())
                let transactionObject = reversedTransactions[position!]
                transactionObject.isIncome = false
                transactionObject.title = titleTextField.text
                if let expenseAmount = Float(amountTextField.text!) {
                    transactionObject.amount = expenseAmount
                }
                
                transactionObject.note = notesTextField.text
                transactionObject.dateAndTime = dateAndTimePicker.date
                transactionObject.category = pickerSelection
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
                        if list.category != nil {
                            print(list.category!)
                        }
                        print("-----------------------------------")
                        
                    }
                  
                }
            }
            let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomePageVC") as! HomePageViewController
            self.navigationController?.pushViewController(homeVC, animated: true)
        } else {
            let alert = UIAlertController(title: "Fill all fields", message: "Please provide correct details", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        

        
    }

}
extension EditTransactionViewController: UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if transactionTypeSegmentedControl.selectedSegmentIndex == 0 {
            return incoCategory?.count ?? 0
        } else {
            return expenseCategory?.count ?? 0
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if transactionTypeSegmentedControl.selectedSegmentIndex == 0 {
            let list = incoCategory?[row]
            return list!.categoryName
        } else {
            let list = expenseCategory?[row]
            return list!.categoryName
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if transactionTypeSegmentedControl.selectedSegmentIndex == 0 {
            let list = incoCategory?[row]
            print(list!)
            print(list!.categoryName!)
            pickerSelection = list?.categoryName
        } else {
            let list = expenseCategory?[row]
            print(list!)
            print(list!.categoryName!)
            pickerSelection = list?.categoryName
        }
    }

}
