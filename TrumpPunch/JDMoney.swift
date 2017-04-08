//
//  JDMoney.swift
//  TrumpPunch
//
//  Created by Admin on 3/5/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

//
//  JDMoney.swift
//  Trump Punch
//
//  Created by Jared Downing on 2/13/16.
//  Copyright © 2016 Play Pack Games. All rights reserved.
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

class JDMoney: SKSpriteNode {
    
    
    var weapon: Int = 0
    
    init(w: Int) {
        
        super.init(texture:SKTexture(imageNamed:"Coin.png"), color: UIColor.clear, size: CGSize(width: 25, height: 25))
    }
    
    
    func loadWeapon(){
        let defaults = UserDefaults.standard
        
        weapon = defaults.integer(forKey: "weapon")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
