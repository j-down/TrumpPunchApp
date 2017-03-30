//
//  SignUpWithEmailViewController.swift
//  TrumpPunch
//
//  Created by Ryan Coyne on 3/29/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import UIKit
import Firebase

class SignUpWithEmailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNameField : UITextField!
    @IBOutlet weak var lastNameField : UITextField!
    @IBOutlet weak var emailField : UITextField!
    @IBOutlet weak var passwordField : UITextField!
    @IBOutlet weak var passwordConfirmField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeSignUpView () {
        self.dismiss(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            lastNameField.becomeFirstResponder()
            return false
        case 1:
            emailField.becomeFirstResponder()
            return false
        case 2:
            passwordField.becomeFirstResponder()
            return false
        case 3:
            passwordConfirmField.becomeFirstResponder()
            return false
        case 4:
            passwordConfirmField.resignFirstResponder()
            self.checkFieldsAndAttemptSignUp {
                success in
                
            }
            return true
        default:
            return true
        }
    }

    func checkFieldsAndAttemptSignUp (completion: @escaping (_ success: Bool) -> Void) {
        if let pass = passwordField.text, let passConf = passwordConfirmField.text, let email = emailField.text, let firstName = firstNameField.text, let lastName = lastNameField.text {
            if pass == passConf {
                // Okay lets try and sign this guy up!
                FIRAuth.auth()?.createUser(withEmail: email, password: pass) {
                    user, error in
                    if error != nil { self.ccxLog(error: error); completion(false) }
                    let fullName = "\(firstName) \(lastName)"
                    // Lets set the fullName to the currentUser:
                    user?.fullName = fullName
                    if user != nil { completion(true) }
                }
            }
        } else {
            if passwordField.isTextEmpty || passwordConfirmField.isTextEmpty || firstNameField.isTextEmpty || lastNameField.isTextEmpty {
                completion(false)
                return
            }
        }
    }
}

extension UITextField {
    var isTextEmpty : Bool  {
        if (self.text?.isEmpty)! {
            return true
        } else {
            return false
        }
    }
}
