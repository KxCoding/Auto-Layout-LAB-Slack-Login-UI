//
//  EmailViewController.swift
//  KxSlackLogin
//
//  Created by Keun young Kim on 2/7/19.
//  Copyright © 2019 Keun young Kim. All rights reserved.
//

import UIKit

class EmailViewController: UIViewController {
   
   @IBOutlet weak var titleLabelBottomConstraint: NSLayoutConstraint!
   
   @IBOutlet weak var titleLabel: UILabel!
   
   
   @IBOutlet weak var placeholderLabel: UILabel!
   
   @IBOutlet weak var emailField: UITextField!
   
   
   @IBAction func movePrevious(_ sender: Any) {
      navigationController?.popViewController(animated: true)
   }
   override func viewDidLoad() {
      super.viewDidLoad()
      
      titleLabel.alpha = 0.0
      titleLabelBottomConstraint.constant = -20
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


extension EmailViewController: UITextFieldDelegate {
   func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
      placeholderLabel.alpha = (textField.text ?? "").count > 0 ? 0.0 : 1.0
      
      return true
   }
   
   func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      let finalText = NSMutableString(string: textField.text ?? "")
      finalText.replaceCharacters(in: range, with: string)
      
      placeholderLabel.alpha = finalText.length > 0 ? 0.0 : 1.0
      
      UIView.animate(withDuration: 0.3) { [weak self] in
         self?.titleLabel.alpha = finalText.length > 0 ? 1.0 : 0.0
         self?.titleLabelBottomConstraint.constant = finalText.length > 0 ? 0 : -20
         
         self?.view.layoutIfNeeded()
      }
      
      return true
   }
}
