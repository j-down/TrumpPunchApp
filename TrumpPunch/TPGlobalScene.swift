//
//  TPGlobalScene.swift
//  TrumpPunch
//
//  Created by Admin on 2/20/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit
import GameKit
import AVFoundation

class TPGlobalScene: SKScene {
    
    var soundPlayer: AVAudioPlayer?
    
    func playSound(named sound: String) {
        
        if Sound {
            
            let url = Bundle.main.url(forResource: sound, withExtension: "mp3")!
            
            do {
                soundPlayer = try AVAudioPlayer(contentsOf: url)
                guard let player = soundPlayer else { return }
                
                player.prepareToPlay()
                player.play()
            } catch let error {
                print(error.localizedDescription)
            }
            
        }
    }
    
    func presentHomeScene() {
        
        trackFirebase(for: "HomeScene")
        
        clearLastScene()
        
        ThisHomeScene = TPHomeScene(size: view!.bounds.size)
        ThisGlobalScene = ThisHomeScene
        ThisHomeScene.scaleMode = .aspectFill
        view!.presentScene(ThisHomeScene, transition: SKTransition.fade(withDuration: 0.5))
    }
    
    func presentEndScene() {
        
        trackFirebase(for: "EndScene")
        
        if TimeSinceAdPlayed == 1 {
            
            BaseViewController.loadIntertisial()
        }
        
        TimeSinceAdPlayed += 1
        
        if TimeSinceAdPlayed > 3 {
            
            TimeSinceAdPlayed = 0
        }
        
        clearLastScene()
        
        ThisEndScene = TPEndScene(size: view!.bounds.size)
        ThisGlobalScene = ThisEndScene
        ThisEndScene.scaleMode = .aspectFill
        view!.presentScene(ThisEndScene, transition: SKTransition.fade(withDuration: 0.5))
    }
    
    func presentGameScene() {
        
        trackFirebase(for: "PlayGame")
        
        clearLastScene()
        
        ThisGameScene = TPGameScene(size: view!.bounds.size)
        ThisGlobalScene = ThisGameScene
        ThisGameScene.scaleMode = .aspectFill
        view!.presentScene(ThisGameScene, transition: SKTransition.fade(withDuration: 0.5))
    }
    
    func clearLastScene() {
        
        removeAllActions()
        removeAllChildren()
        
        if CurrentScene == SceneType.homeScene {
            
            BaseViewController.removeHomeScene()
        }
        else if CurrentScene == SceneType.endScene {
            
            BaseViewController.removeEndScene()
        }
        else if CurrentScene == SceneType.gameScene {
            //Remove Game
        }
        
        if CurrentPage == InShop {
            
            BaseViewController.removeShop()
        }
        
    }
}

//MARK: GameCenterDelegate
extension TPGlobalScene: GKGameCenterControllerDelegate {
    
    func authenticateGameCenter() {
        
        let localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(ViewController, error) -> Void in
            
            if (ViewController != nil) {
                if let rootViewController = self.view!.window?.rootViewController {
                    rootViewController.present(ViewController!, animated: true, completion: nil)
                }
            } else {
                localPlayer.loadDefaultLeaderboardIdentifier { (categoryID, error) -> Void in
                    if (error != nil) {
                        
                        print(error ?? "error loading")
                        
                    } else if localPlayer.isAuthenticated {
                        
                        if let category = categoryID {
                            
                            LeaderboardID = category
                        }
                        
                    } else {
                        print("could not be authenticated")
                    }
                }
            }
        }
    }
    
    
    func showGameCenterLeaderboard() {
        
        trackFirebase(for: "GameCenter")
        
        let gameCenterViewController = GKGameCenterViewController()
        gameCenterViewController.gameCenterDelegate = self
        gameCenterViewController.viewState = GKGameCenterViewControllerState.leaderboards
        gameCenterViewController.leaderboardIdentifier = LeaderboardID
        
        BaseViewController.present(gameCenterViewController, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
