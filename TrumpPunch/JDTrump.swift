//
//  JDTrump.swift
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

class JDTrump: SKSpriteNode {
    
    
    var weapon: Int = 0
    var w: Int = 0
    var body: SKSpriteNode!
    //var armL: SKSpriteNode!
    //var armR: SKSpriteNode!
    //var legL: SKSpriteNode!
    // var legR: SKSpriteNode!
    
    init(we: Int) {
        
        super.init(texture:SKTexture(imageNamed:"Trump.png"), color: UIColor.clear, size: CGSize(width: 300, height: 300))
        w = we
        
        // loadPhysicsBody(CGSizeMake(300,300))
        //loadBody()
        
        
    }
    
    func loadBody() {
        
        body = SKSpriteNode(imageNamed: "")
        body.position = CGPoint(x: 0, y: 0)
        body.size = CGSize(width: 260, height: 400)
        body.zPosition = -1
        
        addChild(body)
    }
    
    
    func loadPhysicsBody(_ size: CGSize){
        loadWeapon()
        
        
    }
    
    
    
    func loadWeapon(){
        let defaults = UserDefaults.standard
        
        weapon = defaults.integer(forKey: "weapon")
    }
    
    func hitLeft() {
        
        let shrink = SKAction.resize(toWidth: 400, height: 200, duration: 0.05)
        let grow = SKAction.resize(toWidth: 300, height: 300, duration: 0.05)
        
        let go = SKAction.sequence([shrink,grow])
        
        run(go, completion: {
            
            if self.w == 0 {
                self.texture = SKTexture(imageNamed: "Trump.png")
            }
            else if self.w == 1 {
                self.texture = SKTexture(imageNamed: "Ted")
            }
            else if self.w == 2 {
                self.texture = SKTexture(imageNamed: "John")
            }
            else if self.w == 3 {
                self.texture = SKTexture(imageNamed: "Marco")
            }
            else if self.w == 4 {
                self.texture = SKTexture(imageNamed: "Ben")
            }
            else if self.w == 5 {
                self.texture = SKTexture(imageNamed: "Jeb")
            }
            else if self.w == 6 {
                self.texture = SKTexture(imageNamed: "Hillary")
            }
            else if self.w == 7 {
                self.texture = SKTexture(imageNamed: "Bernie")
            }
            else if self.w == 8 {
                self.texture = SKTexture(imageNamed: "Justin")
            }
            else if self.w == 9 {
                self.texture = SKTexture(imageNamed: "Kanye")
            }
            else if self.w == 10 {
                self.texture = SKTexture(imageNamed: "Kim")
            }
            
            
        })
        
    }
    
