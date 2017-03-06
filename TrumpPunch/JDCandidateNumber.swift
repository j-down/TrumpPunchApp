//
//  JDCandidateNumber.swift
//  TrumpPunch
//
//  Created by Admin on 3/5/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

//
//  JDCandidateNumber.swift
//  Trump Punch
//
//  Created by Jared Downing on 1/30/16.
//  Copyright © 2016 Ideals. All rights reserved.
//
import Foundation
import UIKit
import SpriteKit

class JDCandidateNumber: SKLabelNode {
    
    var number = 1
    
    init(num: Int) {
        super.init()
        
        fontColor = UIColor.white
        fontName = "Helvetica"
        fontSize = 25.0
        
        number = num
        text = "\(num)"
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func increment(){
        number += 1
        text = "\(number)"
        
        
    }
    
    func subtract(){
        number -= 1
        text = "\(number)"
        
        
    }
    
    func setTo(_ num:Int) {
        self.number = num
        text = "\(self.number)"
        
        
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

