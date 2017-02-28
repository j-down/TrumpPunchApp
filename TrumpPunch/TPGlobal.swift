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

var BackgroundMusic: AVAudioPlayer!
var Music: Bool = false
var Sound: Bool = false

var CommaNumberFormatter = NumberFormatter()

struct Sounds {
    
    static let tomatoes = "Tomatoes"
    static let nukes = "Nukes"
    static let pans = "Pans"
    static let fish = "Fish"
    static let swatters = "Swatters"
    static let gloves = "Gloves"
    static let background = "AppMusic.mp3"
    
}

struct DefaultType {
    
    static let coins = "Coins"
    static let firstLaunch = "FirstLaunchComplete"
    static let currentPerson = "CurrentPerson"
    static let currentItem = "CurrentItem"
    static let sound = "Sound"
    static let music = "Music"
}
