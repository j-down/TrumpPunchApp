//
//  TPHomeScene.swift
//  TrumpPunch
//
//  Created by Admin on 2/20/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class TPHomeScene: SKScene {
    
    
    override func didMove(to view: SKView) {
        
       setup()
    }
    
    func setup() {
        
        CurrentScene = InHomeScene
        
        backgroundColor = UIColor.white
        
        BaseViewController.setupHomeSceneBottomView()
        BaseViewController.presentHomeSceneBottomView()
    }
}

//MARK: HomeScene
extension TPBaseViewController {
    
    func setupHomeSceneBottomView() {
        
        homeSceneBottomView = Bundle.main.loadNibNamed("TPHomeSceneBottomView", owner: self, options: [:])?[0] as! TPHomeSceneBottomView
        
        homeSceneBottomView.frame = CGRect(x: MidX, y: MidY, width: 286, height: 300)
        homeSceneBottomView.center = CGPoint(x: MidX,y: MidY + 75)
        
        homeSceneLogoView = UIImageView(image: UIImage(named: "HomeSceneLogo"))
        homeSceneLogoView.frame = CGRect(x: MidX, y: MidY, width: 150, height: 130)
        homeSceneLogoView.center = CGPoint(x: MidX,y: MidY - 125)
        
        let playButtonTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(playButtonPressed(gesture:)))
        playButtonTapGesture.minimumPressDuration = 0
        
        homeSceneBottomView.playButton.isUserInteractionEnabled = true
        homeSceneBottomView.playButton.addGestureRecognizer(playButtonTapGesture)
        
        let trophyButtonTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(trophyButtonPressed(gesture:)))
        trophyButtonTapGesture.minimumPressDuration = 0
        
        homeSceneBottomView.trophyButton.isUserInteractionEnabled = true
        homeSceneBottomView.trophyButton.addGestureRecognizer(trophyButtonTapGesture)
        
        let shopButtonTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(shopButtonPressed(gesture:)))
        shopButtonTapGesture.minimumPressDuration = 0
        
        homeSceneBottomView.shopButton.isUserInteractionEnabled = true
        homeSceneBottomView.shopButton.addGestureRecognizer(shopButtonTapGesture)
        
        let locationButtonTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(locationButtonPressed(gesture:)))
        locationButtonTapGesture.minimumPressDuration = 0
        
        homeSceneBottomView.locationButton.isUserInteractionEnabled = true
        homeSceneBottomView.locationButton.addGestureRecognizer(locationButtonTapGesture)
        
        let soundButtonTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(soundButtonPressed(gesture:)))
        soundButtonTapGesture.minimumPressDuration = 0
        
        homeSceneBottomView.soundButton.isUserInteractionEnabled = true
        homeSceneBottomView.soundButton.addGestureRecognizer(soundButtonTapGesture)
        
        homeSceneBottomView.soundOffView.isUserInteractionEnabled = false
        
        let musicButtonTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(musicButtonPressed(gesture:)))
        musicButtonTapGesture.minimumPressDuration = 0
        
        homeSceneBottomView.musicButton.isUserInteractionEnabled = true
        homeSceneBottomView.musicButton.addGestureRecognizer(musicButtonTapGesture)
        
        homeSceneBottomView.musicOffView.isUserInteractionEnabled = false
    }
    
    func presentHomeSceneBottomView() {
        
        view.addSubview(homeSceneBottomView)
        view.addSubview(homeSceneLogoView)
    }
    
    func removeHomeSceneButtonView() {
        
        homeSceneBottomView.removeFromSuperview()
    }
    
    func playButtonPressed(gesture: UITapGestureRecognizer) {
        
        if gesture.state == .ended {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
                self.homeSceneBottomView.playButton.transform = CGAffineTransform.identity
            }, completion: { finished in
                
                //Do work
            })
        }
        else if gesture.state == .began {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
                self.homeSceneBottomView.playButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
        }
    }
    
    func trophyButtonPressed(gesture: UITapGestureRecognizer) {
        
        if gesture.state == .ended {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
                self.homeSceneBottomView.trophyButton.transform = CGAffineTransform.identity
            }, completion: { finished in
                
                //Do work
            })
        }
        else if gesture.state == .began {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
                self.homeSceneBottomView.trophyButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
        }
    }
    
    func shopButtonPressed(gesture: UITapGestureRecognizer) {
        
        if gesture.state == .ended {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
                self.homeSceneBottomView.shopButton.transform = CGAffineTransform.identity
            }, completion: { finished in
                
                BaseViewController.openShop()
            })
        }
        else if gesture.state == .began {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
                self.homeSceneBottomView.shopButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
        }
    }
    
    func locationButtonPressed(gesture: UITapGestureRecognizer) {
        
        if gesture.state == .ended {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
                self.homeSceneBottomView.locationButton.transform = CGAffineTransform.identity
            }, completion: { finished in
                
                BaseViewController.openLocation()
            })
        }
        else if gesture.state == .began {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
                self.homeSceneBottomView.locationButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
        }
    }
    
    func musicButtonPressed(gesture: UITapGestureRecognizer) {
        
        if gesture.state == .ended {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
                self.homeSceneBottomView.musicButton.transform = CGAffineTransform.identity
                self.homeSceneBottomView.musicOffView.transform = CGAffineTransform.identity
            }, completion: { finished in
                
                BaseViewController.toggleMusic()
            })
        }
        else if gesture.state == .began {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
                self.homeSceneBottomView.musicButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                self.homeSceneBottomView.musicOffView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
        }
    }
    
    func soundButtonPressed(gesture: UITapGestureRecognizer) {
        
        if gesture.state == .ended {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
                self.homeSceneBottomView.soundButton.transform = CGAffineTransform.identity
                self.homeSceneBottomView.soundOffView.transform = CGAffineTransform.identity
            }, completion: { finished in
                
                BaseViewController.toggleSound()
            })
        }
        else if gesture.state == .began {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
                self.homeSceneBottomView.soundButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                self.homeSceneBottomView.soundOffView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
        }
    }
    
    
}
