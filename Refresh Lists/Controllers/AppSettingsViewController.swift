//
//  AppSettingsViewController.swift
//  Refresh Lists
//
//  Created by Ganesh H on 13/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

/// View Controller for App Settings
class AppSettingsViewController: UIViewController {
    
    /// Outiside View of Settings Menu
    @IBOutlet var outsideView: UIView!
    /// Container for Settings Menu
    @IBOutlet var settingsViewModal: UIView!
    /// Button to Switch Color Theme
    @IBOutlet var themeSwitchButton: UIButton!
    /// Button to View About Info
    @IBOutlet var aboutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /* Add a listener for outside view tapped */
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.outsideViewTouched(sender:)))
        outsideView.isUserInteractionEnabled = true
        outsideView.addGestureRecognizer(tap)
        
        /* Setup Settings Menu and Buttons */
        settingsViewModal.makeModalView()
        themeSwitchButton.makeSettingsButton(title: "Switch Theme", icon: UIImage(named: "icon_sunmoon")!, color: Theme.current.appAccentColor)
        aboutButton.makeSettingsButton(title: "About", icon: UIImage(named: "icon_info")!, color: Theme.current.appAccentColor)
    }
    
    /// Dismisses the view when tapping outside the menu
    /// - Parameter sender: Gesture
    @objc func outsideViewTouched(sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }
    
    /// Overrided to force parent view to update when settings are changed
    /// - Parameter animated: Boolean to specify whether to show an animation
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if let firstVC = presentingViewController as? MainViewController {
            DispatchQueue.main.async {
                
                /* Reload parent view */
                firstVC.viewDidLoad()
            }
        }
    }
    
    
    /// Handler function for Theme Switch Button Pressed
    /// - Parameter sender: Button Pressed
    @IBAction func themeSwitchPressed(_ sender: UIButton) {
        
        /* Switch the Theme */
        Theme.switchTheme()

        if let firstVC = presentingViewController as? MainViewController {
            DispatchQueue.main.async {
                /* Reload Main View to reflect theme changes */
                firstVC.viewDidLoad()
            }
        }
        
        /* Dismiss the Settings */
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /// Handler Function for About Button Pressed
    /// - Parameter sender: Button Pressed
    @IBAction func aboutButtonPressed(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            
            /* Prepare an alert with the version number */
            let alert = UIAlertController(title: "About Refresh Lists", message: "Version 1.0.0", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            /* Present the Alert*/
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
}
