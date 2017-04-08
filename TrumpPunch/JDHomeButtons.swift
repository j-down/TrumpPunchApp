//
//  JDHomeButtons.swift
//  TrumpPunch
//
//  Created by Admin on 3/5/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

//
//  JDTrump.swift
//  Trump Punch
//
//  Created by Jared Downing on 1/24/16.
//  Copyright © 2016 Ideals. All rights reserved.
//

import Foundation
import SpriteKit

class JDHomeButtons: SKSpriteNode {
    
    var type: Int = 0
    var dailyType: Int = 0
    var unlocked: Int = 0
    var value: String = ""
    var isGold: Int = 0
    var isToday: Int = 0
    
    var bodyName: String = ""
    var isAdded: Int = 0
    
    var hated: Int = 0
    var loved: Int = 0
    
    var nameOfTrump: String = ""
    
    var xOutTexture: SKTexture = SKTexture(imageNamed: "Wrong")
    
    var priceOf: Int = 0
    var leftTexture: String = ""
    var rightTexture: String = ""
    
    var theName: String = ""
    
    var popName: String = ""
    
    init(size: CGSize) {
        
        super.init(texture:SKTexture(imageNamed:"Settings_Icon.png"), color: UIColor.clear, size: size)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setDaily(_ w: Int) {
        dailyType = w
    }
    
    func getDaily() -> Int {
        return dailyType
    }
    
    
    func getStatus() -> Int {
        return unlocked
    }
    
    func setStatus(_ w: Int) {
        unlocked = w
    }
    
    
    func setPriceOfIt(_ w: Int) {
        priceOf = w
    }
    
    func getPriceOfIt() -> Int {
        return priceOf
    }
    
    func setTheTextures(_ lT: String, rT: String) {
        leftTexture = lT
        rightTexture = rT
    }
    
    func getLeftTexture() -> String{
        return leftTexture
    }
    
    func getRightTexture() -> String{
        return rightTexture
    }
    
    func setTheNameOf(_ w: String) {
        theName = w
    }
    
    func getTheNameOf() -> String {
        return theName
    }
    
    
    func getKeyVal() -> String {
        return value
    }
    
    func setKeyVal(_ w: String) {
        value = w
    }
    
    func setGold(_ w: Int) {
        isGold = w
        if w == 1 {
            
        }
        
        
    }
    
    func setIsTodayOf(_ w: Int) {
        isToday = w
    }
    
    func getIsTodayOf() -> Int {
        return isToday
    }
    
    func setPopNameOf(_ w: String) {
        popName = w
    }
    
    func getPopNameOf() -> String {
        return popName
    }
    func setHatedIt(_ w: Int) {
        hated = w
        
    }
    
    func getHated() -> Int{
        return hated
    }
    
    
    func setLovedIt(_ w: Int) {
        loved = w
    }
    
    func getLoved() -> Int{
        return loved
    }
}

//Swag don't come cheap

