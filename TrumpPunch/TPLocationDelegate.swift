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
    var delegate : HeatmapDelegate?
    
    var heatMapData : [NSValue : Double] = [:]
    
    var updatingLocation = false
    
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
            // we got this -- lets tell the world where you are....
            if let user = FIRAuth.auth()?.currentUser {
                // Okay - they must be signed in anonomously already, lets save their currentLocation:
                // Create set the location using the user uid:
                if !user.isUpdatingLocation && user.isSignedUp {
                    // Make sure the currentLocation is not nil - here we will check & make sure the users location has changed more then 50 meters:
                    if let lastLocation = user.location {
                        // If the distance is greater than or equal to 25 meters, then we will update the location:
                        if lastLocation.distance(from: newLocation.location) >= 25 {
                            // Okay lets save over the last one:
                            user.location = newLocation.location

                        }
                    // If we dont have the last location set, lets set it:
                    } else {
                        // Okay lets save over the last one:
                        user.location = newLocation.location
                    }
                }
            }
            
        } else {
            // newLocation object is nil here:
            self.ccxLog(logMessage: "newLocation object is nil")
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
        
        // Start it up using the API key:
        xmode?.start(withApiKey: xmodeAPIKey)
        
    }
    
    func getUserLocationData(withLocation: CLLocation?=nil) {
    
        // Lets get all the users locations from Firebase:
        if let cL = FIRAuth.auth()?.currentUser?.location {
            // If we have the currentLocation (above), lets query from that location using a radius of 1000 KM:
            let query = geoFire?.query(at: cL, withRadius: 1000)
            
            self.heatMapData.removeAll()
            // This is apparently how we loop through those locations:
            query?.observe(.keyEntered) {
                key, location in
                
                // Make sure the location is not nil:
                if let loc = location {
                    // Get the NSValue from the coordinate:
                    let thepoint = MKMapPointForCoordinate(loc.coordinate)
                    // Get the NSValue from the point:
                    if let value = NSValue(mkMapPoint: thepoint) {
                        // 1 is default weight:
                        self.heatMapData[value] = 1
                    }
                }
                
                    //MARK:  This AND statement checks for if the location timestamp is less than 2 weeks old & disregards the current users heat map location:
                //                if key != FIRAuth.auth()?.currentUser?.uid && (location?.timestamp.timeIntervalSinceNow.isLessThanOrEqualTo(1209600))! {
                
                //                }
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
                
                // Make sure the location is not nil:
                if let loc = location {
                    // Get the NSValue from the coordinate:
                    let thepoint = MKMapPointForCoordinate(loc.coordinate)
                    // Get the NSValue from the point:
                    if let value = NSValue(mkMapPoint: thepoint) {
                        // 1 is default weight:
                        self.heatMapData[value] = 1
                    }
                }
                
                //MARK:  This AND statement checks for if the location timestamp is less than 2 weeks old & disregards the current users heat map location:
//                if key != FIRAuth.auth()?.currentUser?.uid && (location?.timestamp.timeIntervalSinceNow.isLessThanOrEqualTo(1209600))! {
                
//                }
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
