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

    @IBOutlet var usernameField : CCXSignUpTextField!
    @IBOutlet var emailField : CCXSignUpTextField!
    @IBOutlet var passwordField : CCXSignUpTextField!
    @IBOutlet var passwordConfirmField : CCXSignUpTextField!
    
    @IBOutlet weak var scrollView : UIScrollView!
    
    @IBOutlet weak var fieldView : UIView!
    
    var currentResponder : CCXSignUpTextField?
    
    var usernameAvailable = false
    var checkingUsernameAvailability = false
    var checkingEmailAvailability = false
    var scrollBack = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Keyboard Notification Selectors:
    //MARK: Keyboard Notifications
    func keyboardWillShow(notification: NSNotification) {
        if self.scrollBack {
            return
        }
        // If we already are showing the keyboard we shouldnt have to do the rest of the code:
        var keyboardHeight = CGFloat()
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
        }
        if self.currentResponder == nil { return }
        let fldFrame = self.view.convert(self.currentResponder!.frame, from: self.fieldView)
        let fldHeight = self.currentResponder!.frame.size.height
        var visibileRect = self.view.frame
        
        visibileRect.size.height -= keyboardHeight
        
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
    
    @IBAction func closeSignUpView () {
        self.dismiss(animated: true)
    }
    
    @IBAction func dismissKeyboard () {
        if currentResponder != nil { currentResponder!.resignFirstResponder() } else { return }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentResponder = textField as? CCXSignUpTextField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let txtField = textField as? CCXSignUpTextField {
            if !txtField.isTextEmpty {
                if txtField.showingError {
                    switch txtField.tag {
                    case 0:
                        self.checkingUsernameAvailability = true
                        txtField.checkUsernameAvailability {
                            available in
                            // Set the checking status back to false (we will check this when we check the fields to sign up:
                            self.checkingUsernameAvailability = false
                            // Set this check to what was given back through the block:
                            self.usernameAvailable = available
                        }
                    case 1:
                        self.checkingEmailAvailability = true
                        txtField.checkEmailAvailability {
                            available in
                            // Set the checking status back to false (we will check this when we check the fields to sign up:
                            self.checkingEmailAvailability = false
                            // Set this check to what was given back through the block:
                        }
                    case 2:
                        if txtField.text == passwordConfirmField.text && txtField.text != nil {
                            passwordConfirmField.clearErrors()
                        }
                    case 3:
                        if passwordField.text != txtField.text && txtField.text != nil {
                            if passwordField.showingError { passwordField.clearErrors() }
                            txtField.errorString = "Your passwords do not match."
                        } else if txtField.text == passwordField.text && txtField.text != nil {
                            if passwordField.showingError { passwordField.clearErrors() }
                            if txtField.showingError { txtField.clearErrors() }
                        }
                    default:
                        break
                    }
                } else {
                    switch txtField.tag {
                    case 0:
                        self.checkingUsernameAvailability = true
                        txtField.checkUsernameAvailability {
                            available in
                            // Set the checking status back to false (we will check this when we check the fields to sign up:
                            self.checkingUsernameAvailability = false
                            // Set this check to what was given back through the block:
                            self.usernameAvailable = available
                        }
                    case 1:
                        self.checkingEmailAvailability = true
                        txtField.checkEmailAvailability {
                            success in
                            self.checkingEmailAvailability = false
                        }
                    case 2:
                        if txtField.text == passwordConfirmField.text && txtField.text != nil {
                            passwordConfirmField.clearErrors()
                        }
                    case 3:
                        if txtField.text != passwordField.text && txtField.text != nil {
                            if passwordField.showingError { passwordField.clearErrors() }
                            if txtField.showingError { txtField.clearErrors() }
                            txtField.errorString = "Your passwords do not match."
                        } else if txtField.text == passwordField.text && txtField.text != nil {
                            txtField.clearErrors()
                        }
                    default:
                        break
                    }
                }
            } else  {
                // If we were showing a success, and the textfield is empty, then we need to clear out the success.
                if !txtField.showingError {
                    switch txtField.tag {
                    case 0:
                        if txtField.showingSuccess { txtField.clearSuccess() }
                        txtField.errorString = "Please enter a username!"
                    case 1:
                        txtField.errorString = "Please enter an email!"
                    case 2:
                        txtField.errorString = "Please enter a password!"
                    case 3:
                        txtField.errorString = "Please confirm your password!"
                    default:
                        break
                    }
                }
            }
            currentResponder = nil
        } else {return}
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            emailField.becomeFirstResponder()
            return false
        case 1:
            passwordField.becomeFirstResponder()
            return false
        case 2:
            passwordConfirmField.becomeFirstResponder()
            return false
        case 3:
            if !passwordConfirmField.isTextEmpty {
                passwordConfirmField.resignFirstResponder()
                self.checkFieldsAndAttemptSignUp {
                    success in
                    if success {
                        // Yay we were successful.  Lets continue to the next page:
                        
                    } else {
                        // Okay we will still be on this page. All the errors should have been addressed in the UI:
                        
                    }
                }
                return true
            } else {
                return false
            }
            
        default:
            // We should NEVER be hitting here:
            return true
        }
    }

    func checkFieldsAndAttemptSignUp (completion: @escaping (_ success: Bool) -> Void) {
        if let pass = passwordField.text, let passConf = passwordConfirmField.text, let email = emailField.text, let username = usernameField.text, usernameAvailable, !checkingUsernameAvailability {
            
            if pass == passConf {
                // Okay lets try and sign this guy up!
                FIRAuth.auth()?.createUser(withEmail: email, password: pass) {
                    user, error in
                    if error != nil { self.ccxLog(error: error); completion(false) }
                    // Lets set the username to the currentUser:
                    if user != nil { user?.username = username; completion(true) }
                }
            } else {
                if passwordField.showingError { passwordField.clearErrors() }
                self.passwordConfirmField.errorString =  "Your passwords do not match."
                self.ccxLog(logMessage: "Passwords do NOT match!"); completion(false)
            }
            
        } else {
            completion(false)
        }
    }
}

