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

class TPEndScene: SKScene {
    
    
    override func didMove(to view: SKView) {
        
        setup()
    }
    
    func setup() {
        
        CurrentScene = InEndScene
        
        backgroundColor = UIColor.white
        
        BaseViewController.setupHomeSceneBottomView()
        BaseViewController.presentHomeSceneBottomView()
    }
}

//MARK: EndScene
extension TPBaseViewController {
    
    func setupEndSceneBottomView() {
        
        endSceneBottomView = Bundle.main.loadNibNamed("TPEndSceneBottomView", owner: self, options: [:])?[0] as! TPEndSceneBottomView
        
        endSceneBottomView.center = CGPoint(x: MidX,y: MidY + 75)
        
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
        endSceneBottomView.homeButton.addGestureRecognizer(shopButtonTapGesture)
        
        
    }
    
    func presentEndSceneBottomView() {
        
        view.addSubview(endSceneBottomView)
    }
    
    func removeEndSceneBottomView() {
        
        endSceneBottomView.removeFromSuperview()
    }
    
    func setupEndSceneTopView() {
        
        endSceneTopView = Bundle.main.loadNibNamed("TPEndSceneTopView", owner: self, options: [:])?[0] as! TPEndSceneTopView
        
        endSceneBottomView.center = CGPoint(x: MidX,y: MidY - 75)
        
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
                
                BaseViewController.playGame()
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
            }, completion: { finished in
                
                // TODO
            })
        }
        else if gesture.state == .began {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
                self.endSceneBottomView.homeButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
        }
        
    }
    
}
