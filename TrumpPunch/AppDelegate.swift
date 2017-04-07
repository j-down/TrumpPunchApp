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
import FBSDKLoginKit
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
            
        // First, lets check and see if we have an anonomous user.  We will still make them log in:
        if let user = FIRAuth.auth()?.currentUser {
            if user.isAnonymous {
                // They are an anonymous user still.. We need to log them out:  This will take them back to the login page too:
                user.logout()
                
            } else {
                // Okay we should be good to go to pop them into the main view:
                self.continueToMain()
        
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
                
                if fireBaseUser != nil { fireBaseUser?.syncProfile();self.continueToMain() }
                
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
            // Start the XModeAPI:
            TPLocationDelegate.shared.startXModeAPI()
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // If they disconnect, we should sign them out to clear the sign in sharedInstance and bring them back to the initialViewController in the main storyboard:
        FIRAuth.auth()?.currentUser?.logout()
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
    
    /// Once the user is signed up, then we know if we can send the location update to Firebase:
    var isSignedUp : Bool {
        get {
            if let result = Defaults.object(forKey: "isSignedUp") as? Bool {
                return result
            } else {
                return false
            }
        }
        set {
            Defaults.set(newValue, forKey: "isSignedUp")
        }
    }
    
    /// The number of punches the user has punched Donald Trump.
    var trumpPunches : Int {
        get {
            if let punches = Defaults.object(forKey: "trumpPunches") as? Int {
                return punches
            } else {
                return 0
            }
        }
        set {
            Defaults.set(newValue, forKey: "trumpPunches")
        }
    }
    /// The number of punches the user has incremented during a game, punching Donald Trump.
    var incrementedTrumpPunches : Int {
        get {
            if let punches = Defaults.object(forKey: "incTrumpPunches") as? Int {
                return punches
            } else {
                return 0
            }
        }
        set {
            Defaults.set(newValue, forKey: "incTrumpPunches")
        }
    }
    /// The function that increments 'incrementedTrumpPunches' by either 1 or a specified value.
    func incrementTrumpPunches(by: Int?=1) {
        incrementedTrumpPunches += by!
    }
    /// This function saves the value of trumpPunches to the Firebase backend.
    func saveTrumpPunches () {
        if incrementedTrumpPunches > 0 {
            let totalPunches = trumpPunches + incrementedTrumpPunches
            dbRef.child("\(self.uid)/trumpPunches").setValue(totalPunches, withCompletionBlock: { (error, ref) in
                if error == nil {
                    self.trumpPunches += self.incrementedTrumpPunches
                    self.incrementedTrumpPunches = 0
                }
            })
        }
    }
    ///  This returns the saved boolean for if the user is upating location from NSUserDefaults.
    var isUpdatingLocation : Bool {
        get {
            if let result = Defaults.object(forKey: "isUpdatingLocation") as? Bool {
                return result
            } else {
                return false
            }
        }
        set {
            Defaults.set(newValue, forKey: "isUpdatingLocation")
        }
    }
    ///  This returns the saved location of the user from NSUserDefaults.
    var location : CLLocation? {
        get {
            if let dic = Defaults.object(forKey: "firebaseLocation") as? NSDictionary {
                if let lat = dic.value(forKey: "lat") as? CLLocationDegrees, let lon = dic.value(forKey: "lon") as? CLLocationDegrees {
                    let location = CLLocation(latitude: lat , longitude: lon)
                    return location
                } else {
                    return nil
                }
            } else {
                return nil
            }
        }
        set {
            if newValue == nil {return}
            self.isUpdatingLocation = true
            let data = ["lat":newValue!.coordinate.latitude, "lon" : newValue!.coordinate.longitude]
            Defaults.set(data, forKey: "firebaseLocation")
            geoFire?.setLocation(newValue!, forKey: self.uid, withCompletionBlock: { (error) in
                self.isUpdatingLocation = false
            })
        }
    }
    
    /// The email address of the Firebase user.
    var emailAddress : String? {
        get {
            return self.email
        }
        set {
            if newValue == nil {return}
            if newValue!.isEmpty {return}
            self.wasEmailSet {
                set in
                if !set {
                    if newValue == self.email { dbRef.child("\(self.uid)/email").setValue(newValue!) ; return } else {
                        self.updateEmail(newValue!) { (error) in
                            if error != nil {
                                print(error!)
                            } else {
                                dbRef.child("\(self.uid)/email").setValue(newValue!)
                            }
                        }
                    }
                } else {
                    if newValue == self.email {return} else {
                        self.updateEmail(newValue!) { (error) in
                            if error != nil {
                                print(error!)
                            } else {
                                dbRef.child("\(self.uid)/email").setValue(newValue!)
                            }
                        }
                    }
                }
            }
        }
    }
    ///  This function depicts whether or not the user had set their email in the users_locations table in Firebase.
    func wasEmailSet(block: @escaping (_ set: Bool) -> Void) {
        dbRef.child(self.uid).child("email").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                block(true)
            } else {
                block(false)
            }
        })
    }
    ///  This returns the saved pictureURL of the user from NSUserDefaults.
    var pictureURL : String? {
        get {
            return Defaults.string(forKey: "pictureURL")
        }
        set {
            // If the newvalue is nil, lets return:
            if newValue == nil {return}
            if newValue == pictureURL {return}
            if newValue!.isEmpty {return}
            if !newValue!.contains("https") && newValue!.contains("http") {
                var newString = newValue!
                let ind = newString.index(newString.startIndex, offsetBy: 4)
                newString.insert("s", at: ind)
                
                dbRef.child("\(self.uid)/pictureURL").setValue(newString) { (error, reference) in
                    if error != nil { self.ccxLog(error: error) }
                    else { print("Updated pictureURL on FIRBase"); Defaults.set(newString, forKey: "pictureURL") }
                }
                
            } else {
                dbRef.child("\(self.uid)/pictureURL").setValue(newValue!) { (error, reference) in
                    if error != nil { self.ccxLog(error: error) }
                    else { print("Updated pictureURL on FIRBase"); Defaults.set(newValue!, forKey: "pictureURL") }
                }
            }
        }
    }
    ///  This returns the saved full name of the user from NSUserDefaults.
    var fullName : String? {
        get {
            return Defaults.string(forKey: "fullName")
        }
        set {
            // If the newvalue is nil, lets return:
            if newValue == nil {return}
            if newValue == fullName {return}
            if newValue!.isEmpty {return}
            dbRef.child("\(self.uid)/fullName").setValue(newValue!) { (error, reference) in
                if error != nil { self.ccxLog(error: error) }
                else { print("Updated fullname on FIRBase"); Defaults.set(newValue!, forKey: "fullName") }
            }
        }
    }
    ///  This returns the saved username of the user from NSUserDefaults.
    var username : String? {
        get {
            return Defaults.string(forKey: "username")
        }
        set {
            // If the newvalue is nil, lets return:
            if newValue == nil {return}
            if newValue == username {return}
            if newValue!.isEmpty {return}
            dbRef.child("\(self.uid)/username").setValue(newValue!) { (error, ref) in
                if error != nil { self.ccxLog(error: error) }
                else { print("Updated username on FIRBase"); Defaults.set(newValue!, forKey: "username") }
            }
        }
    }
    
    /**
     This clears all the user profile data that we save in **NSUserDefaults**.  This is used for when we **logout** the user.
    */
    func clearCachedData() {
        Defaults.removeObject(forKey: "fullName")
        Defaults.removeObject(forKey: "username")
        Defaults.removeObject(forKey: "pictureURL")
        Defaults.removeObject(forKey: "incTrumpPunches")
        Defaults.removeObject(forKey: "trumpPunches")
        Defaults.removeObject(forKey: "firebaseLocation")
        Defaults.removeObject(forKey: "isUpdatingLocation")
        Defaults.removeObject(forKey: "isSignedUp")
    }
    /**
     This **clears all** the user profile data that we save in **NSUserDefaults**.  This is a **wrapper** function around the FIRAuth signOut method.  This also takes the user to the **initial sign in page**.
     */
    func logout () {
        do {
            for auth in self.providerData {
                switch auth.providerID {
                case "google.com":
                    GIDSignIn.sharedInstance().signOut()
                case "twitter.com":
                    if let session = Twitter.sharedInstance().sessionStore.session() {
                        Twitter.sharedInstance().sessionStore.logOutUserID(session.userID)
                    }
                case "facebook.com":
                    let loginManager = FBSDKLoginManager()
                    loginManager.logOut()
                default:
                    break
                }
            }
            try FIRAuth.auth()?.signOut()
            self.clearCachedData()
            AppDelegate.shared.goToSignIn()
        } catch  {
            print(error)
        }
    }
    
    /**
     This will sych the users profile from the backend & save everything we need on the frontend.  If the data doesn't exist for the user, then we know its a new user and then we will set everything we need on the backend which will in return save it on the frontend for our use.
     
     ## Important Notes ##
     1. If the user is logging back in we check & sych data back on the frontend.
     2. If it is a new user we sych back on the backend & save on the frontend.
     3. Email & Username users will only be setting their username & email for now until we give them a way to enter in more information.
     
     */
    func syncProfile(twitter: TWTRSession?=nil, facebook: FBSDKLoginManagerLoginResult?=nil, userName: String?=nil) {
        dbRef.child(self.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if snapshot.hasChild("fullName") {
                    self.fullName = snapshot.childSnapshot(forPath: "fullName").value as? String
                } else {
                    self.fullName = self.displayName
                }
                if snapshot.hasChild("username") {
                    self.username = snapshot.childSnapshot(forPath: "username").value as? String
                } else {
                    if let username = twitter?.userName {
                        self.username = username
                    }
                }
                if snapshot.hasChild("pictureURL") {
                    self.pictureURL = snapshot.childSnapshot(forPath: "pictureURL").value as? String
                } else {
                    self.pictureURL = self.photoURL?.absoluteString
                }
                if !snapshot.hasChild("email") {
                    if let email = self.email {
                        self.emailAddress = email
                        if let name = self.fullName {
                            xmode?.setEmailAddress(email, name: name, phoneNumber: "")
                        }
                        xmode?.setEmailAddress(email)
                    }
                }
                if snapshot.hasChild("trumpPunches") {
                    if let punches = snapshot.childSnapshot(forPath: "trumpPunches").value as? Int {
                        self.trumpPunches = punches
                    }
                    // This is to update the backend.. This is a weird state - shouldnt happen:
                } else if self.trumpPunches > 0 {
                    self.saveTrumpPunches()
                }
            } else {
                // This user hasnt set anything yet:
                self.fullName = self.displayName
                self.pictureURL = self.photoURL?.absoluteString
                if let email = self.email {
                    self.emailAddress = email
                    if let name = self.fullName {
                        xmode?.setEmailAddress(email, name: name, phoneNumber: "")
                    }
                    xmode?.setEmailAddress(email)
                }
                if let usrnme = twitter?.userName {
                    self.username = usrnme
                }
                
                if let uN = userName {
                    self.username = uN
                }
                
                self.isSignedUp = true
            }
        })
    }
}
