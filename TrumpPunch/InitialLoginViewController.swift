//
//  InitialLoginViewController.swift
//  TrumpPunch
//
//  Created by Ryan Coyne on 3/28/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import UIKit
import GoogleSignIn
import Google
import TwitterKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase

class InitialLoginViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet var trumpTitleConstraint : NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        switch UIScreen.main.bounds.height {
        case 480:
            trumpTitleConstraint.setMultiplier(multiplier: 0.6)
        default:
            break
        }
        // Set the signIn uiDelegate so we can talk back to our AppDelegate:
        GIDSignIn.sharedInstance().uiDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func googleSignInPressed(sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func facebookSignInPressed(sender: UIButton) {
        FBSDKLoginManager.init().logIn(withReadPermissions: ["public_profile"], from: self) { (result, error) in
            // User cancelled facebook:
            if let _ = result?.isCancelled {print("User cancelled facebook login.");return}
            
            if error == nil, let token = result?.token.tokenString  {
                // Okay here we should try logging them in:
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: token)
                self.signInWithoAuthCredentials(credential: credential)
            } else {
                print(error ?? "NIL ERROR -- NO ACTION")
            }
            
        }
    }
    
    @IBAction func twitterSignInPressed(sender: UIButton) {
        Twitter.sharedInstance().logIn { session, error in
            if (session != nil) {
                print("signed in as \(session?.userName)");
                let credential = FIRTwitterAuthProvider.credential(withToken: session!.authToken, secret: session!.authTokenSecret)
                self.signInWithoAuthCredentials(credential: credential)
            } else {
                print("error: \(error?.localizedDescription)");
            }
        }
    }
    
    func signInWithoAuthCredentials(credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error == nil {
                // Yay we signed in... lets take them to the main page:
                AppDelegate.shared.continueToMain()
            } else {
                print(error ?? "NIL ERROR")
            }
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NSLayoutConstraint {
    func setMultiplier(multiplier:CGFloat) {
        
        let newConstraint = NSLayoutConstraint(
            item: self.firstItem,
            attribute: self.firstAttribute,
            relatedBy: self.relation,
            toItem: self.secondItem,
            attribute: self.secondAttribute,
            multiplier: multiplier,
            constant: self.constant)
        
        newConstraint.priority = self.priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        NSLayoutConstraint.deactivate([self])
        NSLayoutConstraint.activate([newConstraint])
        
    }
}
