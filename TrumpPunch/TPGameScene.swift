//
//  GameScene.swift
//  Trump Punch
//
//  Created by Jared Downing on 1/23/16.
//  Copyright (c) 2016 Ideals. All rights reserved.
//

import SpriteKit
import AVFoundation
import GameKit

class TPGameScene: TPGlobalScene {
    
    //SCENES
    var time: JDTimeNumber!
    var home: JDHomeButtons!
    var moneyB: JDHomeButtons!
    var label: JDRunningLabels!
    var medal: JDMedals!
    var trump: JDTrump!
    var homeQuote: JDHomeButtons!
    var bill: JDMoney!
    var money: JDRunningLabels!
    var bonusNumber: JDRunningLabels!
    var extraMode: Bool = false
    var nextGo: JDHomeButtons!
    var timeGo: Bool = true
    var inContinueMode: Bool = false
    var useNumber: Int = 10
    var shine: JDHomeButtons!
    var bonusStart: Bool = false
    var streak: JDRunningLabels!
    var streak1: JDRunningLabels!
    var streakT: SKLabelNode!
    var speedClock1: Int = 0
    var homeStart: JDHomeButtons?
    var didTutorial: Int = 0
    var trumpLeftTexture: SKTexture!
    var trumpRightTexture: SKTexture!
    var trumpTexture: SKTexture!
    var backView: JDHomeButtons?
    var tutorialMode: Bool = false
    var didStartTut: Int = 0
    var tutorialPos: Int = 0
    var labelTut: SKMultilineLabel?
    var backView3: JDHomeButtons!
    var inItem: Bool = false
    var type: Int = -1
    
    var node1Rem: String = ""
    var node2Rem: String = ""
    var node3Rem: String = ""
    var node4Rem: String = ""
    var node5Rem: String = ""
    var node6Rem: String = ""
    var node7Rem: String = ""
    
    var chooseBill1:CGFloat = 0
    var chooseBill2:CGFloat = 0
    
    var savedH: Int = 0
    
    var canPressAddStore: Bool = true
    
    //Bars
    var barT: JDHomeButtons!
    var barB: JDHomeButtons!
    var itemView: JDHomeButtons!
    var xOut: JDHomeButtons!
    
    var canAd: Int = 0
    
    var chanceB: Int = 0
    
    var chanceBRem: String = ""
    
    var bonusBack: JDHomeButtons!
    
    var inItemSpec: Bool = false
    
    var doneWidth: Bool = false
    
    var throughFirst: Bool = false
    var chooseNum: Int = 0
    var playTut: Int = 2
    var stillGoing: Bool = true
    var arrowTut: JDHomeButtons!
    
    var backOf: JDHomeButtons!
    var backOf2: JDHomeButtons!
    
    var trumpBody: JDHomeButtons!
    var amountCharged: Int = 5
    
    var goldBonus = Int(arc4random_uniform(20))
    var goldBonusMode = false
    
    var inTut: Bool = false
    
    var popQuote: JDHomeButtons!
    var lives: JDRunningLabels!
    var heart: JDHomeButtons!
    var livesT: SKLabelNode!
    var timeT: SKLabelNode!
    
    var hpCount1: Int = 300
    var heartOn: Int = 3
    var tap: JDHomeButtons!
    
    var amountAdd: JDHomeButtons!
    
    var candidateNumber: JDCandidateNumber!
    
    var chanceN: Int = 0
    var chanceN2: Int = 0
    var chanceN3: Int = 0
    var chanceN4: Int = 0
    var chanceN5: Int = 0
    var chanceN6: Int = 0
    var chanceN7: Int = 0
    
    var canPressMoney: Bool = false
    
    var chanceA: Int = 0
    
    var roundT: JDHomeButtons!
    var moneyNeededT: JDHomeButtons!
    var moneyNeeded: JDMoneyNeeded!
    var inNextMode: Bool = false
    var timeStarted: Bool = false
    var startShaking: Bool = false
    var inRound: Bool = false
    var tType: Int = 0
    
    var chance: Int = 0
    var chance2: Int = 0
    
    //Retry stuff
    var backView2: JDHomeButtons!
    var specItemView: JDHomeButtons!
    
    var didDo: Int = 0
    var roundTH: JDHomeButtons?
    var roundH: JDMoneyNeeded?
    var streakTH: JDHomeButtons?
    var streakTB: JDHomeButtons?
    var streak1H: JDRunningLabels?
    
    var wrongBackground: SKTexture!
    var rightBackground: SKTexture!
    
    var node1: JDHomeButtons!
    var node2: JDHomeButtons!
    var node3: JDHomeButtons!
    var node4: JDHomeButtons!
    var node5: JDHomeButtons!
    var node6: JDHomeButtons!
    var node7: JDHomeButtons!
    
    var bonusGo: Int = 0
    var rotateAB: Int = 0
    var rotateAB1: Int = 0
    var roundTB: JDHomeButtons?
    
    var inWrong: Bool = false
    
    var backItem2: JDHomeButtons!
    var buyItem: JDHomeButtons!
    
    //For Pause
    var homeGo: JDHomeButtons!
    var soundB: JDHomeButtons!
    
    //VARIABLES
    var trumpCount: Int = 0
    var choose = Int(arc4random_uniform(2))
    var isStarted = false
    var isOnChoose = true
    var button = 0
    var tapUp = false
    var started = 0
    var pointText = ""
    var bombSoundEffect: AVAudioPlayer!
    
    var toMinus: Int = 4
    var hpDial: JDHomeButtons!
    var doAgain: Int = 1
    
    var boomGoL: Int = 0
    var boomGoR: Int = 0
    
    var hitChoice: Int = 0
    
    var hpTime: TimeInterval = 1
    
    
    var leftBoom = JDArrows(sizeOf: CGSize(width: 450, height: 100))
    var rightBoom = JDArrows(sizeOf: CGSize(width: 450, height: 100))
    let leftBoomB = JDArrows(sizeOf: CGSize(width: 150, height: 140))
    let rightBoomB = JDArrows(sizeOf: CGSize(width: 150, height: 140))
    
    //Start of
    var leftStart: JDHomeButtons?
    var rightStart: JDHomeButtons?
    
    //Game trackers
    var highPresent: Int = 0
    var scorePresent: Int = 0
    
    //End game stuff
    var share: JDHomeButtons?
    var leader: JDHomeButtons?
    var playAgain: JDHomeButtons?
    
    
    //top Bar Stuff
    var goBack:JDHomeButtons?
    
    var endGame: Bool = false
    
    var chooseGold: Int = 0
    
    var wN: Int = 0
    
    var chooseType1 = Int(arc4random_uniform(2))
    var chooseType2 = Int(arc4random_uniform(2))
    var chooseType3 = Int(arc4random_uniform(2))
    var chooseType4 = Int(arc4random_uniform(2))
    var chooseType5 = Int(arc4random_uniform(2))
    var chooseType6 = Int(arc4random_uniform(2))
    var chooseType7 = Int(arc4random_uniform(2))
    
    var enableButtons: Bool = false
    
    var inStoreOf: Bool = false
    
