//
//  FaceIDViewController.swift
//  financially
//
//  Created by Sarath P on 14/12/21.
//

import UIKit
import LocalAuthentication

class BiometricsLock: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func authenticateWithFaceId(_ sender: Any) {
        let context: LAContext = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: "Message") { (good, error) in
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
