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
    @IBOutlet var textEditModalView: UIView!
    @IBOutlet var textEditInputBox: UITextField!
    @IBOutlet var textEditCancelButton: UIButton!
    @IBOutlet var textEditConfirmButton: UIButton!
    
    var confirmFunction: (String) -> () = {_ in }
    var cancelFunction: () -> () = {}

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        textEditModalView.makeModalView()
        textEditConfirmButton.makeConfirmationButton(icon: UIImage(named: "icon_tick")!, color: Theme.current.greenColor)
        textEditCancelButton.makeConfirmationButton(icon: UIImage(named: "icon_cross")!, color: Theme.current.redColor)
        
        
    }
    
    func prepareTextEditInput(color: UIColor, currentName: String, placeholder: String = ""){
        textEditInputBox.makeNameEditInput(backgroundColor: color, text: currentName, placeholder: placeholder)
        textEditInputBox.becomeFirstResponder()
    }

    @IBAction func textEditInputBoxTextChanged(_ sender: UITextField) {
        
        textEditInputBox.clearInvalidInput()
        
    }
    
    @IBAction func textEditConfirmButtonPressed(_ sender: UIButton) {
        
        if(textEditInputBox.text == ""){
            textEditInputBox.invalidInput()
        }else{
            self.confirmFunction(textEditInputBox.text!)
            self.dismiss(animated: true)
        }
        
    }
    
    
    @IBAction func textEditCancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
        self.cancelFunction()
    }
    
}
