//
//  TPSignInViewController.swift
//  TrumpPunch
//
//  Created by Mike Silvers on 4/2/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import UIKit
import Firebase

class TPSignInViewController: UIViewController {

    @IBOutlet weak var emailField : CCXSignUpTextField!
    @IBOutlet weak var passwordField : CCXSignUpTextField!
    
    @IBOutlet weak var navigationBar : UINavigationBar!
    @IBOutlet weak var scrollView : UIScrollView!
    
    @IBOutlet weak var fieldView : UIView!
    
    var currentResponder : CCXSignUpTextField?
    
    var scrollBack = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Keyboard Notifications:
        NotificationCenter.default.addObserver(self, selector:#selector(self.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(self.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Remove keyboard notifications from the viewController:
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
    }
    func keyboardWillShow(notification: NSNotification) {
        if self.scrollBack {
            return
        }
        // If we already are showing the keyboard we shouldnt have to do the rest of the code:
        var keyboardHeight = CGFloat()
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
        }
        // If the currentResponder field is nil, we shold return.
        if self.currentResponder == nil { return }
        // Lets get all the data points we need here for our calculation:
        let fldFrame = self.view.convert(self.currentResponder!.frame, from: self.fieldView)
        let fldHeight = self.currentResponder!.frame.size.height
        var visibileRect = self.view.frame
        
        visibileRect.size.height -= keyboardHeight
        
        //  If the visible rect does not contain the currentResponders frame, we will scroll down to the correct point:
        if !visibileRect.contains(fldFrame) {
            // Create scrolling point:
            let scrollPoint = CGPoint(x: 0.0, y: fldFrame.origin.y - visibileRect.size.height + fldHeight)
            
            // Set the content offset to scroll the fields to a visible rect:
            self.scrollView.setContentOffset(scrollPoint, animated: true)
            
            // We scrolled so we will need to scrollBack eventually:
            self.scrollBack = true
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        // If we had to scroll, we need to scroll back:
        if self.scrollBack {
            // Set the content back to original point:
            self.scrollView.setContentOffset(.init(x: 0, y: 0), animated: true)
            self.scrollBack = false
        }
    }
    
    // MARK: IBAction Functions
    @IBAction func closeSignUpView () {
        // Dismiss this view:
        self.dismiss(animated: true)
    }
    @IBAction func dismissKeyboard () {
        //        if the currentResponder is nil, then we should return.  If it isn't we should resign the responder (or dismiss the keyboard):
        if currentResponder != nil { currentResponder!.resignFirstResponder() } else { return }
    }
    
    //MARK: UITextField Delegate Functions:
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentResponder = textField as? CCXSignUpTextField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // First, cast the textField into the CCXSignUpTextField for our custom functions & variables:
        let txtField = textField as! CCXSignUpTextField
        if !txtField.isTextEmpty {
            if txtField.showingError {
                switch txtField.tag {
                case 0:
                    txtField.checkEmailAvailability {
                        available in
                    }
                case 1:
                    if txtField.isTextEmpty {
                        txtField.errorString = "Please enter a password!"
                    } else {
                        txtField.clearErrors()
                    }
                default:
                    break
                }
            } else {
                switch txtField.tag {
                case 0:
                    txtField.checkEmailAvailability {
                        success in
                    }
                default:
                    break
                }
            }
        } else  {
            // If we were showing a success, and the textfield is empty, then we need to clear out the success.
            switch txtField.tag {
            case 0:
                txtField.errorString = "Please enter an email!"
            case 1:
                txtField.errorString = "Please enter a password!"
            default:
                break
            }
        }
        currentResponder = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            passwordField.becomeFirstResponder()
            return false
        case 1:
            // SIGN IN HERE:
            if emailField.emailAvailable && !passwordField.isTextEmpty && !emailField.isTextEmpty {
                let email = emailField.text!
                let password = passwordField.text!
                
                FIRAuth.auth()?.signIn(withEmail: email, password: password) {
                    usr, er in
                    if let error = er { self.showError(error: error) }
                    if usr != nil { AppDelegate.shared.continueToMain() }
                }
                
            }
            return false
        default:
            // We should NEVER be hitting here:
            return true
        }
    }
}

fileprivate extension TPSignInViewController {
    func showError(error: Error) {
        let alertController = UIAlertController(title: "Error signing in!", message: error.localizedDescription, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okayAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showErrorString(errorString : String) {
        let alertController = UIAlertController(title: "Error signing in!", message: errorString, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okayAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
