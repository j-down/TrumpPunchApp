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
import StoreKit
import SpriteKit
import Firebase
import XModeAPI

let Defaults = UserDefaults.standard

var BaseViewController = TPBaseViewController()

var MidX = UIScreen.main.bounds.midX
var MidY = UIScreen.main.bounds.midY

var Items = [TPItem]()
var Item: TPItem!

var People = [TPPerson]()
var Person: TPPerson!

var Products = [SKProduct]()

var Coins: Int!

var InHomeScene: String = "HomeScene"
var InGameScene: String = "GameScene"
var InEndScene: String = "EndScene"
var InShop: String = "Shop"
var InItems: String = "Items"
var InPeople: String = "People"
var InStore: String = "Store"

var CurrentScene: String = "HomeScene"
var ThisScene = SKScene()
var CurrentPage: String = "None"
var CurrentPagePart: String = "None"

//Scenes
var ThisEndScene: TPEndScene!
var ThisHomeScene: TPHomeScene!
var ThisGameScene: TPGameScene!
var ThisGlobalScene: TPGlobalScene!
var ThisSKView: SKView!

var BackgroundMusic: AVAudioPlayer!
var Music: Bool = false
var Sound: Bool = false

var CommaNumberFormatter = NumberFormatter()

var LeaderboardID: String = ""

var TimeSinceAdPlayed: Int = 0

var Debug: Bool = false

//Game
var Score: Int = 0
var gameStart: Bool = false
var streakScore: Int = 0
var roundNumber: Int = 1
var canPlay: Bool = true
var speedClock: Int = 1
var scoreToSave: Int = 0
var coGold: Int = 8
var lifeCount: Int = 3
var trumpEx: Bool = false
var trumpExLeft: Bool = false

struct Sounds {
    
    static let tomatoes = "Fish"
    static let nukes = "Nuke"
    static let fish = "Fish"
    static let swatters = "Swatter"
    static let gloves = "Punch"
    
    static let start = "Start"
    static let score = "Score"
    static let gameOver = "GameOver"
    
    static let background = "AppMusic"
    static let button = "Button"
    static let wrong = "Wrong"
}

struct DefaultType {
    
    static let coins = "Coins"
    static let firstLaunch = "FirstLaunchComplete"
    static let currentPerson = "CurrentPerson"
    static let currentItem = "CurrentItem"
    static let sound = "Sound"
    static let music = "Music"
    static let highScore = "HighScore"
    static let tutorial = "Tutorial"
}

struct SceneType {
    
    static let homeScene = "HomeScene"
    static let gameScene = "GameScene"
    static let endScene = "EndScene"
}

struct WeaponCoins {
    
    static let tomatoes = 10
    static let fish = 50
    static let swatters = 250
    static let gloves = 1500
    static let nukes = 10000
}

struct WeaponType {
    
    static let tomatoes = "Tomatoes"
    static let fish = "Fish"
    static let swatters = "Swatters"
    static let gloves = "Gloves"
    static let nukes = "Nukes"
}

// XModeAPI Key:
let xmodeAPIKey = "s3a9tsN2vJ9J0zvjxSYD4655qQeTaIzC6Zc7ZxYD"

// XModeAPI Notification Keys:
let sdkLocationKey = "XModeCurrentLocationKey"

// XMode sharedInstance:
let xmode = XModeAPI.sharedInstance()

// Database References:
let dbRef = FIRDatabase.database().reference(withPath: "users_location")
let usersRef = FIRDatabase.database().reference(withPath: "users")
let geoFire = GeoFire(firebaseRef: FIRDatabase.database().reference(withPath: "users_location"))

// CCX Logging:
extension NSObject {
    func ccxLog(logMessage: String?=nil, error: Error?=nil, fileName : String = #file , functionName: String = #function, lineOfCode : Int = #line) {
        // If error is not nil:
        if let er = error {
            print("CCX Logging -> File: \(fileName), Function: \(functionName), Line: \(lineOfCode) Error: \(er.localizedDescription)")
            // If the log message is not nil:
        } else if let logMsg = logMessage {
            print("CCX Logging -> File: \(fileName), Function: \(functionName), Line: \(lineOfCode) Message: \(logMsg)")
        } else {
            print("CCX Logging -> File: \(fileName), Function: \(functionName), Line: \(lineOfCode) Error: Unknown Error")
        }
    }
}
