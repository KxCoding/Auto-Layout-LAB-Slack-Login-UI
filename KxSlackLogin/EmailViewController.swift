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

        // Do any additional setup after loading the view.
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