    //NEW
    var gamePerson: TPGamePerson!
    var coinsToAdd: Int = 0
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        
        if sender.state == .ended {
            
            tapUp = true
            
            leftBoomB.isHidden = true
            rightBoomB.isHidden = true
            
            let goHome = barB.childNode(withName: "goHome") as! JDHomeButtons
            
            if button == 11 {
                
                button = -2
                endGame = true
                self.stillGoing = false
                self.inRound = false
                
                goHome.run(popBackUp(), completion: {
                    
                    self.stillGoing = false
                    self.inRound = false
                    self.nextRound()
                })
            }
            
            if button == 2020 {
                
                specItemView.run(nodeShrink(), completion: {
                    
                    self.inRound = true
                    self.stillGoing = true
                    goHome.isHidden = false
                    
                    self.specItemView.removeFromParent()
                    self.backView2.removeFromParent()
                    
                    
                    let gameOverT = self.childNode(withName: "GameOT") as! JDHomeButtons
                    gameOverT.run(self.popGO(), completion: {
                        
                        gameOverT.removeFromParent()
                    })
                    
                    self.startTimer()
                    
                })
                
            }
            
            if button == 101 {
                
                button = -2
                
                specItemView.run(SKAction.fadeAlpha(to: 0, duration: 0.3), completion: {
                    
                    let gameOverT = self.childNode(withName: "GameOT") as! JDHomeButtons
                    gameOverT.run(self.popGO(), completion: {
                        gameOverT.removeFromParent()
                        self.runSceneGo()
                    })
                })
            }
            if button == 31 {
                
                button = -2
                
                if tutorialPos == 0 {
                    
                    homeStart?.run(popHBUp(), completion: {
                        
                        self.tutorialPos = 1
                        self.addTut(1)
                        
                    })
                }
                else if tutorialPos == 1 {
                    homeStart?.run(popHBUp(), completion: {
                        self.tutorialPos = 2
                        self.addTut(2)
                        
                    })
                }
                else if tutorialPos == 2 {
                    homeStart?.run(popHBUp(), completion: {
                        
                        let defaults = UserDefaults.standard
                        defaults.set(1, forKey: "didTutorial")
                        
                        self.runSceneGo()
                    })
                }
            }
        }
    }
    
    override func didMove(to view: SKView) {
        
        backgroundColor = UIColor.gray
        
       // BaseViewController.makeMusic(playing: false)
        
        didTutorial = 1
        
        canPlay = true
        
        roundNumber = 1
        streakScore = 0
        
        self.view!.isMultipleTouchEnabled = true;
        
        if gameStart == false{
            
            let backGround1 = JDHomeButtons(size: CGSize(width: view.frame.width + 50, height: view.frame.height + 50))
            backGround1.texture = SKTexture(imageNamed: "Icon_Background1")
            backGround1.position = CGPoint(x: view.center.x, y: view.center.y )
            backGround1.name = "BackGround1"
            addChild(backGround1)
            backGround1.zPosition = -49
            
            backGround1.run(fadeIt())
        }
        
        wrongBackground = SKTexture(imageNamed: "WrongBackground")
        
        gameStart = true
        
        let backC = Int(arc4random_uniform(2))
        let backGround = JDHomeButtons(size: CGSize(width: view.frame.width + 50, height: view.frame.height + 50))
        
        backGround.position = CGPoint(x: view.center.x, y: view.center.y )
        backGround.name = "BackGround"
        addChild(backGround)
        
        if backC == 0 {
            backGround.texture = SKTexture(imageNamed: "Icon_Background1")
            rightBackground = SKTexture(imageNamed: "Icon_Background1")
        }
        else if backC == 1 {
            backGround.texture = SKTexture(imageNamed: "Icon_Background2")
            rightBackground = SKTexture(imageNamed: "Icon_Background2")
        }
        
        backGround.zPosition = -50
        
        //BEST STUFF
        //BestText
        roundT = JDHomeButtons(size: CGSize(width: 50, height: 15))
        roundT.position.x = view.center.x + view.frame.width / 2.7
        roundT.position.y = view.center.y + (view.frame.height / 2.3)
        roundT.texture = SKTexture(imageNamed: "BestNewwer.png")
        addChild(roundT)
        roundT.alpha = 0
        
        //Best Medal
        roundTB = JDHomeButtons(size: CGSize(width: 60, height: 60))
        roundTB!.position = CGPoint(x: 0,y: -40)
        roundTB!.zPosition = -10
        roundTB!.texture = SKTexture(imageNamed: "Bronze_Medal.png")
        roundT.addChild(roundTB!)
        
        //Best Number
        self.streak = JDRunningLabels(num: 0)
        self.streak.position = CGPoint(x: 0, y: -45)
        self.streak.zPosition = 20
        self.streak.fontColor = UIColor.white
        self.roundT.addChild(self.streak)
        streak.setTo(Defaults.integer(forKey: DefaultType.highScore))
        
        addTopBottom()
        addMoney(0)
        
        //SCORE STUFF
        //Streak Text
        streakT = SKLabelNode(text: "Score")
        streakT.position.x = -123
        streakT.position.y = -30
        streakT.zPosition = 20
        streakT.fontSize = 20.0
        streakT.fontColor = UIColor.white
        streakT.fontName = "Helvetica-Bold"
        barT.addChild(streakT)
        
        //Streak Medal
        streakTB = JDHomeButtons(size: CGSize(width: 60, height: 60))
        streakTB!.position = CGPoint(x: 0,y: -45)
        streakTB!.zPosition = -10
        streakTB!.texture = SKTexture(imageNamed: "Bronze_Medal.png")
        streakTB!.alpha = 0
        streakT.addChild(streakTB!)
        
        //Streak Number
        streak1 = JDRunningLabels(num: streakScore)
        streak1.name = "Streak"
        streak1.position = CGPoint(x: 0, y: -45)
        streak1.fontSize = 25.0
        streak1.fontColor = UIColor.white
        streakT.addChild(streak1)
        
        self.inRound = true
        self.addBonus()
        
        addRunningLabels(3)
        
        //LIVES STUFF
        //Lives
        livesT = SKLabelNode(text: "Lives")
        livesT.position.x = 123
        livesT.position.y = -30
        livesT.zPosition = 20
        livesT.fontSize = 20.0
        livesT.fontColor = UIColor.white
        livesT.fontName = "Helvetica-Bold"
        barT.addChild(livesT)
        
        //Best Medal
        heart = JDHomeButtons(size: CGSize(width: 60, height: 55))
        heart!.position = CGPoint(x: 0,y: -35)
        heart!.zPosition = -10
        heart!.texture = SKTexture(imageNamed: "Heart")
        livesT.addChild(heart!)
        
        lives = JDRunningLabels(num: lifeCount)
        self.lives.position = CGPoint(x: 0, y: -45)
        self.lives.zPosition = 20
        self.lives.fontSize = 25.0
        self.lives.fontColor = UIColor.white
        self.livesT.addChild(self.lives)
        
        trumpEx = false
        trumpExLeft = false
        
        //GOAL STUFF
        moneyNeededT = JDHomeButtons(size: CGSize(width: 70, height: 30))
        moneyNeededT.position.x = view.center.x
        moneyNeededT.position.y = view.center.y - 100
        moneyNeededT.texture = SKTexture(imageNamed: "CoinsT.png")
        moneyNeededT.isHidden = true
        addChild(moneyNeededT)
        
        nextGo = JDHomeButtons(size: CGSize(width: 200, height: 75))
        nextGo.position.x = view.center.x
        nextGo.position.y = view.center.y - 200
        nextGo.texture = SKTexture(imageNamed: "NextRound")
        nextGo.name = "NextGo"
        addChild(nextGo)
        
        
        let nextGoT = SKLabelNode(text: "Next Round")
        nextGoT.position = CGPoint(x: 0,y: -10)
        nextGoT.fontSize = 30.0
        nextGoT.fontColor = UIColor.white
        nextGoT.fontName = "Helvetica"
        nextGoT.name = "NextGoT"
        nextGo.addChild(nextGoT)
        
        nextGo.isHidden = true
        
        
        leftBoom.position.y = view.center.y
        leftBoom.position.x = view.center.x - view.frame.width
        rightBoom.position.x = view.center.x + view.frame.width
        rightBoom.position.y = view.center.y
        
        leftBoomB.position.y = view.center.y
        leftBoomB.position.x = view.center.x
        rightBoomB.position.x = view.center.x
        rightBoomB.position.y = view.center.y
        
        //Start Tap Indicators
        leftStart = JDHomeButtons(size: CGSize(width: 100,height: 50))
        leftStart!.position = CGPoint(x: view.center.x + 70,y: view.center.y - 100)
        leftStart!.texture = SKTexture(imageNamed: "TapRight")
        leftStart!.zPosition = 99
        addChild(leftStart!)
        
        
        let leftStartT = JDHomeButtons(size: CGSize(width: 40,height: 40))
        leftStartT.position = CGPoint(x: 0,y: 75)
        leftStartT.texture = SKTexture(imageNamed: "Bonus_Right")
        leftStart!.addChild(leftStartT)
        
        let leftStartTi = JDHomeButtons(size: CGSize(width: 100,height: 30))
        leftStartTi.position = CGPoint(x: 40,y: 75)
        leftStartTi.texture = SKTexture(imageNamed: "Text_ERight")
        leftStartTi.alpha = 0
        leftStart!.addChild(leftStartTi)
        
        //Start Tap Indicators
        rightStart = JDHomeButtons(size: CGSize(width: 100,height: 50))
        rightStart!.position = CGPoint(x: view.center.x - 70,y: view.center.y - 100)
        rightStart!.texture = SKTexture(imageNamed: "TapLeft")
        rightStart!.zPosition = 99
        addChild(rightStart!)
        
        let rightStartTi = JDHomeButtons(size: CGSize(width: 40,height: 40))
        rightStartTi.position = CGPoint(x: 0, y: 75)
        rightStartTi.texture = SKTexture(imageNamed: "Bonus_Left")
        rightStart!.addChild(rightStartTi)
        
        let rightStartT = JDHomeButtons(size: CGSize(width: 80,height: 30))
        rightStartT.position = CGPoint(x: 20, y: 75)
        rightStartT.texture = SKTexture(imageNamed: "Text_ELeft")
        rightStart!.addChild(rightStartT)
        rightStartT.alpha = 0
        
        leftStart!.run(popStartLeft())
        rightStart!.run(popStartRight())
        
        
        leftBoom.zPosition = 15
        
        rightBoom.zPosition = 15
        
        leftBoomB.zPosition = 10
        
        rightBoomB.zPosition = 10
        
        leftBoom.name = "leftBoomArrow"
        rightBoom.name = "rightBoomArrow"
        
        leftBoom.texture = SKTexture(imageNamed:"\(Item.name)_Left")
        rightBoom.texture = SKTexture(imageNamed:"\(Item.name)_Right")
        leftBoomB.texture = SKTexture(imageNamed:"\(Item.name)_Hit")
        rightBoomB.texture = SKTexture(imageNamed:"\(Item.name)_Hit")
        
        addChild(leftBoom)
        addChild(rightBoom)
        addChild(leftBoomB)
        addChild(rightBoomB)
        
        let left = JDHomeButtons(size:CGSize(width: view.frame.width / 1.8, height: view.frame.height))
        left.texture = SKTexture(imageNamed: "Clear")
        left.position.x = view.center.x - 100
        left.position.y = view.center.y
        left.zPosition = 100
        left.name = "LeftScreen"
        addChild(left)
        
        let right = JDHomeButtons(size:CGSize(width: view.frame.width / 1.8, height: view.frame.height ))
        right.texture = SKTexture(imageNamed: "Clear")
        right.position.x = view.center.x + 100
        right.position.y = view.center.y
        right.zPosition = 100
        right.name = "RightScreen"
        addChild(right)
        
        leftBoomB.isHidden = true
        rightBoomB.isHidden = true
        
        //WEAPON STATES
        let gloveState = JDCandidateNumber(num: 0)
        gloveState.name = "gloveState"
        addChild(gloveState)
        gloveState.fontColor = UIColor.white
        gloveState.isHidden = true
        
        let fishState = JDCandidateNumber(num: 0)
        fishState.name = "fishState"
        addChild(fishState)
        fishState.fontColor = UIColor.white
        fishState.isHidden = true
        
        let tomatoState = JDCandidateNumber(num: 0)
        tomatoState.name = "tomatoState"
        addChild(tomatoState)
        tomatoState.fontColor = UIColor.white
        tomatoState.isHidden = true
        
        //LOAD WHICH CANDDIATE AND NUMBER
        let weaponNumber = JDCandidateNumber(num: 0)
        weaponNumber.name = "weaponNumber"
        weaponNumber.fontColor = UIColor.white
        addChild(weaponNumber)
        weaponNumber.isHidden = true
        
        candidateNumber = JDCandidateNumber(num: 0)
        candidateNumber!.name = "candidateNumber"
        candidateNumber!.fontColor = UIColor.white
        addChild(candidateNumber!)
        candidateNumber!.isHidden = true
        
        setupGamePerson()
        setupGameItem()
        
        if wN == 0{
            
            leftBoom.position.x = view.center.x - view.frame.width / 2
            rightBoom.position.x = view.center.x + view.frame.width / 2
            
            leftBoom.size = CGSize(width: 60,height: 60)
            rightBoom.size = CGSize(width: 60,height: 60)
            
        }
        else if wN == 1{
            
            leftBoom.texture = SKTexture(imageNamed:"Fish_BarLeft")
            rightBoom.texture = SKTexture(imageNamed:"Fish_BarRight")
            
            leftBoom.size = CGSize(width: 120, height: view.frame.height + 200)
            leftBoom.position.x = view.center.x - view.frame.width / 2
            leftBoom.position.y = view.center.y - view.frame.height / 2
            rightBoom.size = CGSize(width: 120, height: view.frame.height + 200)
            rightBoom.position.x = view.center.x + view.frame.width / 2
            rightBoom.position.y = view.center.y - view.frame.height / 2
            
        }
        else if wN == 2{
            
            leftBoom.texture = SKTexture(imageNamed:"Swatters_BarLeft")
            rightBoom.texture = SKTexture(imageNamed:"Swatters_BarRight")
            
            leftBoom.size = CGSize(width: 120, height: view.frame.height + 160)
            leftBoom.position.x = view.center.x - view.frame.width / 2
            leftBoom.position.y = view.center.y - view.frame.height / 2
            rightBoom.size = CGSize(width: 120, height: view.frame.height + 160)
            rightBoom.position.x = view.center.x + view.frame.width / 2
            rightBoom.position.y = view.center.y - view.frame.height / 2
        }
            
        else if wN == 3{
            
            leftBoom.texture = SKTexture(imageNamed:"Gloves_BarLeft")
            rightBoom.texture = SKTexture(imageNamed:"Gloves_BarRight")
            
            leftBoom.size = CGSize(width: 450,height: 100)
            rightBoom.size = CGSize(width: 450,height: 100)
            
            leftBoom.position = CGPoint(x: view.center.x - view.frame.width, y: view.center.y)
            rightBoom.position = CGPoint(x: view.center.x + view.frame.width, y: view.center.y)
            
        }
        else if wN == 4{
            
            leftBoom.position.y = view.center.y + 100
            rightBoom.position.y = view.center.y + 100
            
            leftBoom.position.x = view.center.x - view.frame.width / 2
            rightBoom.position.x = view.center.x + view.frame.width / 2
            
            leftBoom.size = CGSize(width: 50,height: 50)
            rightBoom.size = CGSize(width: 50,height: 50)
        }
        
        playSound(named: Sounds.start)
        
        addtrumpPunchLabel()
        
        let handleTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TPGameScene.handleTap(_:)))
        view.addGestureRecognizer(handleTap)
    }
    
    func addBonus(){
        
        goldBonus = 500
        
        if playTut > -3 {
            playTut -= 1
        }
        
        if bonusStart == false{
            bonusStart = true
            
            bonusBack = JDHomeButtons(size: CGSize(width: 130, height: 45))
            bonusBack.position.x = view!.center.x
            bonusBack.position.y = view!.center.y + 140
            bonusBack.texture = SKTexture(imageNamed: "GameRoundBack")
            bonusBack.name = "BonusBack"
            addChild(bonusBack)
            
            let bonusText = JDHomeButtons(size: CGSize(width: 60, height: 20))
            bonusText.position = CGPoint(x: 0, y: 30)
            bonusText.texture = SKTexture(imageNamed: "Combo.png")
            bonusText.name = "BonusText"
            bonusBack.addChild(bonusText)
            bonusText.run(shakeMedal())
            bonusText.zPosition = 700
            bonusText.isHidden = true
            
            let bonusText2 = JDHomeButtons(size: CGSize(width: 60, height: 20))
            bonusText2.position = CGPoint(x: 120, y: 0)
            bonusText2.texture = SKTexture(imageNamed: "Combo.png")
            bonusText2.name = "BonusText2"
            bonusBack.addChild(bonusText2)
            bonusText2.isHidden = true
            bonusText2.run(shakeCandidate())
            bonusText2.isHidden = true
        }
        
        chooseType1 = Int(arc4random_uniform(2))
        chooseType2 = Int(arc4random_uniform(2))
        chooseType3 = Int(arc4random_uniform(2))
        chooseType4 = Int(arc4random_uniform(2))
        
        chooseType5 = Int(arc4random_uniform(2))
        chooseType6 = Int(arc4random_uniform(2))
        
        if streak1.number >= 20 {
            bonusBack.size = CGSize(width: 170,height: 45)
            chooseNum = 1
        }
        
        if streak1.number >= 30 {
            bonusBack.size = CGSize(width: 210,height: 45)
            chooseNum = 2
        }
        
        if streak1.number >= 50 {
            bonusBack.size = CGSize(width: 250,height: 45)
            chooseNum = 3
        }
        
        if streak1.number >= 100 {
            bonusBack.size = CGSize(width: 290,height: 45)
            chooseNum = 4
        }
        
        if chooseNum == 0 {
            chooseGold = Int(arc4random_uniform(UInt32(coGold)))
            
            node1Rem = "node1Rem" + String(chanceN)
            chanceN = (chanceN + 1) % 100
            
            node1 = JDHomeButtons(size: CGSize(width: 40,height: 40))
            node1.position = CGPoint(x: -40,y: 0)
            node1.name = node1Rem
            node1.zPosition = 700
            
            if chooseType1 == 0 {
                
                node1.texture = SKTexture(imageNamed: "Bonus_Left.png")
                node1.type = 0
            }
                
            else if chooseType1 == 1{
                node1.texture = SKTexture(imageNamed: "Bonus_Right.png")
                
                node1.type = 1
            }
            
            node1.setGold(chooseGold)
            bonusBack.addChild(node1)
            
            
            node2Rem = "node2Rem" + String(chanceN2)
            chanceN2 = (chanceN2 + 1) % 100
            
            node2 = JDHomeButtons(size: CGSize(width: 40,height: 40))
            node2.position = CGPoint(x: 0,y: 0)
            node2.name = node2Rem
            node2.zPosition = 700
            if chooseType2 == 0 {
                node2.texture = SKTexture(imageNamed: "Bonus_Left.png")
                
                node2.type = 0
            }
            else if chooseType2 == 1{
                node2.texture = SKTexture(imageNamed: "Bonus_Right.png")
                
                node2.type = 1
            }
            
            node2.setGold(chooseGold)
            bonusBack.addChild(node2)
            
            node3Rem = "node3Rem" + String(chanceN3)
            chanceN3 = (chanceN3 + 1) % 100
            node3 = JDHomeButtons(size: CGSize(width: 40,height: 40))
            node3.position = CGPoint(x: 40,y: 0)
            node3.name = node3Rem
            node3.zPosition = 700
            if chooseType3 == 0 {
                node3.texture = SKTexture(imageNamed: "Bonus_Left.png")
                
                node3.type = 0
            }
            else if chooseType3 == 1{
                node3.texture = SKTexture(imageNamed: "Bonus_Right.png")
                
                node3.type = 1
            }
            node3.setGold(chooseGold)
            bonusBack.addChild(node3)
            
        }
        else if chooseNum == 1 {
            
            chooseGold = Int(arc4random_uniform(UInt32(coGold)))
            
            node1Rem = "node1Rem" + String(chanceN)
            chanceN = (chanceN + 1) % 100
            
            node1 = JDHomeButtons(size: CGSize(width: 40,height: 40))
            node1.position = CGPoint(x: -60,y: 0)
            node1.name = node1Rem
            node1.zPosition = 700
            if chooseType1 == 0 {
                
                node1.texture = SKTexture(imageNamed: "Bonus_Left.png")
                node1.type = 0
            }
                
            else if chooseType1 == 1{
                node1.texture = SKTexture(imageNamed: "Bonus_Right.png")
                
                node1.type = 1
            }
            
            node1.setGold(chooseGold)
            bonusBack.addChild(node1)
            
            node2Rem = "node2Rem" + String(chanceN2)
            chanceN2 = (chanceN2 + 1) % 100
            
            node2 = JDHomeButtons(size: CGSize(width: 40,height: 40))
            node2.position = CGPoint(x: -20,y: 0)
            node2.name = node2Rem
            node2.zPosition = 700
            if chooseType2 == 0 {
                node2.texture = SKTexture(imageNamed: "Bonus_Left.png")
                
                node2.type = 0
            }
            else if chooseType2 == 1{
                node2.texture = SKTexture(imageNamed: "Bonus_Right.png")
                
                node2.type = 1
            }
            
            node2.setGold(chooseGold)
            bonusBack.addChild(node2)
            
            node3Rem = "node3Rem" + String(chanceN3)
            chanceN3 = (chanceN3 + 1) % 100
            node3 = JDHomeButtons(size: CGSize(width: 40,height: 40))
            node3.position = CGPoint(x: 20,y: 0)
            node3.name = node3Rem
            node3.zPosition = 700
            if chooseType3 == 0 {
                node3.texture = SKTexture(imageNamed: "Bonus_Left.png")
                
                node3.type = 0
            }
            else if chooseType3 == 1{
                node3.texture = SKTexture(imageNamed: "Bonus_Right.png")
                
                node3.type = 1
            }
            
            node3.setGold(chooseGold)
            bonusBack.addChild(node3)
            
            node4Rem = "node4Rem" + String(chanceN4)
            chanceN4 = (chanceN4 + 1) % 100
            node4 = JDHomeButtons(size: CGSize(width: 40,height: 40))
            node4.position = CGPoint(x: 60,y: 0)
            node4.name = node4Rem
            node4.zPosition = 700
            if chooseType4 == 0 {
                node4.texture = SKTexture(imageNamed: "Bonus_Left.png")
                
                node4.type = 0
            }
            else if chooseType4 == 1{
                node4.texture = SKTexture(imageNamed: "Bonus_Right.png")
                
                node4.type = 1
            }
            
            node4.setGold(chooseGold)
            bonusBack.addChild(node4)
        }
        else if chooseNum == 2 {
            chooseGold = Int(arc4random_uniform(UInt32(coGold)))
            
            node1Rem = "node1Rem" + String(chanceN)
            chanceN = (chanceN + 1) % 100
            
            node1 = JDHomeButtons(size: CGSize(width: 40,height: 40))
            node1.position = CGPoint(x: -80,y: 0)
            node1.name = node1Rem
            node1.zPosition = 700
            if chooseType1 == 0 {
                
                node1.texture = SKTexture(imageNamed: "Bonus_Left.png")
                node1.type = 0
            }
                
            else if chooseType1 == 1{
                node1.texture = SKTexture(imageNamed: "Bonus_Right.png")
                
                node1.type = 1
            }
            
            node1.setGold(chooseGold)
            bonusBack.addChild(node1)
            
            
            node2Rem = "node2Rem" + String(chanceN2)
            chanceN2 = (chanceN2 + 1) % 100
            
            node2 = JDHomeButtons(size: CGSize(width: 40,height: 40))
            node2.position = CGPoint(x: -40,y: 0)
            node2.name = node2Rem
            node2.zPosition = 700
            if chooseType2 == 0 {
                node2.texture = SKTexture(imageNamed: "Bonus_Left.png")
                
                node2.type = 0
            }
            else if chooseType2 == 1{
                node2.texture = SKTexture(imageNamed: "Bonus_Right.png")
                
                node2.type = 1
            }
            
            node2.setGold(chooseGold)
            bonusBack.addChild(node2)
            
            node3Rem = "node3Rem" + String(chanceN3)
            chanceN3 = (chanceN3 + 1) % 100
            
            node3 = JDHomeButtons(size: CGSize(width: 40,height: 40))
            node3.position = CGPoint(x: 0,y: 0)
            node3.name = node3Rem
            node3.zPosition = 700
            if chooseType3 == 0 {
                node3.texture = SKTexture(imageNamed: "Bonus_Left.png")
                
                node3.type = 0
            }
            else if chooseType3 == 1{
                node3.texture = SKTexture(imageNamed: "Bonus_Right.png")
                
                node3.type = 1
            }
            
            node3.setGold(chooseGold)
            bonusBack.addChild(node3)
            
            node4Rem = "node4Rem" + String(chanceN4)
            chanceN4 = (chanceN4 + 1) % 100
            
            node4 = JDHomeButtons(size: CGSize(width: 40,height: 40))
            node4.position = CGPoint(x: 40,y: 0)
            node4.name = node4Rem
            node4.zPosition = 700
            if chooseType4 == 0 {
                node4.texture = SKTexture(imageNamed: "Bonus_Left.png")
                
                node4.type = 0
            }
            else if chooseType4 == 1{
                node4.texture = SKTexture(imageNamed: "Bonus_Right.png")
                
                node4.type = 1
            }
            
            node4.setGold(chooseGold)
            bonusBack.addChild(node4)
            
            
            node5Rem = "node5Rem" + String(chanceN5)
            chanceN5 = (chanceN5 + 1) % 100
            node5 = JDHomeButtons(size: CGSize(width: 40,height: 40))
            node5.position = CGPoint(x: 80,y: 0)
            node5.name = node5Rem
            node5.zPosition = 700
            if chooseType5 == 0 {
                node5.texture = SKTexture(imageNamed: "Bonus_Left.png")
                
                node5.type = 0
            }
            else if chooseType5 == 1{
                node5.texture = SKTexture(imageNamed: "Bonus_Right.png")
                
                node5.type = 1
            }
            
            node5.setGold(chooseGold)
            bonusBack.addChild(node5)
        }
        else if chooseNum == 3 {
            chooseGold = Int(arc4random_uniform(UInt32(coGold)))
            
            node1Rem = "node1Rem" + String(chanceN)
            chanceN = (chanceN + 1) % 100
            
            node1 = JDHomeButtons(size: CGSize(width: 40,height: 40))
            node1.position = CGPoint(x: -100,y: 0)
            node1.name = node1Rem
            node1.zPosition = 700
            if chooseType1 == 0 {
                
                node1.texture = SKTexture(imageNamed: "Bonus_Left.png")
                node1.type = 0
            }
                
            else if chooseType1 == 1{
                node1.texture = SKTexture(imageNamed: "Bonus_Right.png")
                
                node1.type = 1
            }
            
            node1.setGold(chooseGold)
            bonusBack.addChild(node1)
            
            node2Rem = "node2Rem" + String(chanceN2)
            chanceN2 = (chanceN2 + 1) % 100
            node2 = JDHomeButtons(size: CGSize(width: 40,height: 40))
            node2.position = CGPoint(x: -60,y: 0)
            node2.name = node2Rem
            node2.zPosition = 700
            if chooseType2 == 0 {
                node2.texture = SKTexture(imageNamed: "Bonus_Left.png")
                
                node2.type = 0
            }
            else if chooseType2 == 1{
                node2.texture = SKTexture(imageNamed: "Bonus_Right.png")
                
                node2.type = 1
            }
            
            node2.setGold(chooseGold)
            bonusBack.addChild(node2)
            
            node3Rem = "node3Rem" + String(chanceN3)
            chanceN3 = (chanceN3 + 1) % 100
            node3 = JDHomeButtons(size: CGSize(width: 40,height: 40))
            node3.position = CGPoint(x: -20,y: 0)
            node3.name = node3Rem
            node3.zPosition = 700
            if chooseType3 == 0 {
                node3.texture = SKTexture(imageNamed: "Bonus_Left.png")
                
                node3.type = 0
            }
            else if chooseType3 == 1{
                node3.texture = SKTexture(imageNamed: "Bonus_Right.png")
                
                node3.type = 1
            }
            
            node3.setGold(chooseGold)
            bonusBack.addChild(node3)
            
            node4Rem = "node4Rem" + String(chanceN4)
            chanceN4 = (chanceN4 + 1) % 100
            node4 = JDHomeButtons(size: CGSize(width: 40,height: 40))
            node4.position = CGPoint(x: 20,y: 0)
            node4.name = node4Rem
            node4.zPosition = 700
            if chooseType4 == 0 {
                node4.texture = SKTexture(imageNamed: "Bonus_Left.png")
                
                node4.type = 0
            }
            else if chooseType4 == 1{
                node4.texture = SKTexture(imageNamed: "Bonus_Right.png")
                
                node4.type = 1
            }
            
            node4.setGold(chooseGold)
            bonusBack.addChild(node4)
            
            
            node5Rem = "node5Rem" + String(chanceN5)
            chanceN5 = (chanceN5 + 1) % 100
            node5 = JDHomeButtons(size: CGSize(width: 40,height: 40))
            node5.position = CGPoint(x: 60,y: 0)
            node5.name = node5Rem
            node5.zPosition = 700
            if chooseType5 == 0 {
                node5.texture = SKTexture(imageNamed: "Bonus_Left.png")
                
                node5.type = 0
            }
            else if chooseType5 == 1{
                node5.texture = SKTexture(imageNamed: "Bonus_Right.png")
                
                node5.type = 1
            }
            
            node5.setGold(chooseGold)
            bonusBack.addChild(node5)
            
            
            node6Rem = "node6Rem" + String(chanceN6)
            chanceN6 = (chanceN6 + 1) % 100
            node6 = JDHomeButtons(size: CGSize(width: 40,height: 40))
            node6.position = CGPoint(x: 100,y: 0)
            node6.name = node6Rem
            node6.zPosition = 700
            if chooseType6 == 0 {
                node6.texture = SKTexture(imageNamed: "Bonus_Left.png")
                
                node6.type = 0
            }
            else if chooseType6 == 1{
                node6.texture = SKTexture(imageNamed: "Bonus_Right.png")
                
                node6.type = 1
            }
            
            node6.setGold(chooseGold)
            bonusBack.addChild(node6)
        }
        else if chooseNum == 4 {
            chooseGold = Int(arc4random_uniform(UInt32(coGold)))
            
            node1Rem = "node1Rem" + String(chanceN)
            chanceN = (chanceN + 1) % 100
            
            node1 = JDHomeButtons(size: CGSize(width: 40,height: 40))
            node1.position = CGPoint(x: -120,y: 0)
            node1.name = node1Rem
            node1.zPosition = 700
            if chooseType1 == 0 {
                
                node1.texture = SKTexture(imageNamed: "Bonus_Left.png")
                node1.type = 0
            }
                
            else if chooseType1 == 1{
                node1.texture = SKTexture(imageNamed: "Bonus_Right.png")
                
                node1.type = 1
            }
            
            node1.setGold(chooseGold)
            bonusBack.addChild(node1)
            
            
            node2Rem = "node2Rem" + String(chanceN2)
            chanceN2 = (chanceN2 + 1) % 100
            
            node2 = JDHomeButtons(size: CGSize(width: 40,height: 40))
            node2.position = CGPoint(x: -80,y: 0)
            node2.name = node2Rem
            node2.zPosition = 700
            if chooseType2 == 0 {
                node2.texture = SKTexture(imageNamed: "Bonus_Left.png")
                
                node2.type = 0
            }
            else if chooseType2 == 1{
                node2.texture = SKTexture(imageNamed: "Bonus_Right.png")
                
                node2.type = 1
            }
            
            node2.setGold(chooseGold)
            bonusBack.addChild(node2)
            
            node3Rem = "node3Rem" + String(chanceN3)
            chanceN3 = (chanceN3 + 1) % 100
            
            node3 = JDHomeButtons(size: CGSize(width: 40,height: 40))
            node3.position = CGPoint(x: -40,y: 0)
            node3.name = node3Rem
            node3.zPosition = 700
            if chooseType3 == 0 {
                node3.texture = SKTexture(imageNamed: "Bonus_Left.png")
                
                node3.type = 0
            }
            else if chooseType3 == 1{
                node3.texture = SKTexture(imageNamed: "Bonus_Right.png")
                
                node3.type = 1
            }
            
            node3.setGold(chooseGold)
            bonusBack.addChild(node3)
            
            node4Rem = "node4Rem" + String(chanceN4)
            chanceN4 = (chanceN4 + 1) % 100
            
            node4 = JDHomeButtons(size: CGSize(width: 40,height: 40))
            node4.position = CGPoint(x: 0,y: 0)
            node4.name = node4Rem
            node4.zPosition = 700
            if chooseType4 == 0 {
                node4.texture = SKTexture(imageNamed: "Bonus_Left.png")
                
                node4.type = 0
            }
            else if chooseType4 == 1{
                node4.texture = SKTexture(imageNamed: "Bonus_Right.png")
                
                node4.type = 1
            }
            
            node4.setGold(chooseGold)
            bonusBack.addChild(node4)
            
            
            node5Rem = "node5Rem" + String(chanceN5)
            chanceN5 = (chanceN5 + 1) % 100
            node5 = JDHomeButtons(size: CGSize(width: 40,height: 40))
            node5.position = CGPoint(x: 40,y: 0)
            node5.name = node5Rem
            node5.zPosition = 700
            if chooseType5 == 0 {
                node5.texture = SKTexture(imageNamed: "Bonus_Left.png")
                
                node5.type = 0
            }
            else if chooseType5 == 1{
                node5.texture = SKTexture(imageNamed: "Bonus_Right.png")
                
                node5.type = 1
            }
            
            node5.setGold(chooseGold)
            bonusBack.addChild(node5)
            
            node6Rem = "node6Rem" + String(chanceN6)
            chanceN6 = (chanceN6 + 1) % 100
            node6 = JDHomeButtons(size: CGSize(width: 40,height: 40))
            node6.position = CGPoint(x: 80,y: 0)
            node6.name = node6Rem
            node6.zPosition = 700
            if chooseType6 == 0 {
                node6.texture = SKTexture(imageNamed: "Bonus_Left.png")
                
                node6.type = 0
            }
            else if chooseType6 == 1{
                node6.texture = SKTexture(imageNamed: "Bonus_Right.png")
                
                node6.type = 1
            }
            
            node6.setGold(chooseGold)
            bonusBack.addChild(node6)
            
            
            node7Rem = "node7Rem" + String(chanceN7)
            chanceN7 = (chanceN7 + 1) % 100
            node7 = JDHomeButtons(size: CGSize(width: 40,height: 40))
            node7.position = CGPoint(x: 120,y: 0)
            node7.name = node7Rem
            node7.zPosition = 700
            if chooseType7 == 0 {
                node7.texture = SKTexture(imageNamed: "Bonus_Left.png")
                
                node7.type = 0
            }
            else if chooseType7 == 1{
                node7.texture = SKTexture(imageNamed: "Bonus_Right.png")
                
                node7.type = 1
            }
            
            node7.setGold(chooseGold)
            bonusBack.addChild(node7)
        }
        
        node1.run(glowNode())
    }
    
    func saveHighScore(_ number: Int) {
        
        Defaults.set(number, forKey: DefaultType.highScore)
        
        if GKLocalPlayer.localPlayer().isAuthenticated {
            
            let scoreReport = GKScore(leaderboardIdentifier: "trumppunch.topstreaks")
            
            scoreReport.value = Int64(number)
            
            let scoreArray : [GKScore] = [scoreReport]
            
            GKScore.report(scoreArray, withCompletionHandler: nil)
        }
    }
    
    func addtrumpPunchLabel(){
        
        let trumpPunchLabel = JDHomeButtons(size: CGSize(width: 100, height: 30))
        trumpPunchLabel.name = "swipeTo"
        trumpPunchLabel.texture = SKTexture(imageNamed: "Clear")
        
        trumpPunchLabel.position.x = view!.center.x
        trumpPunchLabel.position.y = view!.center.y + 130
        
        addChild(trumpPunchLabel)
        
        trumpPunchLabel.run(blinkAnimation())
        
    }
    
    func addBody(_ w: String) {
        
        trumpBody = JDHomeButtons(size: CGSize(width: view!.frame.width + 80, height: 350))
        trumpBody.position = CGPoint(x: view!.center.x - 10, y: view!.center.y - 180)
        trumpBody.zPosition = -41
        
        addChild(trumpBody)
    }
    
    func addTopBottom() {
        
        barT = JDHomeButtons(size: CGSize(width: view!.frame.width + 100, height: view!.frame.height / 2.5))
        barT.texture = SKTexture(imageNamed: "GameTop")
        barT.name = "BarT"
        barT.zPosition = -40
        barT.position = CGPoint(x: view!.center.x, y: view!.center.y + view!.frame.height)
        addChild(barT)
        
        barB = JDHomeButtons(size: CGSize(width: view!.frame.width + 100, height: view!.frame.height / 2.5))
        barB.texture = SKTexture(imageNamed: "GameTop")
        barB.name = "BarB"
        barB.zPosition = 100
        barB.position = CGPoint(x: view!.center.x, y: view!.center.y - view!.frame.height)
        addChild(barB)
        
        let goHome = JDHomeButtons(size: CGSize(width: 40, height: 40))
        goHome.position = CGPoint(x: 130, y: 86)
        goHome.name = "goHome"
        goHome.texture = SKTexture(imageNamed: "XGame.png")
        goHome.zPosition = 400
        barB.addChild(goHome)
        
        barT.run(SKAction.moveTo(y: view!.center.y + view!.frame.height / 2, duration: 0.5), completion: {
            self.home.run(SKAction.fadeAlpha(to: 1, duration: 0.5))
            
        })
        barB.run(SKAction.moveTo(y: view!.center.y - view!.frame.height / 2, duration: 0.5), completion: {
            
            
        })
        
        BaseViewController.shopCoinBack.center = CGPoint(x: MidX,y: UIScreen.main.bounds.midY + UIScreen.main.bounds.height / 2 - BaseViewController.shopCoinBack.frame.height / 2 - 50 )
        BaseViewController.shopCoinBack.isHidden = false
    }
    
    
    
    //HOME BUTTONS
    func addHomeButtons(_ num: Int){
        
        if num == 3{
            home = JDHomeButtons(size:CGSize(width: view!.frame.width / 1.2, height: view!.frame.height / 9))
            home.texture = SKTexture(imageNamed: "TrumpPunch.png")
            home.position.x = view!.center.x
            home.position.y = view!.center.y + 200
            home.name = "TopBar"
            addChild(home)
            
        }
            
            
        else if num == 5{
            home = JDHomeButtons(size:CGSize(width: view!.frame.width / 1.2, height: view!.frame.height / 4))
            home.texture = SKTexture(imageNamed: "Home_Punch.png")
            home.position.x = view!.center.x
            home.position.y = view!.center.y
            home.name = "PunchHeaven"
            addChild(home)
            let settings = SKLabelNode(text: "PUNCH")
            settings.fontColor = UIColor.white
            settings.fontSize = 50.0
            settings.fontName = "Helvetica"
            settings.position = CGPoint(x: 0, y: -10)
            settings.name = "PunchHeavenT"
            home.addChild(settings)
        }
        
        
    }
    
    func addRunningLabels(_ num: Int){
        
        
        if num == 3{
            
            timeT = SKLabelNode(text: "Time")
            timeT.position.x = 0
            timeT.position.y = -30
            timeT.zPosition = 20
            timeT.fontSize = 20.0
            timeT.fontColor = UIColor.white
            timeT.fontName = "Helvetica-Bold"
            barT.addChild(timeT)
            
            home = JDHomeButtons(size:CGSize(width: 170, height: 30))
            home.texture = SKTexture(imageNamed: "TimeBar")
            home.position.x = view!.center.x - 80
            home.position.y = view!.center.y + view!.frame.height / 2.5
            home.name = "Time"
            home.alpha = 0
            addChild(home)
            home.zPosition = -20
            
            let gloss = JDHomeButtons(size:CGSize(width: 20, height: 20))
            gloss.texture = SKTexture(imageNamed: "TimeBar")
            gloss.position = CGPoint(x: 0, y: 0)
            gloss.name = "Gloss"
            gloss.zPosition = 770
            gloss.isHidden = true
            home.addChild(gloss)
            
            hpDial = JDHomeButtons(size:CGSize(width: 180, height: 45))
            hpDial.texture = SKTexture(imageNamed: "GameGoldBack")
            
            hpDial.position = CGPoint(x: 80 ,y: 0)
            hpDial.name = "timeDial"
            hpDial.zPosition = 725
            
            home.addChild(hpDial)
        }
    }
    
    func startTimer() {
        
        let timeDial = childNode(withName: "Time") as! JDHomeButtons
        
        timeDial.run(rotateDial(0, duration: Double(1)), completion: {
            
            self.hpCount1 -= 7
            
            if self.hpCount1 > 0 && self.stillGoing == true {
                
                self.startTimer()
            }
                
            else {
                
                if self.stillGoing == true {
                    
                    self.stillGoing = false
                    self.inRound = false
                    
                    if self.inTut == false {
                        
                        self.nextRound()
                    }
                }
            }
        })
    }
    
    func addMoney(_ w: Int){
        
        moneyB = JDHomeButtons(size: CGSize(width: 150, height: 40))
        moneyB.name = "moneyBack"
        moneyB.texture = SKTexture(imageNamed: "Icon_NMoneyBack.png")
        moneyB.position.x = 0
        moneyB.position.y = 50
        moneyB.zPosition = 10000
        moneyB.alpha = 0
        barB.addChild(moneyB)
        
        money = JDRunningLabels(num: 0)
        money.name = "Money"
        money.fontColor = UIColor.white
        money.position = CGPoint(x: 0, y: -10)
        money.isHidden = true
        moneyB.addChild(money)
    
        moneyNeeded = JDMoneyNeeded(num: 0, chooser: 0)
        moneyNeeded.position = CGPoint(x: 0, y: -10)
        moneyNeeded.fontSize = 29.0
        moneyNeeded.fontColor = UIColor.white
        moneyNeeded.isHidden = true
        moneyB.addChild(moneyNeeded)
        
        loadMoney()
    }
    
    func addWeaponButtons(_ num: Int){
        
        if num == 0{
            home = JDHomeButtons(size:CGSize(width: view!.frame.width / 5, height: view!.frame.height / 12))
            home.texture = SKTexture(imageNamed: "Selected.png")
            home.position.x = view!.center.x
            home.position.y = view!.center.y - 200
            home.name = "TopBar"
            addChild(home)
            
        }
        else if num == 5{
            
            home = JDHomeButtons(size:CGSize(width: view!.frame.width / 1.2, height: view!.frame.height / 4))
            home.texture = SKTexture(imageNamed: "Home_Punch.png")
            home.position.x = view!.center.x
            home.position.y = view!.center.y
            home.name = "PunchHeaven"
            addChild(home)
            let settings = SKLabelNode(text: "PUNCH")
            settings.fontColor = UIColor.white
            settings.fontSize = 50.0
            settings.fontName = "Helvetica"
            settings.position = CGPoint(x: 0, y: -10)
            settings.name = "PunchHeavenT"
            home.addChild(settings)
        }
    }
    
    func loadMoney(){
        
        let defaults = UserDefaults.standard
        
        money.setTo(defaults.integer(forKey: "money"))
    }
    
    func keepGoing() {
        
        let timer = childNode(withName: "Time") as! JDHomeButtons
        let timeDial = timer.childNode(withName: "timeDial")
        let goHome = barB.childNode(withName: "goHome") as! JDHomeButtons
        
        goHome.isHidden = false
        inNextMode = false
        nextGo.isHidden = true
        nextGo.zPosition = 0
        timeGo = true
        timeDial!.isHidden = false
        timer.isHidden = false
        homeQuote.removeFromParent()
    }
    
    func toQuote() {
        inRound = false
        inContinueMode = true
        let timer = childNode(withName: "Time") as! JDHomeButtons
        let bonusBack = childNode(withName: "BonusBack") as! JDHomeButtons
        let bonusText = bonusBack.childNode(withName: "BonusText") as! JDHomeButtons
        
        bonusText.run(fadeIt2())
        bonusText.run(up2())
        timer.run(fadeIt2())
        timer.run(up3())
        
        lives.isHidden = true
        heart.isHidden = true
        livesT.isHidden = true
        
        node1.run(fadeIt2())
        node1.run(up1(), completion: {
            self.node2.run(self.fadeIt2())
            self.node2.run(self.up1(), completion:  {
                self.node3.run(self.fadeIt2())
                self.node3.run(self.up1(), completion: {
                    self.node4.run(self.fadeIt2())
                    self.node4.run(self.up1())
                })
            })
        })
        
        streakT.run(moveScore())
        roundT.run(moveBestScore())
        
        let gameOverT = JDHomeButtons(size: CGSize(width: 0, height: 0))
        gameOverT.position = CGPoint(x: view!.center.x, y: view!.center.y + 200)
        gameOverT.texture = SKTexture(imageNamed: "GameOverFinal")
        addChild(gameOverT)
        gameOverT.run(popGameOverT(), completion: {
            
            gameOverT.run(self.popGameOverT2(), completion: {
                gameOverT.run(self.nodeShrink(), completion: {
                    
                    self.homeStart = JDHomeButtons(size:CGSize(width: 150, height: 50))
                    self.homeStart!.texture = SKTexture(imageNamed: "Begin_Home.png")
                    self.homeStart!.position.x = self.view!.center.x
                    self.homeStart!.position.y = self.view!.center.y - 120
                    self.homeStart!.name = "HomeStart"
                    self.homeStart!.zPosition = 900
                    self.addChild(self.homeStart!)
                    
                    let homeBText = JDHomeButtons(size:CGSize(width: 100, height: 30))
                    
                    homeBText.texture = SKTexture(imageNamed: "Begin_Text.png")
                    
                    homeBText.position = CGPoint(x: 0,y: 0)
                    homeBText.name = "HomeBText"
                    self.homeStart!.addChild(homeBText)
                    
                })
            })
        })
    }
    
    func endGame(_ w: Int) {
        
        backView = JDHomeButtons(size: CGSize(width: view!.frame.width + 100, height: view!.frame.height + 100))
        backView!.position = CGPoint(x: view!.center.x, y: view!.center.y)
        backView!.name = "BackView"
        backView!.zPosition = 1000
        backView!.texture = SKTexture(imageNamed: "BackView.png")
        backView!.alpha = 0
        addChild(backView!)
        
        //High score stuff
        let endBack = JDHomeButtons(size: CGSize(width: 200,height: 200))
        endBack.position = CGPoint(x: view!.center.x,y: view!.center.y)
        endBack.name = "EndBack"
        endBack.zPosition = 1001
        endBack.texture = SKTexture(imageNamed: "Icon_EndBack")
        addChild(endBack)
        
        let bestText = JDHomeButtons(size: CGSize(width: 200,height: 50))
        bestText.position = CGPoint(x: 100, y: 100)
        bestText.texture = SKTexture(imageNamed: "Text_Best")
        bestText.zPosition = 1001
        bestText.name = "BestText"
        endBack.addChild(bestText)
        
        let scoreText = JDHomeButtons(size: CGSize(width: 200,height: 50))
        scoreText.position = CGPoint(x: -100, y: 100)
        scoreText.texture = SKTexture(imageNamed: "Text_Score")
        scoreText.zPosition = 1001
        scoreText.name = "ScoreText"
        endBack.addChild(scoreText)
        
        if #available(iOS 9.0, *) {
            roundT!.move(toParent: endBack)
        } else {
            // Fallback on earlier versions
        }
        roundT!.position = CGPoint(x: 100,y: 0)
        roundT.isHidden = false
        
        if #available(iOS 9.0, *) {
            streakT.move(toParent: endBack)
        } else {
            // Fallback on earlier versions
        }
        streakT.position = CGPoint(x: -100,y: 0)
        
        let gameOT = JDHomeButtons(size: CGSize(width: 240,height: 70))
        gameOT.position = CGPoint(x: view!.center.x, y: view!.center.y + 250)
        gameOT.texture = SKTexture(imageNamed: "Text_GameOver")
        gameOT.zPosition = 1001
        gameOT.name = "GameOT"
        addChild(gameOT)
        
        playAgain = JDHomeButtons(size: CGSize(width: 200,height: 50))
        playAgain!.position = CGPoint(x: view!.center.x, y: view!.center.y + 250)
        playAgain!.texture = SKTexture(imageNamed: "Icon_PlayAgain")
        playAgain!.zPosition = 1001
        playAgain!.name = "PlayAgain"
        
        share = JDHomeButtons(size: CGSize(width: 200,height: 50))
        share!.position = CGPoint(x: view!.center.x, y: view!.center.y + 250)
        share!.texture = SKTexture(imageNamed: "Icon_GameButtonBack")
        share!.zPosition = 1001
        share!.name = "Share"
        
        let shareT = JDHomeButtons(size: CGSize(width: 200,height: 50))
        shareT.position = CGPoint(x: 0, y: 0)
        shareT.texture = SKTexture(imageNamed: "Icon_Share")
        shareT.zPosition = 1001
        shareT.name = "ShareT"
        share!.addChild(shareT)
        
        leader = JDHomeButtons(size: CGSize(width: 200,height: 50))
        leader!.position = CGPoint(x: view!.center.x, y: view!.center.y + 250)
        leader!.texture = SKTexture(imageNamed: "Icon_GameButtonBack")
        leader!.zPosition = 1001
        leader!.name = "Leader"
        
        let leaderT = JDHomeButtons(size: CGSize(width: 200,height: 50))
        leaderT.position = CGPoint(x: view!.center.x, y: view!.center.y + 250)
        leaderT.texture = SKTexture(imageNamed: "Icon_Leaders")
        leaderT.zPosition = 1001
        leaderT.name = "LeaderT"
    }
    
    func loadTopBar() {
        let topB = JDHomeButtons(size: CGSize(width: view!.frame.width + 30, height: view!.frame.height / 6))
        topB.position = CGPoint(x: view!.center.x, y: view!.center.y + view!.frame.height / 2.3)
        topB.texture = SKTexture(imageNamed: "Icon_TopB")
        topB.name = "TopB"
        topB.zPosition = 1001
        addChild(topB)
        
        let goBack = JDHomeButtons(size: CGSize(width: 200,height: 50))
        goBack.position = CGPoint(x: view!.center.x, y: view!.center.y + 250)
        goBack.texture = SKTexture(imageNamed: "Icon_GoBack")
        goBack.zPosition = 1001
        goBack.name = "GoBack"
        topB.addChild(goBack)
        
        //Settings Buttton
        let settingsButton = JDHomeButtons(size: CGSize(width: 40, height: 40))
        settingsButton.texture = SKTexture(imageNamed: "Button_Settings.png")
        settingsButton.position = CGPoint(x: 100, y: 0)
        settingsButton.zPosition = 28
        settingsButton.name = "SettingsButton"
        topB.addChild(settingsButton)
        
        let settingsButtonT = JDHomeButtons(size: CGSize(width: 20, height: 20))
        settingsButtonT.texture = SKTexture(imageNamed: "Icon_Settings.png")
        settingsButtonT.position.x = 0
        settingsButtonT.position.y = 0
        settingsButtonT.name = "SettingsButtonT"
        settingsButton.addChild(settingsButtonT)
    }
    
    func nextRound(){
        
        endGame = true
        
        playSound(named: Sounds.gameOver)
        BaseViewController.saveCoins()
        runSceneGo()
    }
    
    func appearLives() {
        
        leftStart!.alpha = 0
        rightStart!.alpha = 0
        leftStart!.removeAllActions()
        rightStart!.removeAllActions()
        
        livesT.run(SKAction.fadeAlpha(to: 1, duration: 0.5))
        throughFirst = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            
            let goHome = barB.childNode(withName: "goHome") as! JDHomeButtons
            
            if let name = touchedNode.name {
                
                if isStarted == false {
                    
                    self.startTimer()
                    isStarted = true
                    doAgain = 0
                    
                }
                
                if (name == "RightScreen" || name == "rightBoomArrow") && inRound == true {
                    
                    if inNextMode == false {
                        
                        gamePerson.getHitFromRight()
                        
                        if bonusGo == 0 {
                            
                            if node1.type == 1 {
                                
                                
                                bonusGo = 1
                                
                                node1.texture = SKTexture(imageNamed: "GreenBall.png")
                                node1.run(popNode())
                                node1.removeAllActions()
                                node2.run(glowNode())
                            }
                            else {
                                
                                resetNode()
                            }
                        }
                        else if bonusGo == 1 {
                            
                            if node2.type == 1 {
                                
                                bonusGo = 2
                                
                                node2.texture = SKTexture(imageNamed: "GreenBall.png")
                                node2.run(popNode())
                                node2.removeAllActions()
                                node3.run(glowNode())
                                
                            }
                            else {
                                
                                resetNode()
                            }
                        }
                        else if bonusGo == 2 {
                            if node3.type == 1 {
                                bonusGo = 3
                                
                                node3.texture = SKTexture(imageNamed: "GreenBall.png")
                                node3.run(popNode())
                                node3.removeAllActions()
                                
                                
                                if chooseNum == 0 {
                                    appearLives()
                                    doneCombo()
                                }
                                else {
                                    node4.run(glowNode())
                                }
                            }
                            else {
                                resetNode()
                            }
                        }
                        else if bonusGo == 3 {
                            if node4.type == 1 {
                                
                                bonusGo = 4
                                node4.texture = SKTexture(imageNamed: "GreenBall.png")
                                node4.run(popNode())
                                node4.removeAllActions()
                                
                                if chooseNum == 1 {
                                    doneCombo()
                                }
                                else {
                                    node5.run(glowNode())
                                }
                            }
                            else {
                                resetNode()
                            }
                        }
                        else if bonusGo == 4 {
                            if node5.type == 1 {
                                
                                bonusGo = 5
                                node5.texture = SKTexture(imageNamed: "GreenBall.png")
                                node5.run(popNode())
                                node5.removeAllActions()
                                
                                if chooseNum == 2 {
                                    doneCombo()
                                }
                                else {
                                    node6.run(glowNode())
                                }
                            }
                            else {
                                resetNode()
                            }
                        }
                        else if bonusGo == 5 {
                            if node6.type == 1 {
                                
                                bonusGo = 6
                                node6.texture = SKTexture(imageNamed: "GreenBall.png")
                                node6.run(popNode())
                                node6.removeAllActions()
                                
                                
                                if chooseNum == 3 {
                                    doneCombo()
                                }
                                else {
                                    node7.run(glowNode())
                                }
                            }
                            else {
                                resetNode()
                            }
                        }
                        else if bonusGo == 6 {
                            if node7.type == 1 {
                                
                                node7.texture = SKTexture(imageNamed: "GreenBall.png")
                                node7.run(popNode())
                                node7.removeAllActions()
                                
                                doneCombo()
                            }
                            else {
                                
                                resetNode()
                            }
                        }
                    }
                    
                    hitChoice = 1
                    
                    rightBoomB.run(rotateBoom())
                    if wN == 0 {
                        playSound(named: Sounds.tomatoes)
                        
                        
                        let swag = "rBye" + String(chance)
                        
                        self.rightBoom.name = swag
                        
                        chance = (chance + 1)%100
                        
                        rightBoom.run(rightTomato(), completion: {
                            
                            let byeR = self.childNode(withName: swag)
                            byeR!.removeFromParent()
                        })
                        
                        self.rightBoom = JDArrows(sizeOf: CGSize(width: 60, height: 60))
                        self.rightBoom.texture = SKTexture(imageNamed: "\(Item.name)_Right")
                        self.rightBoom.position.x = self.view!.center.x + self.view!.frame.width / 1.5
                        rightBoom.position.y = view!.center.y
                        self.addChild(self.rightBoom)
                    }
                    else if wN == 1 {
                        playSound(named: Sounds.fish)
                        rightBoom.run(rightFish())
                    }
                    else if wN == 2 {
                        playSound(named: Sounds.fish)
                        rightBoom.run(rightFish())
                    }
                    else if wN == 3 {
                        playSound(named: Sounds.gloves)
                        rightBoom.run(rightPunch())
                    }
                    else if wN == 4 {
                        playSound(named: Sounds.nukes)
                        rightBoom.run(nukeShrink())
                        let swag = "rBye" + String(chance2)
                        
                        
                        self.rightBoom.name = swag
                        
                        chance2 = (chance2 + 1)%100
                        
                        rightBoom.run(rightNuke(), completion: {
                            
                            let byeR = self.childNode(withName: swag)
                            byeR!.removeFromParent()
                        })
                        
                        self.rightBoom = JDArrows(sizeOf: CGSize(width: 100, height: 100))
                        
                        self.rightBoom.texture = SKTexture(imageNamed: "\(Item.name)_Right")
                        self.rightBoom.position = CGPoint(x: self.view!.center.x + self.view!.frame.width, y: self.view!.center.y + 100)
                        self.addChild(self.rightBoom)
                        rightBoom.run(popNuke())
                    }
                    
//                    trump.run(SKAction.moveBy(x: -20, y: 0, duration: 0.1), completion: {
//                        
//                        self.trump.run(SKAction.moveBy(x: 20, y: 0, duration: 0.1))
//                    })
//                    
//                    trumpBody.run(SKAction.rotate(byAngle: CGFloat(M_PI / 7), duration: 0.1), completion: {
//                        
//                        self.trumpBody.run(SKAction.rotate(byAngle: CGFloat(-M_PI / 7), duration: 0.1))
//                        
//                    })
                    
                    boomGoR = 20
                    rightBoomB.isHidden = false
                    
                }
                else if (name == "LeftScreen" || name == "leftBoomArrow") && inRound == true {
                    
                    if inNextMode == false {
                        
                        gamePerson.getHitFromLeft()
                        
                        if bonusGo == 0 {
                            if node1.type == 0 {
                                
                                bonusGo = 1
                                node1.texture = SKTexture(imageNamed: "GreenBall.png")
                                node1.run(popNode())
                            }
                            else {
                                resetNode()
                            }
                            
                        }
                        else if bonusGo == 1 {
                            if node2.type == 0 {
                                
                                bonusGo = 2
                                node2.texture = SKTexture(imageNamed: "GreenBall.png")
                                node2.run(popNode())
                                
                            }
                            else {
                                resetNode()
                            }
                        }
                        else if bonusGo == 2 {
                            if node3.type == 0 {
                                
                                bonusGo = 3
                                node3.texture = SKTexture(imageNamed: "GreenBall.png")
                                node3.run(popNode())
                                if chooseNum == 0 {
                                    appearLives()
                                    doneCombo()
                                }
                                
                            }
                            else {
                                resetNode()
                            }
                        }
                        else if bonusGo == 3 {
                            if node4.type == 0 {
                                
                                bonusGo = 4
                                node4.texture = SKTexture(imageNamed: "GreenBall.png")
                                node4.run(popNode())
                                if chooseNum == 1 {
                                    doneCombo()
                                }
                                
                            }
                            else {
                                
                                resetNode()
                            }
                        }
                        else if bonusGo == 4 {
                            if node5.type == 0 {
                                
                                bonusGo = 5
                                node5.texture = SKTexture(imageNamed: "GreenBall.png")
                                node5.run(popNode())
                                if chooseNum == 2 {
                                    doneCombo()
                                }
                                
                            }
                            else {
                                
                                resetNode()
                            }
                        }
                        else if bonusGo == 5 {
                            if node6.type == 0 {
                                
                                bonusGo = 6
                                node6.texture = SKTexture(imageNamed: "GreenBall.png")
                                node6.run(popNode())
                                if chooseNum == 3 {
                                    doneCombo()
                                }
                                
                            }
                            else {
                                
                                resetNode()
                            }
                        }
                        else if bonusGo == 6 {
                            if node7.type == 0 {
                                
                                node7.texture = SKTexture(imageNamed: "GreenBall.png")
                                node7.run(popNode())
                                doneCombo()
                            }
                            else {
                                
                                resetNode()
                            }
                        }
                    }
                    
                    leftBoomB.run(rotateBoom())
                    if wN == 0 {
                        playSound(named: Sounds.tomatoes)
                        let swag = "lBye" + String(chance)
                        
                        self.leftBoom.name = swag
                        
                        chance = (chance + 1)%100
                        
                        
                        leftBoom.run(leftTomato(), completion: {
                            
                            let byeL = self.childNode(withName: swag)
                            byeL!.removeFromParent()
                        })
                        
                        self.leftBoom = JDArrows(sizeOf: CGSize(width: 60, height: 60))
                        self.leftBoom.texture = SKTexture(imageNamed: "\(Item.name)_Left")
                        self.leftBoom.position.x = self.view!.center.x - self.view!.frame.width / 1.5
                        self.leftBoom.position.y = view!.center.y
                        self.addChild(self.leftBoom)
                        
                    }
                    else if wN == 1 {
                        playSound(named: Sounds.fish)
                        leftBoom.run(leftFish())
                    }
                    else if wN == 2 {
                        playSound(named: Sounds.fish)
                        leftBoom.run(leftFish())
                    }
                    else if wN == 3 {
                        playSound(named: Sounds.gloves)
                        leftBoom.run(leftPunch())
                    }
                    else if wN == 4 {
                        playSound(named: Sounds.nukes)
                        leftBoom.run(nukeShrink())
                        let swag = "lBye" + String(chance)
                        
                        self.leftBoom.name = swag
                        
                        chance = (chance + 1)%100
                        
                        leftBoom.run(leftNuke(), completion: {
                            
                            let byeL = self.childNode(withName: swag)
                            byeL!.removeFromParent()
                        })
                        
                        self.leftBoom = JDArrows(sizeOf: CGSize(width: 100, height: 100))
                        self.leftBoom.texture = SKTexture(imageNamed: "\(Item.name)_Left")
                        self.leftBoom.position = CGPoint(x: self.view!.center.x - self.view!.frame.width, y: self.view!.center.y + 100)
                        self.addChild(self.leftBoom)
                        leftBoom.run(popNuke())
                    }
                    
                    hitChoice = 0
                    
//                    trump.run(SKAction.moveBy(x: 20, y: 0, duration: 0.1), completion: {
//                        
//                        self.trump.run(SKAction.moveBy(x: -20, y: 0, duration: 0.1))
//                    })
//                    
//                    trumpBody.run(SKAction.rotate(byAngle: CGFloat(-M_PI / 7), duration: 0.1), completion: {
//                        
//                        self.trumpBody.run(SKAction.rotate(byAngle: CGFloat(M_PI / 7), duration: 0.1))
//                    })
                    
                    boomGoL = 20
                    leftBoomB.isHidden = false
                }
                else if (name ==  "NextGo" || name == "NextGoT") && inNextMode == true{
                    
                    nextGo.run(popDownNext())
                    button = 10
                }
                    
                else if name ==  "goHome"{
                    
                    goHome.run(popBackDown())
                    button = 11
                }
                else if name == "HomeGo" || name == "HomeGoT" {
                    homeGo.run(SKAction.resize(toWidth: 160, height: 40, duration: 0.1))
                    button = 2012
                }
                    
                else if name == "ContinueItem" || name == "ContinueItemT"{
                    button = 2020
                    buyItem.run(SKAction.resize(toWidth: 170, height: 40, duration: 0.1))
                }
                else if ((name == "BackItem2" || name == "BackView2") && doneWidth == true) {
                    
                    button = 101
                }
                else if name == "BackView4"{
                    button = 2020
                }
                else if name == "XOut" {
                    inItem = false
                    xOut.run(popBackDown())
                    
                    button = 9991
                }
            }
        }
    }
    
    func doneCombo() {
        
        addTime()
        
        streakScore += 1
        streak1.setTo(streakScore)
        
        newBonus()
        addCoins()
        
        playSound(named: Sounds.score)
        
        if streakScore > Defaults.integer(forKey: DefaultType.highScore) {
            
            saveHighScore(streakScore)
        }
    }
    
    func addTut(_ num: Int) {
        
        inTut = true
        let time = childNode(withName: "Time") as! JDHomeButtons
        if didStartTut == 0 {
            
            didStartTut = 1
            
            backView = JDHomeButtons(size: CGSize(width: view!.frame.width + 100, height: view!.frame.height + 100))
            backView!.position = CGPoint(x: view!.center.x, y: view!.center.y)
            backView!.name = "BackView"
            backView!.zPosition = 1000
            backView!.texture = SKTexture(imageNamed: "BackView.png")
            addChild(backView!)
            
            
            self.homeStart = JDHomeButtons(size:CGSize(width: 150, height: 50))
            self.homeStart!.texture = SKTexture(imageNamed: "Begin_Home.png")
            self.homeStart!.position.x = self.view!.center.x
            self.homeStart!.position.y = self.view!.center.y - 120
            self.homeStart!.name = "HomeStart"
            self.homeStart!.zPosition = 1010
            self.addChild(self.homeStart!)
            
            let homeBText = JDHomeButtons(size:CGSize(width: 50,height: 35))
            
            homeBText.texture = SKTexture(imageNamed: "Text_Ok")
            
            homeBText.position = CGPoint(x: 0,y: 0)
            homeBText.zPosition = 1011
            homeBText.name = "HomeBText"
            self.homeStart!.addChild(homeBText)
            
            
            labelTut = SKMultilineLabel(text: "Tap the left or the right side of the screen to hit the combo. Hit Gold combos to collect coins! ", labelWidth: 250, pos: CGPoint(x: view!.center.x, y: view!.center.y + 65))
            
            labelTut!.fontColor = SKColor.white
            labelTut!.fontSize = 25.0
            labelTut!.fontName = "Helvetica"
            labelTut!.zPosition = 1100
            labelTut!.leading = 25
            
            addChild(labelTut!)
            
        }
        
        if num == 0 {
            
            node1.zPosition = 1001
            node2.zPosition = 1001
            node3.zPosition = 1001
        }
        else if num == 1 {
            node1.zPosition = 999
            node2.zPosition = 999
            node3.zPosition = 999
            
            
            time.zPosition = 1002
            
            livesT.alpha = 1
            hpDial.zPosition = 1
            heart!.zPosition = 1
            livesT.zPosition = 1100
            timeT.zPosition = 1100
            lives.zPosition = 2
            
            streak1.zPosition = 2
            streakT.zPosition = 1100
            streakTB!.zPosition = 1
            
            labelTut!.text = "Hitting a combo adds to your Score and Time. When you miss a combo you lose a Life."
        }
        else if num == 2{
            let homeB = homeStart!.childNode(withName: "HomeBText") as! JDHomeButtons
            //Old
            heart!.zPosition = 1
            livesT.zPosition = 951
            timeT.zPosition = 951
            lives.zPosition = 2
            time.zPosition = 950
            
            streak1.zPosition = 2
            streakT.zPosition = 951
            streakTB!.zPosition = 1
            
            //new
            moneyB.zPosition = 2000
            moneyNeeded.zPosition = 1002
            shine!.zPosition = 3
            
            homeB.size = CGSize(width: 50,height: 35)
            homeB.texture = SKTexture(imageNamed: "Text_Ok")
            labelTut!.text = "Use the coins you collect to buy new items and other people to hit."
        }
    }
    
    func resetNode() {
        
        playSound(named: Sounds.wrong)
        
        let backgroundOf = childNode(withName: "BackGround") as! JDHomeButtons
        chooseGold = 0
        
        inWrong = true
        if throughFirst == true {
            
            lives.sub()
            heart.run(popHeart2())
        }
        
        bonusGo = 0
        if node1.type == 0 {
            node1.texture = SKTexture(imageNamed: "Bonus_Left.png")
        }
        else {
            node1.texture = SKTexture(imageNamed: "Bonus_Right.png")
        }
        if node2.type == 0 {
            node2.texture = SKTexture(imageNamed: "Bonus_Left.png")
        }
        else {
            node2.texture = SKTexture(imageNamed: "Bonus_Right.png")
        }
        if node3.type == 0 {
            node3.texture = SKTexture(imageNamed: "Bonus_Left.png")
        }
        else {
            node3.texture = SKTexture(imageNamed: "Bonus_Right.png")
        }
        
        if chooseNum == 1 {
            if node4.type == 0 {
                node4.texture = SKTexture(imageNamed: "Bonus_Left.png")
            }
            else {
                node4.texture = SKTexture(imageNamed: "Bonus_Right.png")
            }
        }
        else if chooseNum == 2{
            if node4.type == 0 {
                node4.texture = SKTexture(imageNamed: "Bonus_Left.png")
            }
            else {
                node4.texture = SKTexture(imageNamed: "Bonus_Right.png")
            }
            if node5.type == 0 {
                node5.texture = SKTexture(imageNamed: "Bonus_Left.png")
            }
            else {
                node5.texture = SKTexture(imageNamed: "Bonus_Right.png")
            }
        }
        else if chooseNum == 3 {
            if node4.type == 0 {
                node4.texture = SKTexture(imageNamed: "Bonus_Left.png")
            }
            else {
                node4.texture = SKTexture(imageNamed: "Bonus_Right.png")
            }
            if node5.type == 0 {
                node5.texture = SKTexture(imageNamed: "Bonus_Left.png")
            }
            else {
                node5.texture = SKTexture(imageNamed: "Bonus_Right.png")
            }
            if node6.type == 0 {
                node6.texture = SKTexture(imageNamed: "Bonus_Left.png")
            }
            else {
                node6.texture = SKTexture(imageNamed: "Bonus_Right.png")
            }
            
            
        }
        else if chooseNum == 4  {
            
            if node4.type == 0 {
                node4.texture = SKTexture(imageNamed: "Bonus_Left.png")
            }
            else {
                node4.texture = SKTexture(imageNamed: "Bonus_Right.png")
            }
            if node5.type == 0 {
                node5.texture = SKTexture(imageNamed: "Bonus_Left.png")
            }
            else {
                node5.texture = SKTexture(imageNamed: "Bonus_Right.png")
            }
            if node6.type == 0 {
                node6.texture = SKTexture(imageNamed: "Bonus_Left.png")
            }
            else {
                node6.texture = SKTexture(imageNamed: "Bonus_Right.png")
            }
            if node7.type == 0 {
                node7.texture = SKTexture(imageNamed: "Bonus_Left.png")
            }
            else {
                node7.texture = SKTexture(imageNamed: "Bonus_Right.png")
            }
            
        }
        
        let wrong = JDHomeButtons(size: CGSize(width: 100,height: 100))
        wrong.position = CGPoint(x: view!.center.x, y: view!.center.y)
        wrong.texture = SKTexture(imageNamed: "Wrong")
        addChild(wrong)
        backgroundOf.texture = wrongBackground
        wrong.run(wrongPop(), completion: {
            
            wrong.removeFromParent()
            backgroundOf.texture = self.rightBackground
        })
        
    }
    
    func newBonusMoney() {
        
        let weapon = childNode(withName: "weaponNumber") as! JDCandidateNumber
        money.bonusAdd(weapon.number)
        
        moneyNeeded.bonusAdd(weapon.number)
    }
    
    func addTime() {
        let hp = childNode(withName: "Time") as! JDHomeButtons
        if CGFloat(hpCount1) < view!.frame.width / 1.3 {
            
            hpCount1 += 100
        }
        hp.run(flashHp(), completion: {
            
            
            hp.texture = SKTexture(imageNamed: "TimeBar")
            
        })
    }
    
    
    func newBonus() {
        
        bonusGo = 0
        
        let node1G = bonusBack.childNode(withName: node1Rem) as! JDHomeButtons
        let node2G = bonusBack.childNode(withName: node2Rem) as! JDHomeButtons
        let node3G = bonusBack.childNode(withName: node3Rem) as! JDHomeButtons
        
        
        
        node1G.texture = SKTexture(imageNamed: "Timer_Yellow.png")
        node2G.texture = SKTexture(imageNamed: "Timer_Yellow.png")
        node3G.texture = SKTexture(imageNamed: "Timer_Yellow.png")
        
        
        if chooseNum == 1 {
            let node4G = bonusBack.childNode(withName: node4Rem) as! JDHomeButtons
            node4G.texture = SKTexture(imageNamed: "Timer_Yellow.png")
            node4G.run(nodeShrink(), completion: { node4G.removeFromParent()})
        }
        else if chooseNum == 2 {
            let node4G = bonusBack.childNode(withName: node4Rem) as! JDHomeButtons
            let node5G = bonusBack.childNode(withName: node5Rem) as! JDHomeButtons
            node4G.texture = SKTexture(imageNamed: "Timer_Yellow.png")
            node5G.texture = SKTexture(imageNamed: "Timer_Yellow.png")
            node4G.run(nodeShrink(), completion: { node4G.removeFromParent()})
            node5G.run(nodeShrink(), completion: { node5G.removeFromParent()})
        }
        else if chooseNum == 3 {
            let node4G = bonusBack.childNode(withName: node4Rem) as! JDHomeButtons
            let node5G = bonusBack.childNode(withName: node5Rem) as! JDHomeButtons
            let node6G = bonusBack.childNode(withName: node6Rem) as! JDHomeButtons
            node4G.texture = SKTexture(imageNamed: "Timer_Yellow.png")
            node5G.texture = SKTexture(imageNamed: "Timer_Yellow.png")
            node6G.texture = SKTexture(imageNamed: "Timer_Yellow.png")
            node4G.run(nodeShrink(), completion: { node4G.removeFromParent()})
            node5G.run(nodeShrink(), completion: { node5G.removeFromParent()})
            node6G.run(nodeShrink(), completion: { node6G.removeFromParent()})
        }
        else if chooseNum == 4 {
            let node4G = bonusBack.childNode(withName: node4Rem) as! JDHomeButtons
            let node5G = bonusBack.childNode(withName: node5Rem) as! JDHomeButtons
            let node6G = bonusBack.childNode(withName: node6Rem) as! JDHomeButtons
            let node7G = bonusBack.childNode(withName: node7Rem) as! JDHomeButtons
            node4G.texture = SKTexture(imageNamed: "Timer_Yellow.png")
            node5G.texture = SKTexture(imageNamed: "Timer_Yellow.png")
            node6G.texture = SKTexture(imageNamed: "Timer_Yellow.png")
            node7G.texture = SKTexture(imageNamed: "Timer_Yellow.png")
            node4G.run(nodeShrink(), completion: { node4G.removeFromParent()})
            node5G.run(nodeShrink(), completion: { node5G.removeFromParent()})
            node6G.run(nodeShrink(), completion: { node6G.removeFromParent()})
            node7G.run(nodeShrink(), completion: {node7G.removeFromParent()})
        }
        
        
        node1G.run(nodeShrink())
        node2G.run(nodeShrink())
        node3G.run(nodeShrink(), completion: {
            node1G.removeFromParent()
            node2G.removeFromParent()
            node3G.removeFromParent()
            self.addBonus()
        })
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        addBooms()
        if lives.number <= 0 && self.stillGoing == true{
            inRound = false
            stillGoing = false
            nextRound()
        }
        
    }
    
    func loadHighScore(){
        let defaults = UserDefaults.standard
        
        let highScoreLabel = childNode(withName: "highScoreLabel") as! JDRunningLabels
        highScoreLabel.setTo(defaults.integer(forKey: "highscore"))
        
        
    }
    
    func loadScores(){
        let defaults = UserDefaults.standard
        
        streak1H!.setTo(defaults.integer(forKey: "streak"))
    }
    
    func addBooms(){
        
        if boomGoR > 0 {
            
            boomGoR -= 1
        }
        if boomGoR == 0 {
            
            rightBoomB.isHidden = true
        }
        
        if boomGoL > 0 {
            
            boomGoL -= 1
        }
        if boomGoL == 0 {
            
            leftBoomB.isHidden = true
        }
    }
}

