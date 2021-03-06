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

    @IBOutlet weak var buildVersionLabel: UILabel!
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
        let buildVersion: AnyObject? = Bundle.main.infoDictionary! ["CFBundleVersion"] as AnyObject
        buildVersionLabel.text = buildVersion as? String
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

}
