//
//  FaceIDViewController.swift
//  financially
//
//  Created by Sarath P on 14/12/21.
//

import UIKit
import LocalAuthentication

class FaceIDViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func authenticateWithFaceId(_ sender: Any) {
        let context: LAContext = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Message") { (good, error) in
                if good {
                    print("Good")
                    DispatchQueue.main.async {
                        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomePageVC") as! HomePageViewController
                        self.navigationController?.pushViewController(homeVC, animated: true)
                    }
                } else {
                    print("Try Again")
                }
            }
        }
    }
    

}