//MARK: Animations
extension TPGameScene {
    
    func blinkAnimation() -> SKAction {
        let duration = 0.8
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: duration)
        let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: duration)
        let blink = SKAction.sequence([fadeOut,fadeIn])
        return SKAction.repeatForever(blink)
    }
    
    func popGameOverT() -> SKAction {
        
        let fadeOut = SKAction.resize(toWidth: 240, height: 60, duration: 0.5)
        let fadeIn = SKAction.resize(toWidth: 200, height: 50, duration: 0.2)
        let blink = SKAction.sequence([fadeOut,fadeIn])
        return SKAction.repeat(blink, count: 1)
        
        
    }
    
    func popGameOverT2() -> SKAction {
        
        let wiggleOne = SKAction.rotate(byAngle: 0.02, duration: 0.2)
        let wiggleTwo = SKAction.rotate(byAngle: -0.02, duration: 0.2)
        
        let through = SKAction.sequence([wiggleOne,wiggleTwo,wiggleTwo,wiggleOne,wiggleOne,wiggleTwo,wiggleTwo,wiggleOne])
        
        return SKAction.repeat(through, count: 1)
    }
    
    func flashHp() -> SKAction {
        let hp = childNode(withName: "Time") as! JDHomeButtons
        let blink = SKAction.resize(toWidth: CGFloat(hpCount1), duration: 0.2)
        hp.texture = SKTexture(imageNamed: "FlashBar")
        return SKAction.repeat(blink, count: 1)
        
    }
    
    func pop() -> SKAction {
        
        let shrink = SKAction.resize(toWidth: view!.frame.width / 8, height: view!.frame.height / 13, duration: 0.1)
        let grow = SKAction.resize(toWidth: view!.frame.width / 5, height: view!.frame.height / 7.5, duration: 0.1)
        
        let blink = SKAction.sequence([shrink, grow])
        return SKAction.repeat(blink, count: 1)
        
        
    }
    
    
    func popDownNext() -> SKAction {
        
        let shrink = SKAction.resize(toWidth: 180, height: 50, duration: 0.1)
        
        return SKAction.repeat(shrink, count: 1)
    }
    
    func popUpNext() -> SKAction {
        
        let grow = SKAction.resize(toWidth: 200, height: 75, duration: 0.1)
        
        return SKAction.repeat(grow, count: 1)
    }
    
    func extraShake() -> SKAction {
        
        let wiggleOne = SKAction.rotate(byAngle: 0.02, duration: 0.1)
        let wiggleTwo = SKAction.rotate(byAngle: -0.02, duration: 0.1)
        
        let through = SKAction.sequence([wiggleOne,wiggleTwo,wiggleTwo,wiggleOne,wiggleOne,wiggleTwo,wiggleTwo,wiggleOne])
        
        return SKAction.repeatForever(through)
    }
    
    func wrongPop() -> SKAction {
        
        let grow = SKAction.resize(toWidth: 150, height: 150, duration: 0.1)
        
        let shrink = SKAction.fadeAlpha(to: 0, duration: 0.1)
        
        let through = SKAction.sequence([grow,shrink])
        return SKAction.repeat(through, count: 1)
        
        
    }
    
    func popWrongT() -> SKAction {
        let grow = SKAction.resize(toWidth: 200, height: 30, duration: 0.1)
        
        let shrink = SKAction.fadeAlpha(to: 0, duration: 0.5)
        
        let through = SKAction.sequence([grow,shrink])
        return SKAction.repeat(through, count: 1)
        
    }
    
    func popMoney() -> SKAction {
        
        let shrink = SKAction.resize(toWidth: 150, height: 40, duration: 0.05)
        let grow = SKAction.resize(toWidth: 160, height: 45, duration: 0.05)
        
        let blink = SKAction.sequence([grow, shrink])
        return SKAction.repeat(blink, count: 1)
    }
    
    func shakeCandidate() -> SKAction{
        
        let shrink = SKAction.rotate(byAngle: 0.1, duration: 0.2)
        let grow = SKAction.rotate(byAngle: -0.1, duration: 0.2)
        
        let blink = SKAction.sequence([grow, shrink])
        return SKAction.repeatForever(blink)
    }
    
    func shakeMedal() -> SKAction{
        
        let shrink = SKAction.rotate(byAngle: 0.1, duration: 0.1)
        let grow = SKAction.rotate(byAngle: -0.1, duration: 0.1)
        
        let blink = SKAction.sequence([grow, shrink, shrink, grow])
        return SKAction.repeatForever(blink)
    }
    
    func popNode() -> SKAction {
        
        let shrink = SKAction.resize(toWidth: 40, height: 40, duration: 0.05)
        let grow = SKAction.resize(toWidth: 50, height: 50, duration: 0.05)
        
        let blink = SKAction.sequence([grow, shrink])
        return SKAction.repeat(blink, count: 1)
    }
    
    func fadeIt() -> SKAction {
        let through = SKAction.fadeAlpha(to: 0, duration: 1)
        
        return SKAction.repeat(through, count: 1)
    }
    
    
    func up1() -> SKAction {
        
        let grow = SKAction.moveTo(y: 35, duration: 0.1)
        return SKAction.repeat(grow, count: 1)
    }
    
    func up2() -> SKAction {
        
        let grow = SKAction.moveTo(y: 40, duration: 0.1)
        return SKAction.repeat(grow, count: 1)
    }
    
    func up3() -> SKAction {
        
        let grow = SKAction.moveTo(y: view!.center.y + 230, duration: 0.1)
        return SKAction.repeat(grow, count: 1)
    }
    
    func popGO() -> SKAction {
        
        let set = SKAction.moveTo(y: view!.center.y + view!.frame.height / 1.5, duration: 0.3)
        return SKAction.repeat(set, count: 1)
    }
    
    func fadeIt2() -> SKAction {
        
        let through = SKAction.fadeAlpha(to: 0, duration: 0.1)
        return SKAction.repeat(through, count: 1)
    }
    
    func nodeShrink() -> SKAction {
        
        let shrink = SKAction.resize(toWidth: 0, height: 0, duration: 0.1)
        
        
        return SKAction.repeat(shrink, count: 1)
        
    }
    
    func rotateDial(_ speed: CGFloat, duration: Double) -> SKAction {
        
        let rotate = SKAction.resize(toWidth: CGFloat(hpCount1), duration: 0.1)
        return SKAction.repeat(rotate, count: 1)
    }
    
    //Item Animations
    //Gloves
    func rightPunch() -> SKAction {
        let set = SKAction.moveTo(x: view!.center.x + 50, duration: 0.1)
        let set2 = SKAction.moveTo(x: view!.center.x + view!.frame.width, duration: 0.1)
        
        
        let through = SKAction.sequence([set,set2])
        
        return SKAction.repeat(through, count: 1)
    }
    
    func leftPunch() -> SKAction {
        let set = SKAction.moveTo(x: view!.center.x - 50, duration: 0.1)
        let set2 = SKAction.moveTo(x: view!.center.x - view!.frame.width, duration: 0.1)
        
        
        let through = SKAction.sequence([set,set2])
        
        return SKAction.repeat(through, count: 1)
    }
    
    //Nukes
    func rightNuke() -> SKAction {
        
        let set = SKAction.move(to: CGPoint(x: view!.center.x + 50, y: view!.center.y), duration: 0.2)
        return SKAction.repeat(set, count: 1)
    }
    
    func nukeShrink() -> SKAction {
        
        let through = SKAction.resize(toWidth: 60, height: 60, duration: 0.2)
        return SKAction.repeat(through, count: 1)
    }
    
    func leftNuke() -> SKAction {
        
        let set = SKAction.move(to: CGPoint(x: view!.center.x - 50, y: view!.center.y), duration: 0.2)
        return SKAction.repeat(set, count: 1)
    }
    
    //Tomatoes
    func rightTomato() -> SKAction {
        
        let set = SKAction.move(to: CGPoint(x: view!.center.x + 50, y: view!.center.y), duration: 0.1)
        let set11 = SKAction.setTexture(SKTexture(imageNamed: "Tomatoes_Right"))
        let set2 = SKAction.fadeAlpha(to: 0, duration: 0.1)
        
        let through = SKAction.sequence([set,set11,set2])
        
        return SKAction.repeat(through, count: 1)
    }
    
    func leftTomato() -> SKAction {
        
        let set = SKAction.move(to: CGPoint(x: view!.center.x - 50, y: view!.center.y),  duration: 0.1)
        let set11 = SKAction.setTexture(SKTexture(imageNamed: "Tomatoes_Left"))
        let set2 = SKAction.fadeAlpha(to: 0, duration: 0.1)
        let through = SKAction.sequence([set,set11,set2])
        
        return SKAction.repeat(through, count: 1)
    }
    
    //Swatter
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
    
    //Fish
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
    
    func popMoneyNeeded() -> SKAction {
        
        let set = SKAction.moveTo(y: -36, duration: 0.05)
        let set2 = SKAction.moveTo(y: -40, duration: 0.05)
        
        moneyNeeded.fontColor = UIColor.yellow
        let through = SKAction.sequence([set,set2])
        
        return SKAction.repeat(through, count: 1)
    }
    
    func popMoneyChoke(){
        
        let set = SKAction.moveTo(y: -36, duration: 0.05)
        let set2 = SKAction.moveTo(y: -40, duration: 0.05)
        
        let through = SKAction.sequence([set,set2])
        
        moneyNeeded.fontColor = UIColor.red
        moneyNeeded.run(through, completion: { self.moneyNeeded.fontColor = UIColor.white
            
            self.moneyNeeded.run(through, completion: { self.moneyNeeded.fontColor = UIColor.red
                self.moneyNeeded.run(through, completion: {
                    
                    self.moneyNeeded.fontColor = UIColor.white
                })
            })
        })
    }
    
    func rotateBoom() -> SKAction {
        let chooseBoom = Int(arc4random_uniform(3))
        let set = SKAction.rotate(byAngle: CGFloat(chooseBoom), duration: 0.01)
        
        return SKAction.repeat(set, count: 1)
    }
    
    func popHeart() -> SKAction {
        
        let set = SKAction.moveTo(y: -25, duration: 0.05)
        let set2 = SKAction.moveTo(y: -45, duration: 0.05)
        let through = SKAction.sequence([set,set2])
        
        return SKAction.repeat(through, count: 1)
    }
    
    func popHeart2() -> SKAction {
        
        let set = SKAction.resize(toWidth: 70, height: 65, duration: 0.05)
        let set2 = SKAction.resize(toWidth: 60, height: 55, duration: 0.05)
        
        let through = SKAction.sequence([set,set2])
        
        return SKAction.repeat(through, count: 1)
    }
    
    func popMed() -> SKAction {
        
        let set = SKAction.resize(toWidth: 70, height: 70, duration: 0.1)
        let set2 = SKAction.resize(toWidth: 60, height: 60, duration: 0.1)
        
        let through = SKAction.sequence([set,set2])
        
        return SKAction.repeat(through, count: 1)
    }
    
    func popBackDown() -> SKAction {
        let shrink = SKAction.resize(toWidth: 30, height: 30, duration: 0.1)
        
        return SKAction.repeat(shrink, count: 1)
    }
    func popBackUp() -> SKAction {
        let shrink = SKAction.resize(toWidth: 40, height: 40, duration: 0.1)
        
        return SKAction.repeat(shrink, count: 1)
    }
    
    func moveScore() -> SKAction{
        let set = SKAction.moveTo(y: view!.center.y + 100, duration: 2)
        return SKAction.repeat(set, count: 1)
    }
    
    func moveBestScore() -> SKAction{
        let set = SKAction.moveTo(y: view!.center.y, duration: 2)
        return SKAction.repeat(set, count: 1)
    }
    
    func rotateCoin() -> SKAction {
        let set = SKAction.rotate(byAngle: -2.1, duration: 5)
        
        return SKAction.repeatForever(set)
    }
    
    func glowNode() -> SKAction {
        let set = SKAction.resize(toWidth: 45, height: 45, duration: 0.5)
        let set2 = SKAction.resize(toWidth: 40, height: 40, duration: 0.2)
        
        let through = SKAction.sequence([set,set2])
        
        return SKAction.repeatForever(through)
    }
    
    func popStartRight() -> SKAction {
        
        let set = SKAction.moveBy(x: 50, y: 0, duration: 1)
        let set2 = SKAction.moveBy(x: -50, y: 0, duration: 1)
        
        let through = SKAction.sequence([set2,set])
        
        return SKAction.repeatForever(through)
        
    }
    
    func popStartLeft() -> SKAction {
        let set = SKAction.moveBy(x: -50, y: 0, duration: 1)
        let set2 = SKAction.moveBy(x: 50, y: 0, duration: 1)
        
        let through = SKAction.sequence([set2,set])
        
        return SKAction.repeatForever(through)
        
    }
    
    func popNuke() -> SKAction {
        
        let set = SKAction.resize(toWidth: 110, height: 110 , duration: 0.1)
        let set2 = SKAction.resize(toWidth: 100, height: 100, duration: 0.1)
        
        let through = SKAction.sequence([set,set2])
        
        return SKAction.repeat(through, count: 1)
    }
    
    func popItemView() -> SKAction {
        
        let grow = SKAction.resize(toWidth: 380, height: 280, duration: 0.1)
        let shrink = SKAction.resize(toWidth: 350, height: 240, duration: 0.1)
        let through = SKAction.sequence([grow,shrink])
        
        return SKAction.repeat(through, count: 1)
        
    }
    
    func popHB() -> SKAction {
        
        let shrink = SKAction.resize(toWidth: 130, height: 40, duration: 0.1)
        
        return SKAction.repeat(shrink, count: 1)
    }
    
    func popHBUp() -> SKAction {
        
        let shrink = SKAction.resize(toWidth: 150, height: 50, duration: 0.1)
        
        return SKAction.repeat(shrink, count: 1)
    }
    
    func runSceneGo(){
        ThisGlobalScene.presentEndScene()
    }
}

