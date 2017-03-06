//
//  TPGameItem.swift
//  TrumpPunch
//
//  Created by Admin on 3/5/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation
import SpriteKit

class TPGameItem: SKSpriteNode {
    
    var right: Bool = false
    var item: TPItem!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init () {
        super.init(texture: SKTexture(imageNamed: "Tomato_Right"), color: UIColor.clear, size: CGSize(width: 0, height: 0))
        
        position = CGPoint(x: MidX + 500, y: MidY)
    }
    
    func setup(for item: TPItem, rightSide: Bool) {
        
        self.item = item
        right = rightSide
        
        if rightSide {
            
            texture = SKTexture(imageNamed: "\(item.name)_Right")
        }
        else {
            
            texture = SKTexture(imageNamed: "\(item.name)_Left")
        }
        
        if item.name == WeaponType.tomatoes {
            
            size = CGSize(width: 50, height: 50)
        }
        else if item.name == WeaponType.fish {
            
            size = CGSize(width: 50, height: 50)
        }
    }
    
    func hit(rightSide: Bool) {
        
        if item.name == WeaponType.tomatoes {
            
            if right {
                
                run(leftTomato())
            }
            else {
                
                run(rightTomato())
            }
        }
        else if item.name == WeaponType.fish {
            
            if right {
                
                run(leftFish())
            }
            else {
                
                run(rightFish())
            }
        }
        else if item.name == WeaponType.swatters {
            
            if right {
                
                run(leftFish())
            }
            else {
                
                run(rightFish())
            }
        }
        else if item.name == WeaponType.gloves {
            
            if right {
                
                run(leftPunch())
            }
            else {
                
                run(rightPunch())
            }
        }
        else if item.name == WeaponType.nukes {
            
            if right {
                
                run(leftNuke())
            }
            else {
                
                run(rightNuke())
            }
        }
    }
    
}

//MARK: Animations
extension TPGameItem {
    
    func rightPunch() -> SKAction {
        
        let set = SKAction.moveTo(x: MidX + 50, duration: 0.1)
        let set2 = SKAction.moveTo(x: MidX + BaseViewController.view.frame.width, duration: 0.1)
        
        let through = SKAction.sequence([set,set2])
        
        return SKAction.repeat(through, count: 1)
    }
    
    func leftPunch() -> SKAction {
        
        let set = SKAction.moveTo(x: MidX - 50, duration: 0.1)
        let set2 = SKAction.moveTo(x: MidX - BaseViewController.view.frame.width, duration: 0.1)
        
        let through = SKAction.sequence([set,set2])
        
        return SKAction.repeat(through, count: 1)
    }
    
    func rightNuke() -> SKAction {
        
        let set = SKAction.move(to: CGPoint(x: MidX + 50, y: MidY), duration: 0.2)
        
        return SKAction.repeat(set, count: 1)
    }
    
    func nukeShrink() -> SKAction {
        
        let through = SKAction.resize(toWidth: 60, height: 60, duration: 0.2)
        
        return SKAction.repeat(through, count: 1)
    }
    
    func leftNuke() -> SKAction {
        let set = SKAction.move(to: CGPoint(x: MidX - 50, y: MidY), duration: 0.2)
        
        
        return SKAction.repeat(set, count: 1)
    }
    
    func rightTomato() -> SKAction {
        
        let set = SKAction.move(to: CGPoint(x: MidX + 50, y: MidY), duration: 0.1)
        let set11 = SKAction.setTexture(SKTexture(imageNamed: "Tomato_Right"))
        let set2 = SKAction.fadeAlpha(to: 0, duration: 0.1)
        
        let through = SKAction.sequence([set,set11,set2])
        
        return SKAction.repeat(through, count: 1)
    }
    
    func leftTomato() -> SKAction {
        
        let set = SKAction.move(to: CGPoint(x: MidX - 50, y: MidY),  duration: 0.1)
        let set11 = SKAction.setTexture(SKTexture(imageNamed: "Tomato_Left"))
        let set2 = SKAction.fadeAlpha(to: 0, duration: 0.1)
        
        let through = SKAction.sequence([set,set11,set2])
        
        return SKAction.repeat(through, count: 1)
    }
    
    func rightFish() -> SKAction {
        
        let set = SKAction.rotate(byAngle: CGFloat(M_PI / 4), duration: 0.1)
        let set2 = SKAction.rotate(byAngle: -CGFloat(M_PI / 4), duration: 0.1)
        
        let through = SKAction.sequence([set,set2])
        
        return SKAction.repeat(through, count: 1)
    }
    
    func leftFish() -> SKAction {
        let set = SKAction.rotate(byAngle: -CGFloat(M_PI / 4), duration: 0.1)
        let set2 = SKAction.rotate(byAngle: CGFloat(M_PI / 4), duration: 0.1)
        
        
        let through = SKAction.sequence([set,set2])
        
        return SKAction.repeat(through, count: 1)
    }
    
    func rightFly() -> SKAction {
        let set = SKAction.rotate(byAngle: CGFloat(M_PI / 4), duration: 0.1)
        let set2 = SKAction.rotate(byAngle: -CGFloat(M_PI / 4), duration: 0.1)
        
        
        let through = SKAction.sequence([set,set2])
        
        return SKAction.repeat(through, count: 1)
    }
    
    func leftFly() -> SKAction {
        let set = SKAction.rotate(byAngle: -CGFloat(M_PI / 4), duration: 0.1)
        let set2 = SKAction.rotate(byAngle: CGFloat(M_PI / 4), duration: 0.1)
        
        
        let through = SKAction.sequence([set,set2])
        
        return SKAction.repeat(through, count: 1)
    }
}
