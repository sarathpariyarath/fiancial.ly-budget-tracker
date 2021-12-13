//
//  HomePageViewController.swift
//  financially
//
//  Created by Sarath P on 13/12/21.
//

import UIKit

class HomePageViewController: UIViewController {

    @IBOutlet weak var totalBalaceCard: UIView!
    @IBOutlet weak var incomeTotalView: UIView!
    @IBOutlet weak var expenseTotalView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalBalaceCard.layer.cornerRadius = 10
        incomeTotalView.layer.cornerRadius = 10
        expenseTotalView.layer.cornerRadius = 10
    }
    
    @IBAction func addNewExpenseClicked(_ sender: Any) {
        let inside = self.storyboard?.instantiateViewController(withIdentifier: "AddTransactionViewControllerID") as! AddTransactionViewController
        self.navigationController?.pushViewController(inside, animated: true)
    }
    
    @IBAction func addNewCategoryClicked(_ sender: Any) {
        let inside = (self.storyboard?.instantiateViewController(withIdentifier: "categoryTabBar"))!
        self.navigationController?.pushViewController(inside, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
