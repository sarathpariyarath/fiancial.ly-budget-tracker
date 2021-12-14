//
//  OverViewController.swift
//  financially
//
//  Created by Sarath P on 14/12/21.
//

import UIKit

class OverViewController: UIViewController {

    @IBOutlet weak var totalBalanceCard: UIView!
    @IBOutlet weak var expenseCard: UIView!
    @IBOutlet weak var incomeCard: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        totalBalanceCard.layer.cornerRadius = 10
        incomeCard.layer.cornerRadius = 10
        expenseCard.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    

}
