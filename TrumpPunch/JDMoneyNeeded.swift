//
//  JDMoneyNeeded.swift
//  TrumpPunch
//
//  Created by Admin on 3/5/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

//
//  JDMoneyNeeded.swift
//  Trump Punch
//
//  Created by Jared Downing on 2/13/16.
//  Copyright © 2016 Play Pack Games. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class JDMoneyNeeded: SKLabelNode {
    
    var number = 0
    var choose = 0
    
    init(num: Int, chooser: Int) {
        super.init()
        
        fontColor = UIColor.white
        fontName = "Helvetica"
        fontSize = 15.0
        
        number = num
        choose = chooser
        
        text = "\(num)"
        text = "\(number)"
        if number > 999 && number < 1000000{
            text = "\(number / 1000) \(number % 1000)"
            
            if number % 1000 == 0 {
                text = "\(number / 1000) 000"
            }
            if number % 1000 < 100 {
                text = "\(number / 1000) 0\(number % 1000)"
            }
            
            if number % 1000 < 10 {
                text = "\(number / 1000) 00\(number % 1000)"
            }
        }
        else if number > 999999 && number < 1000000000 {
            text = "\(number / 1000000) \((number / 1000) % 1000) \(number % 1000)"
            
            
            
            
            //MIDDLE < 100
            if ((number / 1000) % 1000) < 100 {
                text = "\(number / 1000000) 0\((number / 1000) % 1000) \(number % 1000)"
                
                
            }
            
            if ((number / 1000) % 1000) < 100 && ((number % 1000) < 100){
                text = "\(number / 1000000) 0\((number / 1000) % 1000) 0\(number % 1000)"
            }
            
            if ((number / 1000) % 1000) < 100 && ((number % 1000) < 10){
                text = "\(number / 1000000) 0\((number / 1000) % 1000) 00\(number % 1000)"
            }
            
            //MIDDLE < 10
            if ((number / 1000) % 1000) < 10 {
                text = "\(number / 1000000) 00\((number / 1000) % 1000) \(number % 1000)"
                
                
            }
            if ((number / 1000) % 1000) < 10 && ((number % 1000) < 100) {
                text = "\(number / 1000000) 00\((number / 1000) % 1000) 0\(number % 1000)"
                
                
            }
            if ((number / 1000) % 1000) < 10 && ((number % 1000) < 10) {
                text = "\(number / 1000000) 00\((number / 1000) % 1000) 00\(number % 1000)"
                
                
            }
        }
        
    }
    
    func bonusAdd(_ weaponC: Int) {
        text = "\(number)"
        
        if weaponC == 0 {
            number += WeaponCoins.tomatoes
        }
        else if weaponC == 1 {
            number += WeaponCoins.fish
        }
        else if weaponC == 2 {
            number += WeaponCoins.swatters
        }
        else if weaponC == 3 {
            number += WeaponCoins.gloves
        }
        else if weaponC == 5 {
            number += WeaponCoins.nukes
        }
        
        if number > 999 && number < 1000000{
            text = "\(number / 1000) \(number % 1000)"
            
            if number % 1000 == 0 {
                text = "\(number / 1000) 000"
            }
            if number % 1000 < 100 {
                text = "\(number / 1000) 0\(number % 1000)"
            }
            
            if number % 1000 < 10 {
                text = "\(number / 1000) 00\(number % 1000)"
            }
        }
        else if number > 999999 && number < 1000000000 {
            text = "\(number / 1000000) \((number / 1000) % 1000) \(number % 1000)"
            
            
            
            
            
            //MIDDLE < 100
            if ((number / 1000) % 1000) < 100 {
                text = "\(number / 1000000) 0\((number / 1000) % 1000) \(number % 1000)"
                
                
            }
            
            if ((number / 1000) % 1000) < 100 && ((number % 1000) < 100){
                text = "\(number / 1000000) 0\((number / 1000) % 1000) 0\(number % 1000)"
            }
            
            if ((number / 1000) % 1000) < 100 && ((number % 1000) < 10){
                text = "\(number / 1000000) 0\((number / 1000) % 1000) 00\(number % 1000)"
            }
            
            //MIDDLE < 10
            if ((number / 1000) % 1000) < 10 {
                text = "\(number / 1000000) 00\((number / 1000) % 1000) \(number % 1000)"
                
                
            }
            if ((number / 1000) % 1000) < 10 && ((number % 1000) < 100) {
                text = "\(number / 1000000) 00\((number / 1000) % 1000) 0\(number % 1000)"
                
                
            }
            if ((number / 1000) % 1000) < 10 && ((number % 1000) < 10) {
                text = "\(number / 1000000) 00\((number / 1000) % 1000) 00\(number % 1000)"
                
                
            }
        }
        
        
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func increment(){
        if choose == 0 {
            number += 25
        }
        else if choose == 1 {
            number += 1
        }
    }
    
    func setTo(_ num:Int) {
        self.number = num
        
        text = "\(number)"
        if number > 999 && number < 1000000{
            text = "\(number / 1000) \(number % 1000)"
            
            if number % 1000 == 0 {
                text = "\(number / 1000) 000"
            }
            if number % 1000 < 100 {
                text = "\(number / 1000) 0\(number % 1000)"
            }
            
            if number % 1000 < 10 {
                text = "\(number / 1000) 00\(number % 1000)"
            }
        }
        else if number > 999999 && number < 1000000000 {
            text = "\(number / 1000000) \((number / 1000) % 1000) \(number % 1000)"
            
            
            
            
            //MIDDLE < 100
            if ((number / 1000) % 1000) < 100 {
                text = "\(number / 1000000) 0\((number / 1000) % 1000) \(number % 1000)"
                
                
            }
            
            if ((number / 1000) % 1000) < 100 && ((number % 1000) < 100){
                text = "\(number / 1000000) 0\((number / 1000) % 1000) 0\(number % 1000)"
            }
            
            if ((number / 1000) % 1000) < 100 && ((number % 1000) < 10){
                text = "\(number / 1000000) 0\((number / 1000) % 1000) 00\(number % 1000)"
            }
            
            //MIDDLE < 10
            if ((number / 1000) % 1000) < 10 {
                text = "\(number / 1000000) 00\((number / 1000) % 1000) \(number % 1000)"
                
                
            }
            if ((number / 1000) % 1000) < 10 && ((number % 1000) < 100) {
                text = "\(number / 1000000) 00\((number / 1000) % 1000) 0\(number % 1000)"
                
                
            }
            if ((number / 1000) % 1000) < 10 && ((number % 1000) < 10) {
                text = "\(number / 1000000) 00\((number / 1000) % 1000) 00\(number % 1000)"
                
                
            }
        }
    }
    
    func isOver() -> Bool{
        if self.number <= 0{
            return true
        }
        else {
            return false
        }
        
    }
    
    
}

