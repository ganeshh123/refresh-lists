//
//  TextEditViewController.swift
//  Refresh Lists
//
//  Created by Ganesh H on 27/04/2021.
//  Copyright © 2021 Ganesh H. All rights reserved.
//

import UIKit

class TextEditViewController: UIViewController {
    
    @IBOutlet var outsideView: UIView!
    @IBOutlet var nameEditModalView: UIView!
    @IBOutlet var nameEditInputBox: UITextField!
    @IBOutlet var nameEditCancelButton: UIButton!
    @IBOutlet var nameEditConfirmButton: UIButton!
    
    var confirmFunction: (String) -> () = {_ in }
    var cancelFunction: () -> () = {}
    var editedName: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nameEditModalView.makeModalView()
        nameEditConfirmButton.makeConfirmationButton(icon: UIImage(named: "icon_tick")!, color: Theme.current.greenColor)
        nameEditCancelButton.makeConfirmationButton(icon: UIImage(named: "icon_cross")!, color: Theme.current.redColor)
        
        
    }
    
    func prepareNameEditInput(color: UIColor, currentName: String){
        nameEditInputBox.makeNameEditInput(backgroundColor: color, text: currentName)
    }

    @IBAction func nameEditInputBoxTextChanged(_ sender: UITextField) {
        
        nameEditInputBox.clearInvalidInput()
        
    }
    
    @IBAction func nameEditConfirmButtonPressed(_ sender: UIButton) {
        
        if(nameEditInputBox.text == ""){
            nameEditInputBox.invalidInput()
        }else{
            self.confirmFunction(nameEditInputBox.text!)
            self.dismiss(animated: true)
        }
        
    }
    
    
    @IBAction func nameEditCancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
