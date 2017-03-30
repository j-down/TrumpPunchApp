//
//  AppDelegate.swift
//  TrumpPunch
//
//  Created by Admin on 2/20/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseCore
import XModeAPI
import Fabric
import TwitterKit
import GoogleSignIn
import Google
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
    
    static let shared = UIApplication.shared.delegate as! AppDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        FIRApp.configure()

        GADMobileAds.configure(withApplicationID: "ca-app-pub-3779823216194929~1812216696")
        
        // Activate Twitter:
        Twitter.sharedInstance().start(withConsumerKey: "qASacwlOzaezvhHrBH1CnjquB", consumerSecret: "ukkJJySoXzfjq8IqHE0CS3QfjBAYD3zgvITpB0KlnrlhUUh4ul")
        // CLIENT APP ID: 13592939
        Fabric.with([Twitter.self])
        
        // Set the Google delegate:        
        GIDSignIn.sharedInstance().delegate = self
        // Set the clientID:
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        
//        do {
//            try FIRAuth.auth()?.signOut()
//        } catch {
//            print(error)
//        }
        
        // First, lets check and see if we have an anonomous user.  We will still make them log in:
        if let user = FIRAuth.auth()?.currentUser {
            if user.isAnonymous {
                // They are an anonymous user still.. We should act like they are not logged in now:
                self.goToSignIn()
            } else {
                // Okay we should be good to go to pop them into the main view:
                self.continueToMain()
                
                // Start the XModeAPI:
                TPLocationDelegate.shared.startXModeAPI()
            }
        } else {
            // auth or current user is nil: Lets bring them to the initial setup page:
            self.goToSignIn()
        }
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //MARK:  Google-Sign-In Delegate Methods:
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        // If we have an error, we should not continue this function:
        if error != nil { return }
        
        // Okay now that we know theres no error lets check everything we need here from the sign in, lets authenticate back with Firebase:
        if let accessToken = user.authentication.accessToken, let idToken = user.authentication.idToken {
            
            // We may want to save this on our backend:
            let credential = FIRGoogleAuthProvider.credential(withIDToken: idToken,
                                                              accessToken: accessToken)
            
            FIRAuth.auth()?.signIn(with: credential, completion: { (fireBaseUser, error) in
                
                if error != nil && fireBaseUser == nil { self.ccxLog(error: error!) ; return }
                
                // Here we should take them over to the mainVC:
                
            })
            
        } else {
            // Ugh we dont have an accessToken:
            ccxLog(logMessage: "No accessToken for GoogleSignIn"); return
        }
        
    }
    
    func goToSignIn() {
        if let initialVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() {
            self.window?.rootViewController = initialVC
            self.window?.makeKeyAndVisible()
        }
    }
    
    func continueToMain() {
        if let initialVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TPBaseViewController") as? TPBaseViewController {
            self.window?.rootViewController = initialVC
            self.window?.makeKeyAndVisible()
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // If they disconnect, we should sign them out to clear the sign in sharedInstance and bring them back to the initialViewController in the main storyboard:
        GIDSignIn.sharedInstance().signOut()
        self.goToSignIn()
    }
    // Newer iOS Versions:
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        // We are popping the user out into Safari to log in:
        print(options)
        
        if FBSDKApplicationDelegate.sharedInstance().application(app,
                                                                 open: url,
                                                                 options: options) {
            // Google Login:
            return true
        } else if GIDSignIn.sharedInstance().handle(url,
                                                    sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                    annotation: options[UIApplicationOpenURLOptionsKey.annotation]) {
            // Facebook Login:
            return true
        } else if Twitter.sharedInstance().application(app, open: url, options: options) {
            // Twitter Login:
            return true
        } else {
            return false
        }
        
    }
    // Older iOS Versions:
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if GIDSignIn.sharedInstance().handle(url,
                                             sourceApplication: sourceApplication,
                                             annotation: annotation){
            return true
        } else if FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation) {
            return true
        } else {
            return false
        }
    }

}

extension FIRUser {
    var fullName : String? {
        get {
            return Defaults.string(forKey: "fullName")
        }
        set {
            // If the newvalue is nil, lets return:
            if newValue == nil {return}
            dbRef.child(self.uid).setValue(["fullName" : newValue!,"email" : self.email ?? ""]) { (error, reference) in
                if error != nil { self.ccxLog(error: error) }
                else { print("Yay - we set the fullName"); Defaults.set(newValue!, forKey: "fullName") }
            }
        }
    }
    var username : String? {
        get {
            return Defaults.string(forKey: "username")
        }
        set {
            // If the newvalue is nil, lets return:
            if newValue == nil {return}
            dbRef.child(self.uid).setValue(["username" : newValue!, "email" : self.email ?? ""]) { (error, ref) in
                if error != nil { self.ccxLog(error: error) }
                else { print("Yay - we set the username"); Defaults.set(newValue!, forKey: "username") }
            }
        }
    }
}
