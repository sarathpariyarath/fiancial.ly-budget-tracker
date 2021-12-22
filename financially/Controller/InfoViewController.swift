//
//  InfoViewController.swift
//  financially
//
//  Created by Sarath P on 22/12/21.
//

import UIKit

class InfoViewController: UIViewController {
    @IBOutlet weak var stackView: UIView!
    let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    @IBOutlet weak var biometricsSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        stackView.layer.cornerRadius = 10
        if isDarkMode == true {
            biometricsSwitch.isOn = true
        } else if isDarkMode == false {
            biometricsSwitch.isOn = false
        }
    }
    
    

    @IBAction func biometricsSwitchClicked(_ sender: Any) {
        if biometricsSwitch.isOn {
            UserDefaults.standard.set(biometricsSwitch.isOn, forKey: "isDarkMode")
        } else {
            UserDefaults.standard.set(biometricsSwitch.isOn, forKey: "isDarkMode")
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
