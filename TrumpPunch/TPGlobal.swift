//
//  TPGlobal.swift
//  TrumpPunch
//
//  Created by Admin on 2/20/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

let Defaults = UserDefaults.standard

var BaseViewController = TPBaseViewController()

var MidX = UIScreen.main.bounds.midX
var MidY = UIScreen.main.bounds.midY

var Items = [TPItem]()
var Item: TPItem!

var People = [TPPerson]()
var Person: TPPerson!

var Coins: Int!

var InHomeScene: String = "HomeScene"
var InGameScene: String = "GameScene"
var InEndScene: String = "EndScene"
var InShop: String = "Shop"
var InItems: String = "Items"
var InPeople: String = "People"
var InStore: String = "Store"

var CurrentScene: String = "HomeScene"
var CurrentPage: String = "None"
var CurrentPagePart: String = "None"

var BackgroundMusic: AVAudioPlayer!
var Music: Bool = false
var Sound: Bool = false

var CommaNumberFormatter = NumberFormatter()

struct Sounds {
    
    let tomatoes = "Tomatoes"
    let nukes = "Nukes"
    let pans = "Pans"
    let fish = "Fish"
    let swatters = "Swatters"
    let gloves = "Gloves"
}

// XModeAPI Key:
let xmodeAPIKey = "s3a9tsN2vJ9J0zvjxSYD4655qQeTaIzC6Zc7ZxYD"

let locationKey = "XModeCurrentLocationKey"

// XMode Logging:
func xmodeLog(logMessage: String?=nil, error: Error?=nil, functionString: String, line: String) {
    // If error is not nil:
    if let er = error {
        print("Function: \(functionString), Line: \(line) : \(er.localizedDescription)")
    // If the log message is not nil:
    } else if let logMsg = logMessage {
        print("Function: \(functionString), Line: \(line) : \(logMsg)")
    } else {
        print("Function: \(functionString), Line: \(line) : Unknown Error")
    }
}
