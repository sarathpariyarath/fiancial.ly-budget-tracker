//
//  InfoViewController.swift
//  financially
//
//  Created by Sarath P on 22/12/21.
//

import UIKit
import Lottie
class InfoViewController: UIViewController {
    @IBOutlet weak var stackView: UIView!
    @IBOutlet weak var appVersionLabel: UILabel!

    @IBOutlet weak var animationView: AnimationView!
    let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    @IBOutlet weak var versionView: UIView!
    @IBOutlet weak var biometricsSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
        stackView.layer.cornerRadius = 10
        if isDarkMode == true {
            biometricsSwitch.isOn = true
        } else if isDarkMode == false {
            biometricsSwitch.isOn = false
        }
        let nsObject: AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject

        appVersionLabel.text = nsObject as? String
        versionView.layer.cornerRadius = 10
        
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
