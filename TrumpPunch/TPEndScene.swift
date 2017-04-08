//
//  TPEndScene.swift
//  TrumpPunch
//
//  Created by Admin on 2/20/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import Firebase

class TPEndScene: TPGlobalScene {
    
    
    var gamePerson: TPGamePerson!
    var gameItem: TPGameItem!
    
    override func didMove(to view: SKView) {
        
        setup()
    }
    
    func setup() {
        
        CurrentScene = SceneType.endScene
        
        backgroundColor = UIColor.white
        
        BaseViewController.setupEndScene()
        BaseViewController.presentEndScene()
        
        setupGamePerson()
    }
    
    func setupGamePerson() {
        
        gamePerson = TPGamePerson()
        gamePerson.setup(for: Person)
        gamePerson.position = CGPoint(x: MidX, y: MidY)
        gamePerson.body.alpha = 0
        addChild(gamePerson)
    }
    
    func setupGameItem() {
        
        gameItem = TPGameItem()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            
            if touch == touches.first {
                
                if location.x < MidX {
                    
                    runLeftSideTouched()
                }
                else {
                    
                    runRightSideTouched()
                }
                
            }
        }
    }
    
    func runLeftSideTouched() {
        
        if CurrentPage != InShop {
            
            playSound(named: Sounds.gloves)
            gamePerson.getHitFromLeft()
        }
    }
    
    func runRightSideTouched() {
        
        if CurrentPage != InShop {
            
            playSound(named: Sounds.gloves)
            gamePerson.getHitFromRight()
        }
    }
}

//MARK: EndScene
extension TPBaseViewController {
    
    func setupEndScene() {
        
       // makeMusic(playing: true)
        setupEndSceneTopView()
        setupEndSceneMiddleView()
        setupEndSceneBottomView()
        setupEndSceneShareView()
        setupEndSceneData()
    }
    
    func setupEndSceneData() {
        
        endSceneTopView.quoteLabel.text = Person.quote()
        endSceneMiddleView.scoreLabel.text = "\(Score)"
        endSceneMiddleView.bestLabel.text = "\(Defaults.integer(forKey: DefaultType.highScore))"
        
        if let user = FIRAuth.auth()?.currentUser {
            if user.incrementedTrumpPunches > 0 {
                user.saveTrumpPunches()
            }
        }
    }
    
    func removeEndScene() {
        
        removeEndSceneTopView()
        removeEndSceneMiddleView()
        removeEndSceneBottomView()
        removeEndSceneShareView()
    }
    
    func setupEndSceneBottomView() {
        
        endSceneBottomView = Bundle.main.loadNibNamed("TPEndSceneBottomView", owner: self, options: [:])?[0] as! TPEndSceneBottomView
        
        endSceneBottomView.backgroundColor = UIColor.clear
        endSceneBottomView.center = CGPoint(x: MidX,y: MidY + 165)
        
        shopCoinBack.center = CGPoint(x: MidX,y: endSceneBottomView.frame.midY - shopTopView.frame.height + 35 )
        
        let playButtonTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(playButtonPressedEndScene(gesture:)))
        playButtonTapGesture.minimumPressDuration = 0
        
        endSceneBottomView.playButton.isUserInteractionEnabled = true
        endSceneBottomView.playButton.addGestureRecognizer(playButtonTapGesture)
        
