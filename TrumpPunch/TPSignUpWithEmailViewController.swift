//
//  SignUpWithEmailViewController.swift
//  TrumpPunch
//
//  Created by Ryan Coyne on 3/29/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import UIKit
import Firebase

class TPSignUpWithEmailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var usernameField : CCXSignUpTextField!
    @IBOutlet var emailField : CCXSignUpTextField!
    @IBOutlet var passwordField : CCXSignUpTextField!
    @IBOutlet var passwordConfirmField : CCXSignUpTextField!
    
    @IBOutlet weak var scrollView : UIScrollView!
    
    @IBOutlet weak var fieldView : UIView!
    
    var currentResponder : CCXSignUpTextField?
    
    var scrollBack = false
    
    //MARK: Override Functions:
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
        if let txtField = textField as? CCXSignUpTextField {
            if !txtField.isTextEmpty {
                if txtField.showingError {
                    switch txtField.tag {
                    case 0:
                        txtField.checkUsernameAvailability {
                            available in
                        }
                    case 1:
                        txtField.checkEmailAvailability {
                            available in
                        }
                    case 2:
                        if !txtField.isTextEmpty && txtField.showingError {
                            txtField.clearErrors()
                        }
                        if !txtField.isTextEmpty && passwordConfirmField.text == txtField.text {
                            passwordConfirmField.clearErrors()
                        }
                        if !txtField.isTextEmpty && passwordConfirmField.text != txtField.text && !passwordConfirmField.isTextEmpty {
                            passwordConfirmField.errorString = "Your passwords do not match."
                        }
                    case 3:
                        if !txtField.isTextEmpty && passwordField.text != txtField.text {
                            if passwordField.showingError { passwordField.clearErrors() }
                            txtField.errorString = "Your passwords do not match."
                        } else if !txtField.isTextEmpty && txtField.text == passwordField.text {
                            if passwordField.showingError { passwordField.clearErrors() }
                            txtField.clearErrors()
                        }
                    default:
                        break
                    }
                } else {
                    switch txtField.tag {
                    case 0:
                        txtField.checkUsernameAvailability {
                            available in
                        }
                    case 1:
                        txtField.checkEmailAvailability {
                            success in
                        }
                    case 2:
                        if !txtField.isTextEmpty && passwordConfirmField.text == txtField.text {
                            passwordConfirmField.clearErrors()
                        } else if !txtField.isTextEmpty && passwordConfirmField.text != txtField.text && !passwordConfirmField.isTextEmpty {
                            passwordConfirmField.errorString = "Your passwords do not match."
                        }
                    case 3:
                        if  !txtField.isTextEmpty && txtField.text != passwordField.text {
                            if passwordField.showingError { passwordField.clearErrors() }
                            txtField.errorString = "Your passwords do not match."
                        } else if !txtField.isTextEmpty && txtField.text == passwordField.text {
                            txtField.clearErrors()
                        }
                    default:
                        break
                    }
                }
            } else  {
                // If we were showing a success, and the textfield is empty, then we need to clear out the success.
                switch txtField.tag {
                case 0:
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
            if !passwordConfirmField.isTextEmpty && !usernameField.showingError && !emailField.showingError && !passwordConfirmField.showingError {
                passwordConfirmField.resignFirstResponder()
                self.checkFieldsAndAttemptSignUp {
                    success, error, errorString in
                    if success {
                        // Yay we were successful.  Lets continue to the next page:
                        AppDelegate.shared.continueToMain()
                    } else if let er = error {
                        // Okay we will still be on this page. All the errors should have been addressed in the UI:
                        self.showError(error: er)
                    } else if let erString = errorString {
                        self.showErrorString(errorString: erString)
                    }
                
                }
                return true
            } else {
                self.showErrorString(errorString: "Please check the required fields before finalizing your sign-up!")
                return false
            }
            
        default:
            // We should NEVER be hitting here:
            return true
        }
    }

    func checkFieldsAndAttemptSignUp (completion: @escaping (_ success: Bool, _ error: Error?, _ errorString : String?) -> Void) {
        if let pass = passwordField.text, let passConf = passwordConfirmField.text, let email = emailField.text, let username = usernameField.text, usernameField.usernameAvailable, emailField.emailAvailable {
            
            if pass == passConf {
                // Okay lets try and sign this guy up!
                FIRAuth.auth()?.createUser(withEmail: email, password: pass) {
                    user, error in
                    if error != nil { self.ccxLog(error: error); completion(false, error, nil) }
                    // Lets set the username to the currentUser:
                    if user != nil { user?.sendEmailVerification(completion: { (error) in
                        if error == nil {
                            // Email verification was sent!
                        }
                    }) ;user?.syncProfile(userName: username); completion(true, nil, nil); }
                }
            } else {
                if passwordField.showingError { passwordField.clearErrors() }
                self.passwordConfirmField.errorString =  "Your passwords do not match."
                self.ccxLog(logMessage: "Passwords do NOT match!"); completion(false, nil, "Your passwords do not match.")
            }
            
        } else {
            if !usernameField.usernameAvailable {
                completion(false, nil, "Username is not available.")
            }
            
        }
    }
}

