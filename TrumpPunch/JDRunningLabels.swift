//
//  JDPointsLabel.swift
//  Lit
//
//  Created by Jared Downing on 1/23/16.
//  Copyright © 2016 Advergo. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

/**
 */
class JDRunningLabels: SKLabelNode {
    
    var number = 0
    var lnumber = 0
    
    init(num: Int) {
        super.init()
        
        fontColor = UIColor.white
        fontName = "Helvetica-Bold"
        fontSize = 20.0
        
        number = num
        
        text = "\(number)"
        if num > 999 && num < 1000000{
            text = "\(num / 1000) \(num % 1000)"
            if number % 1000 == 0 {
                text = "\(num / 1000) 000"
            }
            if number % 1000 < 100 {
                text = "\(number / 1000) 0\(number % 1000)"
            }
            
            if number % 1000 < 10 {
                text = "\(number / 1000) 00\(number % 1000)"
            }
            
            
        }
        else if num > 999999 && num < 1000000000 {
            text = "\(num / 1000000) \((number / 1000) % 1000) \(num % 1000)"
            
            
            
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
    
    func increment(_ weaponC: Int){
        
        
        
        
        number += 25
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
    
    func addStreak() {
        number += 1
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
    
    func add(_ weaponC: Int) {
        
        
        if weaponC == 0 {
            number += WeaponCoins.tomatoes
        }
        else if weaponC == 1 {
            number += WeaponCoins.fish
        }
        else if weaponC == 2 {
            number += WeaponCoins.gloves
        }
        else if weaponC == 3 {
            number += WeaponCoins.swatters
        }
        else if weaponC == 5 {
            number += WeaponCoins.nukes
        }
        
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
    
    
    func sub() {
        number -= 1
        text = "\(number)"
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
