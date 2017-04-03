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

class TPInitialLoginViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet var trumpTitleConstraint : NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // We need to change the multiplier here for the 3:2 ratio screen:
        if UIScreen.main.bounds.height == 480 { trumpTitleConstraint.setMultiplier(multiplier: 0.6) }
        // Set the signIn uiDelegate so we can talk back to our AppDelegate:
        GIDSignIn.sharedInstance().uiDelegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func googleSignInPressed(sender: UIButton) {
        // This is handled u=in the AppDelegate delegate function for GIDSignIn:
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func facebookSignInPressed(sender: UIButton) {
        FBSDKLoginManager().logIn(withReadPermissions: ["public_profile"], from: self) { (result, error) in
            // User cancelled facebook:
            if let _ = result?.isCancelled { print("User cancelled facebook login."); return }
            
            if error == nil, let token = result?.token.tokenString  {
                // Okay here we should try logging them in:
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: token)
                self.signInWithoAuthCredentials(credential: credential, facebook: result)
                
            } else {
                print(error ?? "NIL ERROR -- NO ACTION")
            }
            
        }
    }
    
    @IBAction func twitterSignInPressed(sender: UIButton) {
        Twitter.sharedInstance().logIn { session, er in
            if (session != nil) {
                // Get the credentials & then sign in:
                let credential = FIRTwitterAuthProvider.credential(withToken: session!.authToken, secret: session!.authTokenSecret)
                self.signInWithoAuthCredentials(credential: credential, twitter: session)
                
            } else if let error = er {
                print("TWITTER LOGIN ERROR: \(error.localizedDescription)");
            }
        }
    }
    
    func signInWithoAuthCredentials(credential: FIRAuthCredential, twitter: TWTRSession?=nil, facebook: FBSDKLoginManagerLoginResult?=nil) {
        // Lets first check if the users have set this stuff so we dont do it over again:
        
        // We should also sync NSUserDefaults here since it was probably cleared and we extended the FIRAuth current user to use this:

        // Okay they haven't yet. Lets go and get their name & photoURL:
        var name = ""
        var photoURL = ""
        if twitter != nil {
            // Twitter:
            TWTRAPIClient().loadUser(withID:  twitter!.userID) {
                user, error in
                if error != nil {
                    print(error!)
                }
                if user != nil {
                    name = user!.name
                    photoURL = user!.profileImageMiniURL
                }

            }
            
        } else if facebook != nil {
            
            // Facebook:
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name, picture"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil) {
                    let fbDetails = result as! NSDictionary
                    print(fbDetails)
                }else{
                    print(error?.localizedDescription ?? "Not found")
                }
            })
        }
        
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error == nil {
                // Yay we signed in... lets take them to the main page:
                
                AppDelegate.shared.continueToMain()
            } else {
                print(error ?? "NIL ERROR")
            }
        })
    }

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
