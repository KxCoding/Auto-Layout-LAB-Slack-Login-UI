//
//  ViewController.swift
//  KxSlackLogin
//
//  Created by Keun young Kim on 2/7/19.
//  Copyright © 2019 Keun young Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   let charSet: CharacterSet = {
      var cs = CharacterSet.lowercaseLetters
      cs.insert(charactersIn: "0123456789")
      cs.insert(charactersIn: "-")
      return cs.inverted
   }()
   
   @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
   @IBOutlet weak var nextButton: UIButton!
   
   @IBOutlet weak var placeholderLeadingConstraint: NSLayoutConstraint!
   
   @IBOutlet weak var urlField: UITextField!
   
   @IBOutlet weak var placeholderLabel: UILabel!
   
   
   var tokens = [NSObjectProtocol]()
   
   deinit {
      
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      
      tokens.forEach { NotificationCenter.default.removeObserver($0) }
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      var token = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.main) { [weak self] (noti) in
         if let frameValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = frameValue.cgRectValue
            
            self?.bottomConstraint.constant = keyboardFrame.size.height
            
            UIView.animate(withDuration: 0.3, animations: {
               self?.view.layoutIfNeeded()
            }, completion: { finished in
               UIView.setAnimationsEnabled(true)
            })
         }
      }
      tokens.append(token)
      
      token = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: OperationQueue.main, using: { [weak self] (noti) in
         self?.bottomConstraint.constant = 0
         
         UIView.animate(withDuration: 0.3, animations: {
            self?.view.layoutIfNeeded()
         })
      })
      tokens.append(token)
      
      urlField.becomeFirstResponder()
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let vc = segue.destination as? EmailViewController {
         vc.bottomMargin = bottomConstraint.constant
      }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      nextButton.isEnabled = false
      
      
   }


   var presented = false
}



extension ViewController: UITextFieldDelegate {
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      let cnt = textField.text?.count ?? 0
      
      if cnt > 0 {
         performSegue(withIdentifier: "emailSegue", sender: nil)
      }
      
      return true
   }
   
   func textFieldDidBeginEditing(_ textField: UITextField) {
      if !presented {
         UIView.setAnimationsEnabled(false)
         presented = true
      }
      
   }
   
   func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      
      if string.count > 0 {
         guard string.rangeOfCharacter(from: charSet) == nil else {
            return false
         }
      }
      
      let finalText = NSMutableString(string: textField.text ?? "")
      finalText.replaceCharacters(in: range, with: string)
      
      let font = textField.font ?? UIFont.systemFont(ofSize: 16)
      
      let dict = [NSAttributedString.Key.font: font]
      
      let width = finalText.size(withAttributes: dict).width
      
      placeholderLeadingConstraint.constant = width
      
      if finalText.length == 0 {
         placeholderLabel.text = "workspace-url.slack.com"
      } else {
         placeholderLabel.text = ".slack.com"
      }
      
      nextButton.isEnabled = finalText.length > 0
      
      return true
   }
}
