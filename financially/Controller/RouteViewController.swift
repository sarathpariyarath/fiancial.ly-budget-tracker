//
//  RouteViewController.swift
//  financially
//
//  Created by Sarath P on 22/12/21.
//

import UIKit

class RouteViewController: UIViewController {
    let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    override func viewDidLoad() {
        super.viewDidLoad()
print(isDarkMode)
        if isDarkMode == true {
            let faceId = self.storyboard?.instantiateViewController(withIdentifier: "authenticationView") as! AppLockViewController
            self.navigationController?.pushViewController(faceId, animated: true)
        } else {
            let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomePageVC") as! HomePageViewController
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
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
