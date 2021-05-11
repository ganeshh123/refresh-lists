//
//  AppSettingsViewController.swift
//  Refresh Lists
//
//  Created by Ganesh H on 13/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

class AppSettingsViewController: UIViewController {

    @IBOutlet var outsideView: UIView!
    @IBOutlet var settingsViewModal: UIView!
    @IBOutlet var themeSwitchButton: UIButton!
    @IBOutlet var aboutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.outsideViewTouched(sender:)))
        outsideView.isUserInteractionEnabled = true
        outsideView.addGestureRecognizer(tap)
        
        settingsViewModal.makeModalView()
        
        themeSwitchButton.makeSettingsButton(title: "Switch Theme", icon: UIImage(named: "icon_sunmoon")!, color: Theme.current.appAccentColor)
        
        aboutButton.makeSettingsButton(title: "About", icon: UIImage(named: "icon_info")!, color: Theme.current.appAccentColor)
    }
    
    @objc func outsideViewTouched(sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if let firstVC = presentingViewController as? MainViewController {
            DispatchQueue.main.async {
                print("Dismissing View")
                firstVC.viewDidLoad()
            }
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
    
    
    
    @IBAction func themeSwitchPressed(_ sender: UIButton) {
        Theme.switchTheme()
        if let firstVC = presentingViewController as? MainViewController {
            DispatchQueue.main.async {
                print("Dismissing View")
                firstVC.viewDidLoad()
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func aboutButtonPressed(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "About Refresh Lists", message: "Version 1.0.0", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
}