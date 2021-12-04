//
//  AddTransactionViewController.swift
//  financially
//
//  Created by Sarath P on 04/12/21.
//

import UIKit

class AddTransactionViewController: UIViewController {
   
    var categoryItems = ["MacBook", "Food", "Party", "Petrol", "Car Loan", "EMI", "Biryani", "Clothes"]
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var titleTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "ADD TRANSACTIONS"
        titleTextField?.layer.cornerRadius = 9.0
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
    }
    
}

extension AddTransactionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryItems.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryItems[row]
    }
}