        let shopButtonTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(shopButtonPressedEndScene(gesture:)))
        shopButtonTapGesture.minimumPressDuration = 0
        
        endSceneBottomView.shopButton.isUserInteractionEnabled = true
        endSceneBottomView.shopButton.addGestureRecognizer(shopButtonTapGesture)
        
        let homeButtonTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(homeButtonPressedEndScene(gesture:)))
        homeButtonTapGesture.minimumPressDuration = 0
        
        endSceneBottomView.homeButton.isUserInteractionEnabled = true
        endSceneBottomView.homeButton.addGestureRecognizer(homeButtonTapGesture)
        
    }
    
    func setupEndSceneMiddleView() {
        
        endSceneMiddleView = Bundle.main.loadNibNamed("TPEndSceneMiddleView", owner: self, options: [:])?[0] as! TPEndSceneMiddleView
        
        endSceneMiddleView.backgroundColor = UIColor.clear
        
        endSceneMiddleView.center = CGPoint(x: MidX,y: MidY)
    }
    
    func setupEndSceneShareView() {
        
        let shareTapGesture = UITapGestureRecognizer(target: self, action: #selector(shareScore))
        
        shareImageView = UIImageView(image: UIImage(named: "ShareIcon"))
        shareImageView.frame = CGRect(x: MidX, y: MidY, width: 50, height: 50)
        shareImageView.center = CGPoint(x: MidX + shopCoinBack.frame.width / 2 + 20, y: shopCoinBack.frame.midY)
        shareImageView.isUserInteractionEnabled = true
        shareImageView.addGestureRecognizer(shareTapGesture)
    }
    
    func removeEndSceneShareView() {
        
        shareImageView.removeFromSuperview()
    }
    
    func presentEndSceneShareview() {
        
        view.addSubview(shareImageView)
    }
    
    func presentEndScene() {
        
        presentEndSceneTopView()
        presentEndSceneMiddleView()
        presentEndSceneBottomView()
        presentEndSceneShareview()
    }
    
    func presentEndSceneMiddleView() {
        
        view.addSubview(endSceneMiddleView)
    }
    
    func removeEndSceneMiddleView() {
        
        endSceneMiddleView.removeFromSuperview()
    }
    
    func presentEndSceneBottomView() {
        
        view.addSubview(endSceneBottomView)
    }
    
    func removeEndSceneBottomView() {
        
        endSceneBottomView.removeFromSuperview()
    }
    
    func setupEndSceneTopView() {
        
        endSceneTopView = Bundle.main.loadNibNamed("TPEndSceneTopView", owner: self, options: [:])?[0] as! TPEndSceneTopView
        
        endSceneTopView.backgroundColor = UIColor.clear
        endSceneTopView.center = CGPoint(x: MidX,y: MidY - 200)
    }
    
    func presentEndSceneTopView() {
        
        view.addSubview(endSceneTopView)
    }
    
    func removeEndSceneTopView() {
        
        endSceneTopView.removeFromSuperview()
    }
    
    func playButtonPressedEndScene(gesture: UITapGestureRecognizer) {
        
        if gesture.state == .ended {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
                self.endSceneBottomView.playButton.transform = CGAffineTransform.identity
            }, completion: { finished in
                
                ThisGlobalScene.playSound(named: Sounds.button)
                ThisGlobalScene.presentGameScene()
            })
        }
        else if gesture.state == .began {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
                self.endSceneBottomView.playButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
        }
        
    }
    
    func shopButtonPressedEndScene(gesture: UITapGestureRecognizer) {
        
        if gesture.state == .ended {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
                self.endSceneBottomView.shopButton.transform = CGAffineTransform.identity
            }, completion: { finished in
                
                ThisGlobalScene.playSound(named: Sounds.button)
                BaseViewController.openShop()
            })
        }
        else if gesture.state == .began {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
                self.endSceneBottomView.shopButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
        }
    }
    
    func homeButtonPressedEndScene(gesture: UITapGestureRecognizer) {
        
        if gesture.state == .ended {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
                self.endSceneBottomView.homeButton.transform = CGAffineTransform.identity
                self.logoutButtonView.alpha = 1
                
            }, completion: { finished in
                
                self.logoutButton.isUserInteractionEnabled = true
                BaseViewController.shopCoinBack.isHidden = true
                ThisGlobalScene.playSound(named: Sounds.button)
                ThisGlobalScene.presentHomeScene()
            })
        }
        else if gesture.state == .began {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
                self.endSceneBottomView.homeButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
        }
        
    }
    
}