// Custom TextField with Logic for entered fields:
class CCXSignUpTextField: UITextField {
    
    private var _checkingEmail = false
    var checkingEmail : Bool {
        get {
            return self._checkingEmail
        }
        set {
            self._checkingEmail = newValue
        }
    }
    
    private var _emailAvailable = false
    var emailAvailable : Bool {
        get {
            return self._emailAvailable
        }
        set {
            self._emailAvailable = newValue
        }
    }
    
    private var _usernameAvailable = false
    var usernameAvailable : Bool {
        get {
            return self._usernameAvailable
        }
        set {
            self._usernameAvailable = newValue
        }
    }
    
    private var _checkingUsername = false
    var checkingUsername : Bool {
        get {
            return self._checkingUsername
        }
        set {
            self._checkingUsername = newValue
        }
    }
    
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
            if self._showingSuccess { self.clearSuccess() }
            
            if newValue == "" && !self.errorString.isEmpty { self.clearErrors(); return }
            if self.errorString != newValue { self.clearErrors() } else { return }
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
            if self._showingError { self.clearErrors() }
            if newValue == "" && !self.successString.isEmpty { self.clearSuccess(); return }
            if self.successString != newValue { self.clearSuccess() } else { return }
            self.showingSuccess = true
            self.showSuccess(stringMessage: newValue)
            self._successString = newValue
        }
    }
    
    func clearErrors() {
        if let labelToRemove = self.superview?.subviews.filter({ ($0 as? UILabel)?.text == self.errorString }).first {
            self._showingError = false
            self._errorString = ""
            UIView.animate(withDuration: 1.25, delay: 0.15, options: .transitionCurlDown, animations: {
                labelToRemove.alpha = 0
            }, completion: { (finished) in
                labelToRemove.removeFromSuperview()
            })
            
        }
    }
    
    func clearSuccess() {
        if let labelToRemove = self.superview?.subviews.filter({ ($0 as? UILabel)?.text == self.successString }).first {
            self._showingSuccess = false
            self._successString = ""
            UIView.animate(withDuration: 1.25, delay: 0.15, options: .transitionCurlDown, animations: {
                labelToRemove.alpha = 0
            }, completion: { (finished) in
                labelToRemove.removeFromSuperview()
            })
        }
    }
}

fileprivate extension TPSignUpWithEmailViewController {
    func showError(error: Error) {
        let alertController = UIAlertController(title: "Error signing up!", message: error.localizedDescription, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okayAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showErrorString(errorString : String) {
        let alertController = UIAlertController(title: "Error signing up!", message: errorString, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okayAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension CCXSignUpTextField {
    
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
        self.checkingUsername = true
        if self.isTextEmpty { self.usernameAvailable=false;self.checkingUsername = false; self.errorString = "Please enter a username!"; completion(false); return }
        dbRef.queryOrdered(byChild: "username").queryEqual(toValue: self.text!).observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {
                self.checkingUsername = false
                self.usernameAvailable = true
                self.successString = "Username is available!"
                completion(true)
            } else {
                self.checkingUsername = false
                self.usernameAvailable = false
                self.errorString = "Username is already in use! Please try another."
                completion(false)
            }
        })
    }
    
    func checkEmailAvailability(completion: @escaping (_ available : Bool) -> Void) {
        self.checkingEmail = true
        if self.isTextEmpty {self.emailAvailable=false;self.errorString="Please enter an email!";self.checkingEmail=false;completion(false);return}
        if !self.isEmailValid {self.emailAvailable=false;self.errorString="Invalid email address format!";completion(false);self.checkingEmail = false;return}
        dbRef.queryOrdered(byChild: "email").queryEqual(toValue: self.text!).observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {
                self.checkingEmail = false;self.emailAvailable = true;self.clearErrors()
                completion(true)
            } else {
                self.checkingEmail = false;self.emailAvailable = false;self.errorString = "Email address is already in use! Please try another."
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
}
