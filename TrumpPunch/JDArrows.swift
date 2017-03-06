//
//  JDArrows.swift
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

class JDArrows: SKSpriteNode {
    
    init(sizeOf: CGSize) {
        
        super.init(texture:SKTexture(imageNamed:"LeftArrow.png"), color: UIColor.clear, size: sizeOf)
        
    }
    
    func leftNukeBye() {
        
        self.removeAllActions()
        self.removeFromParent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
