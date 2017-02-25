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

class TPLocationManager: NSObject, CLLocationManagerDelegate {

    // Create out singlton shared instance
    static let shared = TPLocationManager()
    
    private override init() {
        super.init()
        
        // NOTE: We are using the notifications from the XModeAPI
        NotificationCenter.default.addObserver(self, selector: #selector(locationUpdated), name: Notification.Name.CurrentLocationDidChange, object: nil)
        
    }
    
    //MARK: XModeAPI Notification functions:
    func locationUpdated (notification: Notification) {
        
        // Yay location updated! :)
        let userInfo = notification.userInfo
        
        if let newLocation = userInfo?["CurrentLocationKey"] as? XModeSdkVisitedPlace {
            // we got this -- lets tell the world where you are....
            print(newLocation)
        } else {
            // newLocation object is nil here:
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
    
}