    func hitRight() {
        
        if w == 0 {
            texture = SKTexture(imageNamed: "Trump_Right.png")
        }
        else if w == 1 {
            texture = SKTexture(imageNamed: "Ted_Right")
        }
        else if w == 2 {
            texture = SKTexture(imageNamed: "John_Right")
        }
        else if w == 3 {
            texture = SKTexture(imageNamed: "Marco_Right")
        }
        else if w == 4 {
            texture = SKTexture(imageNamed: "Ben_Right")
        }
        else if w == 5 {
            texture = SKTexture(imageNamed: "Jeb_Right")
        }
        else if w == 6 {
            texture = SKTexture(imageNamed: "Hillary_Right")
        }
        else if w == 7 {
            texture = SKTexture(imageNamed: "Bernie_Right")
        }
        else if w == 8 {
            texture = SKTexture(imageNamed: "Justin_Right")
        }
        else if w == 9 {
            texture = SKTexture(imageNamed: "Kanye_Right")
        }
        else if w == 10 {
            texture = SKTexture(imageNamed: "Kim_Right")
        }
        
        
        let shrink = SKAction.resize(toWidth: 400, height: 200, duration: 0.05)
        let grow = SKAction.resize(toWidth: 300, height: 300, duration: 0.05)
        let go = SKAction.sequence([shrink,grow])
        
        run(go, completion: {
            
            if self.w == 0 {
                self.texture = SKTexture(imageNamed: "Trump.png")
            }
            else if self.w == 1 {
                self.texture = SKTexture(imageNamed: "Ted")
            }
            else if self.w == 2 {
                self.texture = SKTexture(imageNamed: "John")
            }
            else if self.w == 3 {
                self.texture = SKTexture(imageNamed: "Marco")
            }
            else if self.w == 4 {
                self.texture = SKTexture(imageNamed: "Ben")
            }
            else if self.w == 5 {
                self.texture = SKTexture(imageNamed: "Jeb")
            }
            else if self.w == 6 {
                self.texture = SKTexture(imageNamed: "Hillary")
            }
            else if self.w == 7 {
                self.texture = SKTexture(imageNamed: "Bernie")
            }
            else if self.w == 8 {
                self.texture = SKTexture(imageNamed: "Justin")
            }
            else if self.w == 9 {
                self.texture = SKTexture(imageNamed: "Kanye")
            }
            else if self.w == 10 {
                self.texture = SKTexture(imageNamed: "Kim")
            }
            else if self.w == 11 {
                self.texture = SKTexture(imageNamed: "Jimmy")
            }
            
            
        })
        
        
    }
    
    
    func fallLeft(_ w: Int) {
        loadWeapon()
        if w == 0 {
            texture = SKTexture(imageNamed: "Trump_Left.png")
            size = CGSize(width: 400, height: 300)
        }
        
        name = "trumpFellLeft"
        
        let choose = CGFloat(arc4random_uniform(100))
        let chooseT = CGFloat(arc4random_uniform(30))
        
        physicsBody?.affectedByGravity = true
        physicsBody?.isDynamic = true
        physicsBody?.pinned = false
        if weapon == 0 {
            
            physicsBody?.applyImpulse(CGVector(dx: -30,dy: 15 - chooseT))
            
        }
        else if weapon == 1 || weapon == 2{
            physicsBody?.applyImpulse(CGVector(dx: -30,dy: 50 - choose))
        }
        
        
        //Real Fall
        let shrink = SKAction.resize(toWidth: 100, height: 100, duration: 0.3)
        
        let rotateBack = SKAction.rotate(byAngle: 2.1, duration:0.1)
        
        let swirl = SKAction.repeat(rotateBack, count: 5)
        
        //Fish Fall
        let shrinkF = SKAction.resize(toWidth: 100, height: 100, duration: 0.6)
        
        let rotateBackF = SKAction.rotate(byAngle: 1, duration:0.2)
        
        let swirlF = SKAction.repeat(rotateBackF, count: 5)
        
        //Tomato Fall
        let shrinkT = SKAction.resize(toWidth: 200, height: 200, duration: 0.6)
        
        let rotateBackT = SKAction.rotate(byAngle: 0.5, duration:0.2)
        
        let swirlT = SKAction.repeat(rotateBackT, count: 5)
        
        if weapon == 2 {
            
            run(swirl)
            run(shrink, completion: {self.removeFromParent(); print("gone left")})
            
        }
        else if weapon == 0 {
            run(shrinkT)
            run(swirlT, completion: {self.removeFromParent(); print("gone left")})
            
            
        }else if weapon == 1{
            run(swirlF)
            run(shrinkF, completion: {self.removeFromParent(); print("gone left")})
            
        }
    }
    func fallRight(_ w: Int) {
        loadWeapon()
        
        if w == 0 {
            texture = SKTexture(imageNamed: "Trump_Right.png")
            size = CGSize(width: 400, height: 300)
        }
        
        let choose = CGFloat(arc4random_uniform(100))
        let chooseT = CGFloat(arc4random_uniform(30))
        
        name = "trumpFell"
        
        if weapon == 0 {
            
            physicsBody?.applyImpulse(CGVector(dx: -30,dy: 15 - chooseT))
            
        }
        else if weapon == 1 || weapon == 2{
            physicsBody?.applyImpulse(CGVector(dx: -30,dy: 50 - choose))
        }
        
        physicsBody?.affectedByGravity = true
        physicsBody?.isDynamic = true
        physicsBody?.pinned = false
        
        physicsBody?.applyImpulse(CGVector(dx: 30,dy: 50 - choose))
        //Real Fall
        let shrink = SKAction.resize(toWidth: 100, height: 100, duration: 0.3)
        
        let rotateBack = SKAction.rotate(byAngle: -2.1, duration:0.1)
        
        let swirl = SKAction.repeat(rotateBack, count: 5)
        
        
        //Fish Fall
        let shrinkF = SKAction.resize(toWidth: 100, height: 100, duration: 0.6)
        
        let rotateBackF = SKAction.rotate(byAngle: -1, duration:0.2)
        
        let swirlF = SKAction.repeat(rotateBackF, count: 5)
        
        //Tomato Fall
        let shrinkT = SKAction.resize(toWidth: 100, height: 100, duration: 0.6)
        
        let rotateBackT = SKAction.rotate(byAngle: -0.5, duration:0.2)
        
        let swirlT = SKAction.repeat(rotateBackT, count: 5)
        
        if weapon == 2 {
            
            run(swirl)
            run(shrink, completion: {self.removeFromParent(); print("gone right")})
            
        }
        else if weapon == 0 {
            run(shrinkT)
            run(swirlT, completion: {self.removeFromParent(); print("gone right")})
            
            
        }else if weapon == 1{
            run(swirlF)
            run(shrinkF, completion: {self.removeFromParent(); print("gone right")})
            
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
