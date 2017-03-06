//
//  JDMedals.swift
//  TrumpPunch
//
//  Created by Admin on 3/5/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation
import SpriteKit

class JDMedals: SKSpriteNode {
    
    
    
    
    init(sizeOf: CGSize) {
        
        super.init(texture:SKTexture(imageNamed:"Clear.png"), color: UIColor.clear, size: CGSize(width: 80,height: 80))
        
        
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
