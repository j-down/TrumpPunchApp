//
//  TPPlayer.swift
//  TrumpPunch
//
//  Created by Admin on 2/20/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation
import SpriteKit
import Foundation

class TPGamePerson: SKSpriteNode {
    
    var person = TPPerson()
    var body: SKSpriteNode = SKSpriteNode()
    
    var leftTexture = SKTexture()
    var rightTexture = SKTexture()
    var mainTexture = SKTexture()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init () {
        super.init(texture: SKTexture(imageNamed: "Donald Trump"), color: UIColor.clear, size: CGSize(width: 0, height: 0))
        
        position = CGPoint(x: MidX, y: MidY - 30)
    }
    
    
    func setup(for person: TPPerson) {
        
        self.person = person
        
        mainTexture = SKTexture(image: UIImage(named: person.name)!)
        leftTexture = SKTexture(image: UIImage(named: person.name + " Left")!)
        rightTexture = SKTexture(image: UIImage(named: person.name + " Right")!)
        
        texture = mainTexture
        
        setupBody()
        present()
    }
    
    func setupBody() {
        
        if let bodyImage = UIImage(named: "\(person.body)") {
            
            body.texture = SKTexture(image: bodyImage)
        }
        else {
            body.alpha = 0
        }
        
        body.position = CGPoint(x: 0, y: -150)
        body.size = CGSize(width: BaseViewController.view.frame.width + 80, height: 350)
        body.zPosition = -1
    }
    
    func present() {
        
        
        run(grow(), completion: {
            
            self.run(self.shake())
            
            self.addChild(self.body)
        
        })
        
    }
    
    func getHitFromLeft() {
        
        let shrink = SKAction.resize(toWidth: 400, height: 200, duration: 0.05)
        let grow = SKAction.resize(toWidth: 300, height: 300, duration: 0.05)
        
        let go = SKAction.sequence([shrink,grow])
        
        texture = rightTexture
        
        run(go, completion: {
            
            self.texture = self.mainTexture
            
        })
        
    }
    
    func getHitFromRight() {
        
        let shrink = SKAction.resize(toWidth: 400, height: 200, duration: 0.05)
        let grow = SKAction.resize(toWidth: 300, height: 300, duration: 0.05)
        
        let go = SKAction.sequence([shrink,grow])
        
        texture = leftTexture
        
        run(go, completion: {
            
            self.texture = self.mainTexture
            
        })
    }
    
    func shake() -> SKAction {
        
        let shrink = SKAction.rotate(byAngle: 0.1, duration: 0.2)
        let grow = SKAction.rotate(byAngle: -0.1, duration: 0.2)
        
        let blink = SKAction.sequence([grow, shrink])
        return SKAction.repeatForever(blink)
    }
    
    func grow() -> SKAction {
        
        let fadeOut = SKAction.resize(toWidth: 320, height: 320, duration: 0.2)
        let fadeIn = SKAction.resize(toWidth: 300, height: 300, duration: 0.1)
        let blink = SKAction.sequence([fadeOut,fadeIn])
        return SKAction.repeat(blink, count: 1)
    }
    
    
    func update(_ dt:TimeInterval) {
        
    }
}
