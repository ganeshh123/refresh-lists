//
//  ConfirmationViewController.swift
//  Refresh Lists
//
//  Created by Ganesh H on 16/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

class ConfirmationViewController: UIViewController {

    @IBOutlet var confirmationOutsideView: UIView!
    @IBOutlet var confirmationDialogView: UIView!
    @IBOutlet var confirmationMessageLabel: UILabel!
    @IBOutlet var confirmationNoButton: UIButton!
    @IBOutlet var confirmationYesButton: UIButton!
    
    
    var message: String = "Are you sure?"
    var yesFunction: () -> () = {}
    var noFunction: () -> () = {}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        confirmationDialogView.makeModalView()
        confirmationYesButton.makeConfirmationButton(icon: UIImage(named: "icon_tick")!, color: Theme.current.greenColor)
        confirmationNoButton.makeConfirmationButton(icon: UIImage(named: "icon_cross")!, color: Theme.current.redColor)
        confirmationMessageLabel.makeConfirmationMessageLabel(text: "Are you sure?", maxLength: 24)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func noButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func yesButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: yesFunction)
    }
    
}
