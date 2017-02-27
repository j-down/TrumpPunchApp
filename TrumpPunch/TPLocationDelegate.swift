//
//  TPLocationManager.swift
//  TrumpPunch
//
//  Created by Ryan Coyne on 2/24/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation
import CoreLocation
import XModeAPI
import Firebase
import MapKit

final class TPLocationDelegate: NSObject, CLLocationManagerDelegate {

    // Create out singlton shared instance
    static let shared = TPLocationDelegate()
    
    // The current location will be checked before going & retreiving all the other users locations:
    var currentLocation : CLLocation?=nil
    
    var delegate : HeatmapDelegate?
    
    var heatMapData : [NSValue : Double] = [:]
    
    var updatingLocation = false
    
    // Create the dbReference pointing to the users locations:
    let geoFire = GeoFire(firebaseRef: FIRDatabase.database().reference(withPath: "users_location"))
    
    private override init() {
        super.init()
        
        // NOTE: We are using the notifications from the XModeAPI for updating the users locations:
        NotificationCenter.default.addObserver(self, selector: #selector(locationUpdated), name: Notification.Name.CurrentLocationDidChange, object: nil)
        
    }
    
    //MARK: XModeAPI Notification functions:
    func locationUpdated (notification: Notification) {
        // Yay location updated! :)  Lets do our thangg:
        let userInfo = notification.userInfo
        // Check if the newLocation is nil here, this way we are not dealing with an optional:
        if let newLocation = userInfo?[sdkLocationKey] as? XModeSdkVisitedPlace {
            // Set the current location:
//            currentLocation = newLocation.location
            // we got this -- lets tell the world where you are....
            if let user = FIRAuth.auth()?.currentUser {
                // Okay - they must be signed in anonomously already, lets save their currentLocation:
                // Create set the location using the user uid:
                if self.updatingLocation == false {
                    // Make sure the currentLocation is not nil:
                    if let lastLocation = self.currentLocation {
                        // If the distance is greater than or equal to 50 meters, then we will update the location:
                        if lastLocation.distance(from: newLocation.location) >= 50 {
                            // Set the updatingLcation to true so we dont keep hitting this:
                            self.updatingLocation = true
                            // Okay lets save over the last one:
                            self.geoFire?.setLocation(newLocation.location, forKey: user.uid) {
                                error in
                                // Update the boolean now that we are done with our asych:
                                self.updatingLocation = false
                                // If the error is not nil, lets print the error:
                                if error != nil {
                                    xmodeLog(error: error, functionString: String(#function), line: String(#line))
                                    // Lets just put this here for now:
                                } else {
                                    print("Saved NEW location for CURRENT user!")
                                }
                            }
                        }
                    }
                }
                
            } else {
                // Ugh oh - they dont have an account right now - we will just have to create another one:
                if self.updatingLocation == false {
                    self.updatingLocation = true
                    FIRAuth.auth()?.signInAnonymously() {
                        //  Okay lets set their location:
                        user, error in
                        self.updatingLocation = false
                        // Check if the user is nil:
                        if let thisUser = user {
                            // User is not nil, lets set the location:
                            self.geoFire?.setLocation(newLocation.location, forKey: thisUser.uid) {
                                error in
                                print("Saved NEW location for NEW user!")
                            }
                        } else {
                            // User is nil:
                            xmodeLog(logMessage: "check for user being nil -- well its nil...", functionString: String(#function), line: String(#line))
                        }
                    }
                }
            }
            // Update the currentLocation for the next notification call from the SDK:
            currentLocation = newLocation.location
            
        } else {
            // newLocation object is nil here:
            xmodeLog(logMessage: "newLocation object is nil", functionString: String(#function), line: String(#line))
        }
    }
    
    //MARK: Status Functions:
    func isLocationAuthorized () -> Bool {
        
        // If we are always authorized - then we are 'authorized' in our book:
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            return true
        default:
            return false
        }
        
    }
    
    //MARK: Start XModeAPI:
    func startXModeAPI () {
        
        // Grab the XModeAPI instance:
        let xmode = XModeAPI.sharedInstance()
        // Start it up using the API key:
        xmode?.start(withApiKey: xmodeAPIKey)
        
    }
    
    func getUserLocationData(withLocation: CLLocation?=nil) {
    
        // Lets get all the users locations from Firebase:
        if let cL = currentLocation {
            // If we have the currentLocation (above), lets query from that location using a radius of 1000 KM:
            let query = geoFire?.query(at: cL, withRadius: 1000)
            
            self.heatMapData.removeAll()
            // This is apparently how we loop through those locations:
            query?.observe(.keyEntered) {
                key, location in
                
                // Keys are unique & set from current user (we will check this to see if we need to actually add it in:)
                if key != FIRAuth.auth()?.currentUser?.uid {
                    
                    //MARK:  This AND statement checks for if the location timestamp is less than 2 weeks old:
        //            && (location?.timestamp.timeIntervalSinceNow.isLessThanOrEqualTo(1209600))! {
                    
                    // Here we can add the location into an array to show for the heatmap:
                    if let loc = location {
                        // Get the NSValue from the coordinate:
                        let thepoint = MKMapPointForCoordinate(loc.coordinate)
                        // Get the NSValue from the point:
                        if let value = NSValue(mkMapPoint: thepoint) {
                            // 1 is default weight:
                            self.heatMapData[value] = 1
                        }
                    }
                }
            }
            // This will tell us when we are done observing:
            query?.observeReady({
                self.delegate?.updateHeatmapData(data: self.heatMapData)
            })
            
        } else {
            // Lets check if we sent in the location:
            let query = geoFire?.query(at: withLocation, withRadius: 1000)
            
            self.heatMapData.removeAll()
            // This is apparently how we loop through those locations:
            query?.observe(.keyEntered) {
                key, location in
                
                // Keys are unique & set from current user (we will check this to see if we need to actually add it in:)
                if key != FIRAuth.auth()?.currentUser?.uid {
                    //MARK:  This AND statement checks for if the location timestamp is less than 2 weeks old:
         //           && (location?.timestamp.timeIntervalSinceNow.isLessThanOrEqualTo(1209600))! {
                    
                    // Here we can add the location into an array to show for the heatmap:
                    if let loc = location {
                        // Get the NSValue from the coordinate:
                        let thepoint = MKMapPointForCoordinate(loc.coordinate)
                        // Get the NSValue from the point:
                        if let value = NSValue(mkMapPoint: thepoint) {
                            // 1 is default weight:
                            self.heatMapData[value] = 1
                        }
                    }
                }
            }
            // This will tell us when we are done observing:
            query?.observeReady({
                // We are finished loading i think?:
                self.delegate?.updateHeatmapData(data: self.heatMapData)
            })
        }
    }
}
// Delegate Protocol:
protocol HeatmapDelegate {
    func updateHeatmapData(data: [NSValue : Double])
}