// Custom TextField with Logic for entered fields:
class CCXSignUpTextField: UITextField {
    private var _showingSuccess = false
    var showingSuccess : Bool {
        get {
            return self._showingSuccess
        }
        set {
            self._showingSuccess = newValue
        }
    }
    private var _showingError = false
    var showingError : Bool {
        get {
            return self._showingError
        }
        set {
            
            self._showingError = newValue
        }
    }
    private var _errorString = ""
    var errorString : String {
        get {
            return self._errorString
        }
        set {
            if self.showingError { self.clearErrors() }
            if self.showingSuccess { self.clearSuccess(); self.showingSuccess = false }
            self.showingError = true
            self.showError(stringMessage: newValue)
            self._errorString = newValue
        }
    }
    private var _successString = ""
    var successString : String {
        get {
            return self._successString
        }
        set {
            if self.showingSuccess { self.clearSuccess() }
            if self.showingError { self.clearErrors(); self.showingError = false }
            self.showingSuccess = true
            self.showSuccess(stringMessage: newValue)
            self._successString = newValue
        }
    }
}

fileprivate extension CCXSignUpTextField {
    
    var isEmailValid : Bool {
        if self.isTextEmpty { return false }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.text!)
    }
    
    var isTextEmpty : Bool  {
        if self.text == nil {
            return true
        } else if self.text!.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func checkUsernameAvailability(completion: @escaping (_ available : Bool) -> Void) {
        if self.isTextEmpty { self.errorString = "Please enter a username!"; return}
        dbRef.queryEqual(toValue: self.text).observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {
                self.successString = "Username is available!"
                completion(true)
            } else {
                self.errorString = "Username is already in use! Please try another."
                completion(false)
            }
        })
    }
    
    func checkEmailAvailability(completion: @escaping (_ available : Bool) -> Void) {
        if self.isTextEmpty { self.errorString = "Please enter an email!"; return}
        if !self.isEmailValid { self.errorString = "Invalid email address!"; return }
        usersRef.queryEqual(toValue: self.text).observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {
                self.clearErrors()
                completion(true)
            } else {
                self.errorString = "Email address is already in use! Please try another."
                completion(false)
            }
        })
    }
    
    func showError(stringMessage: String?=nil, error: Error?=nil) {
        // If we have two nil objects lets discontinue this error:
        if stringMessage == nil, error == nil || stringMessage != nil, error != nil { return }
        // Now that we know we have something to work with, lets continue:
        let label = UILabel(); label.translatesAutoresizingMaskIntoConstraints = false; label.font = UIFont(name: "Helvetica-Bold", size: 10); label.text = stringMessage ?? error?.localizedDescription; label.textColor = UIColor.red; label.alpha = 0;
        let constraints : [NSLayoutConstraint] = [ label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5), label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0) ]
        
        
        self.superview?.addSubview(label)
        self.superview?.addConstraints(constraints)
        // Finish up our animation in:
        UIView.animate(withDuration: 1.25, delay: 0.15, options: .curveEaseIn, animations: {
            label.alpha = 1
        })
    }
    
    func showSuccess(stringMessage : String) {
        let label = UILabel(); label.translatesAutoresizingMaskIntoConstraints = false; label.font = UIFont(name: "Helvetica-Bold", size: 10); label.text = stringMessage; label.textColor = UIColor.green; label.alpha = 0
        let constraints : [NSLayoutConstraint] = [ label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5), label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0) ]
        
        self.superview?.addSubview(label)
        self.superview?.addConstraints(constraints)
        UIView.animate(withDuration: 1.25, delay: 0.15, options: .curveEaseIn, animations: {
            label.alpha = 1
        })
    }
    
    func clearErrors() {
        if let labelToRemove = self.superview?.subviews.filter({ ($0 as? UILabel)?.text == self.errorString }).first {
            UIView.animate(withDuration: 1.25, delay: 0.15, options: .transitionCurlDown, animations: {
                labelToRemove.alpha = 0
            }, completion: { (finished) in
                labelToRemove.removeFromSuperview()
                self.errorString = ""
                self.showingError = false
            })
            
        }
    }
    
    func clearSuccess() {
        if let labelToRemove = self.superview?.subviews.filter({ ($0 as? UILabel)?.text == self.successString }).first {
            UIView.animate(withDuration: 1.25, delay: 0.15, options: .transitionCurlDown, animations: {
                labelToRemove.alpha = 0
            }, completion: { (finished) in
                labelToRemove.removeFromSuperview()
                self.successString = ""
                self.showingSuccess = false
            })
        }
    }
}