//MARK: Legit Code
extension TPGameScene {
    
    func setupGamePerson(){
        
        gamePerson = TPGamePerson()
        gamePerson.setup(for: Person)
        addChild(gamePerson)
    }
    
    func setupGameItem() {
        
        print("\(Item.name)------")
        if Item.name == WeaponType.tomatoes {
            wN = 0
            coinsToAdd = WeaponCoins.tomatoes
        }
        else if Item.name == WeaponType.fish {
            wN = 1
            coinsToAdd = WeaponCoins.fish
        }
        else if Item.name == WeaponType.swatters {
            wN = 2
            coinsToAdd = WeaponCoins.swatters
        }
        else if Item.name == WeaponType.gloves {
            wN = 3
            coinsToAdd = WeaponCoins.gloves
        }
        else if Item.name == WeaponType.nukes {
            wN = 4
            coinsToAdd = WeaponCoins.nukes
        }
    }
    
    func addCoins() {
        
        Coins = Coins + coinsToAdd
        BaseViewController.shopCoinBack.coinLabel.text = BaseViewController.priceFormat(from: Coins)
        
        let coinsAddImage = SKSpriteNode(texture: SKTexture(imageNamed: "Coin"))
        coinsAddImage.size = CGSize(width: 40,height:40)
        coinsAddImage.position = CGPoint(x: MidX, y: MidY)
        addChild(coinsAddImage)
        
        let coinsAddLabel = SKLabelNode(text: "+\(Item.coinsEarned)")
        coinsAddLabel.fontName = "Helvetica-Bold"
        coinsAddLabel.fontSize = 30.0
        coinsAddLabel.fontColor = UIColor.white
        coinsAddLabel.position = CGPoint(x: 0, y: -50)
        coinsAddImage.addChild(coinsAddLabel)
        
        coinsAddImage.run(SKAction.moveTo(y: MidY + 50, duration: 0.5), completion: {
        
            coinsAddImage.run(SKAction.fadeAlpha(to: 0, duration: 0.2), completion: {
            
                coinsAddImage.removeFromParent()
            })
        })
        
    }
    
}
