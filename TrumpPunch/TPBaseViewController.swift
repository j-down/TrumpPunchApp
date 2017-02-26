//
//  GameViewController.swift
//  TrumpPunch
//
//  Created by Admin on 2/20/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class TPBaseViewController: UIViewController, UIScrollViewDelegate {

    //HomeScene
    var homeSceneBottomView: TPHomeSceneBottomView!
    var homeSceneLogoView: UIImageView!
    
    //Shop
    var shopTopView: TPShopTopView!
    var shopBackground: UIView!
    var shopPopupBackground: UIView!
    var shopCoinBack: TPCoinBack!
    
    var peopleView: TPPeopleView!
    var peoplePopupView: TPPeoplePopupView!
    var itemsView: TPItemsView!
    var itemsPopupView: TPItemsPopupView!
    var storeView: TPStoreView!
    var inItemPopup: Bool = false
    var inPersonPopup: Bool = false
    
    var scrollView: UIScrollView!
    var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var pageControl : UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTesting()
        setup()
    }
    
    func setup() {
        
        if Defaults.integer(forKey: "HasDoneFirstLaunch") == 0 {
            setupFirstLaunch()
        }
        
        BaseViewController = self
        CommaNumberFormatter.numberStyle = .decimal
        
        setupUI()
        setupData()
    }
    
    func setupUI() {
        
        setupScene()
        setupShop()
    }
    
    func setupData() {
        
        setupCoins()
        setupPeople()
        setupItems()
        setupSound()
        setupMusic()
    }
    
    func setupScene() {
        
        let skView = self.view as! SKView
        skView.isMultipleTouchEnabled = false
        
        let homeScene = TPHomeScene(size: skView.bounds.size)
        homeScene.scaleMode = .aspectFill
        skView.presentScene(homeScene)
    }
    
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

 }

//MARK: DataModel
extension TPBaseViewController {
    
    func setupPeople() {
        
        if let savedPeople = savedPeople() {
            
            People = savedPeople
        }
        else {
            
            let person1 = TPPerson(name: "Donald Trump", price: "0", body: "Body1", unlocked: true)
            let person2 = TPPerson(name: "Mike Pence", price: "40000", body: "Body1", unlocked: false)
            let person3 = TPPerson(name: "Hillary Clinton", price: "30000", body: "Body1", unlocked: false)
            let person4 = TPPerson(name: "Bernie Sanders", price: "30000", body: "Body1", unlocked: false)
            let person5 = TPPerson(name: "Soulja Boy", price: "30000", body: "Body1", unlocked: false)
            let person6 = TPPerson(name: "Justin Bieber", price: "30000", body: "Body1", unlocked: true)
            let person7 = TPPerson(name: "PewDiePie", price: "100000", body: "Body1", unlocked: false)
            let person8 = TPPerson(name: "Kanye West", price: "250000", body: "Body1", unlocked: false)
            let person9 = TPPerson(name: "Kim Kardashian", price: "500000", body: "Body1", unlocked: false)
            
            People = [person1, person2, person3, person4, person5, person6, person7, person8, person9]
            Person = person1
            
            savePeople()
        }
    }
    
    func savePeople() {
        
        let isSuccess = NSKeyedArchiver.archiveRootObject(People, toFile: TPPerson.ArchiveURL.path)
        
        if !isSuccess {
            
            print("FAILED")
        }
    }
    
    func savedPeople() -> [TPPerson]? {
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: TPPerson.ArchiveURL.path) as? [TPPerson]
    }
    
    func setupItems() {
        
        if let savedItems = savedItems() {
            
            Items = savedItems
        }
        else {
            
            let item1 = TPItem(name: "Tomatoes", price: "0", coinsEarned: "100", unlocked: true)
            let item2 = TPItem(name: "Fish", price: "0", coinsEarned: "100", unlocked: false)
            let item3 = TPItem(name: "Swatters", price: "0", coinsEarned: "100", unlocked: false)
            let item4 = TPItem(name: "Gloves", price: "0", coinsEarned: "100", unlocked: false)
            let item5 = TPItem(name: "Pans", price: "0", coinsEarned: "100", unlocked: false)
            let item6 = TPItem(name: "Nukes", price: "0", coinsEarned: "100", unlocked: false)
            
            Items = [item1, item2, item3, item4, item5, item6]
            Item = item1
            
            saveItems()
        }
    }
    
    func saveItems() {
        
        let _ = NSKeyedArchiver.archiveRootObject(Items, toFile: TPItem.ArchiveURL.path)
    }
    
    func savedItems() -> [TPItem]? {
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: TPItem.ArchiveURL.path) as? [TPItem]
    }
    
    func setupCoins() {
        
        Coins = Defaults.integer(forKey: "Coins")
    }
    
    func saveCoins() {
        
        Defaults.set(Coins, forKey: "Coins")
    }
    
    func setupSound() {
        
        Sound = Defaults.bool(forKey: "Sound")
        
        if Sound {
            
            homeSceneBottomView.soundOffView.alpha = 0
        }
        else {
            homeSceneBottomView.soundOffView.alpha = 1
        }
    }
    
    func setupMusic() {
        
        Music = Defaults.bool(forKey: "Music")
        
        if Music {
            
            makeMusic(playing: Music)
            homeSceneBottomView.musicOffView.alpha = 0
        }
        else {
            
            homeSceneBottomView.musicOffView.alpha = 1
        }
    }
    
    func setupFirstLaunch() {
        
        if Defaults.integer(forKey: "HasDoneFirstLaunch") == 0 {
            
            Defaults.set(1, forKey: "HasDoneFirstLaunch")
            
            Defaults.set(true, forKey: "Music")
            Defaults.set(true, forKey: "Sound")
        }
    }
    
    func setupTesting() {
        
        Defaults.set(1000000, forKey: "Coins")
    }
    
    func makeMusic(playing choice: Bool) {
        
        let path = Bundle.main.path(forResource: "AppMusic.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            BackgroundMusic = try AVAudioPlayer(contentsOf: url)
            
            if choice {
                
                BackgroundMusic.numberOfLoops = -1
                BackgroundMusic.play()
                
            }
            else {
                
                BackgroundMusic.numberOfLoops = 0
                BackgroundMusic.volume = 0
                BackgroundMusic.stop()
            }
            
        } catch {
            print(error)
        }
    }
    
}

//MARK: Shop
extension TPBaseViewController {
    
    func setupShop() {
    
        setupShopBackgrounds()
        setupShopTopView()
        setupShopCoinBack()
        
        setupShopPeople()
        setupShopItems()
        setupShopStore()
    }
    
    func presentShop() {
    
        CurrentPage = InShop
        
        shopTopView.isHidden = false
        shopCoinBack.isHidden = false
        shopBackground.isHidden = false
        
        shopTopView.peopleLabel.textColor = UIColor.init(red: 0.0/255.0, green: 64.0/255.0, blue: 128.0/255.0, alpha: 1)
        shopTopView.storeLabel.textColor = UIColor.gray
        shopTopView.itemsLabel.textColor = UIColor.gray
        
        setupShopScrollView()
        presentShopScrollView()
    }
    
    func removeShop() {
        
        shopTopView.isHidden = true
        shopBackground.isHidden = true
        shopPopupBackground.isHidden = true
        shopCoinBack.isHidden = true
        
        removeScrollView()
        
        CurrentPage = "None"
    }
    
    func setupShopBackgrounds() {
        
        shopBackground = UIView(frame: CGRect(x: MidX, y: MidY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        shopBackground.center = CGPoint(x: MidX, y: MidY)
        shopBackground.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        shopBackground.isHidden = true
        view.addSubview(shopBackground)
        
        shopPopupBackground = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        shopPopupBackground.center = CGPoint(x: MidX, y: MidY)
        shopPopupBackground.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.addSubview(shopPopupBackground)
        
        shopPopupBackground.isHidden = true
        shopPopupBackground.alpha = 0
        
        let shopPopupBackgroundTapGesture = UITapGestureRecognizer(target: self, action: #selector(shopPopupBackgroundPressed))
        shopPopupBackground.isUserInteractionEnabled = true
        shopPopupBackground.addGestureRecognizer(shopPopupBackgroundTapGesture)
    }
    
    func setupShopTopView() {
        
        shopTopView = Bundle.main.loadNibNamed("TPShopTopView", owner: self, options: [:])?[0] as! TPShopTopView
        
        shopTopView.frame = CGRect(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY, width: UIScreen.main.bounds.width, height: 110)
        shopTopView.center = CGPoint(x: UIScreen.main.bounds.midX,y: UIScreen.main.bounds.midY - UIScreen.main.bounds.height / 2 + shopTopView.frame.height / 2)
        shopTopView.isHidden = true
        shopTopView.isUserInteractionEnabled = true
        view.addSubview(shopTopView)
        
        let shopExitTapGesture = UITapGestureRecognizer(target: self, action: #selector(removeShop))
        shopTopView.exitButton.isUserInteractionEnabled = true
        shopTopView.exitButton.addGestureRecognizer(shopExitTapGesture)
        
        let shopPeopleTapGesture = UITapGestureRecognizer(target: self, action: #selector(moveShopToPeople))
        shopTopView.peopleLabel.isUserInteractionEnabled = true
        shopTopView.peopleLabel.addGestureRecognizer(shopPeopleTapGesture)
        
        let shopItemsTapGesture = UITapGestureRecognizer(target: self, action: #selector(moveShopToItems))
        shopTopView.itemsLabel.isUserInteractionEnabled = true
        shopTopView.itemsLabel.addGestureRecognizer(shopItemsTapGesture)
        
        let shopStoreTapGesture = UITapGestureRecognizer(target: self, action: #selector(moveShopToStore))
        shopTopView.storeLabel.isUserInteractionEnabled = true
        shopTopView.storeLabel.addGestureRecognizer(shopStoreTapGesture)
    }
    
    func moveShopToPeople() {
        
        shopTopView.peopleLabel.textColor = UIColor.init(red: 0.0/255.0, green: 64.0/255.0, blue: 128.0/255.0, alpha: 1)
        shopTopView.storeLabel.textColor = UIColor.gray
        shopTopView.itemsLabel.textColor = UIColor.gray
    }
    
    func moveShopToItems() {
        
        shopTopView.itemsLabel.textColor = UIColor.init(red: 0.0/255.0, green: 64.0/255.0, blue: 128.0/255.0, alpha: 1)
        shopTopView.storeLabel.textColor = UIColor.gray
        shopTopView.peopleLabel.textColor = UIColor.gray
    }
    
    func moveShopToStore() {
        
        shopTopView.storeLabel.textColor = UIColor.init(red: 0.0/255.0, green: 64.0/255.0, blue: 128.0/255.0, alpha: 1)
        shopTopView.peopleLabel.textColor = UIColor.gray
        shopTopView.itemsLabel.textColor = UIColor.gray
        
    }
    
    func setupShopCoinBack() {
        
        shopCoinBack = Bundle.main.loadNibNamed("TPCoinBack", owner: self, options: [:])?[0] as! TPCoinBack
        
        shopCoinBack.center = CGPoint(x: MidX,y: UIScreen.main.bounds.midY + UIScreen.main.bounds.height / 2 - shopCoinBack.frame.height / 2 - 100 )
        shopCoinBack.isHidden = true
        shopCoinBack.backgroundColor = UIColor.clear
        view.addSubview(shopCoinBack)
        
        shopCoinBack.coinLabel.text = CommaNumberFormatter.string(from: NSNumber(value: Defaults.integer(forKey: "Coins")))
        
    }
    
    func setupShopPeople() {
        
        peopleView = Bundle.main.loadNibNamed("TPPeopleView", owner: self, options: [:])?[0] as! TPPeopleView
        
        peopleView.setup()
    }
    
    func setupShopItems() {
        
        itemsView = Bundle.main.loadNibNamed("TPItemsView", owner: self, options: [:])?[0] as! TPItemsView
        
        itemsView.frame = CGRect(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY + 40, width: UIScreen.main.bounds.width, height: 440)
        itemsView.center = CGPoint(x: UIScreen.main.bounds.midX,y: UIScreen.main.bounds.midY - 40)
        
        itemsView.setup()
    }
    
    func setupShopStore() {
        
        storeView = Bundle.main.loadNibNamed("TPStoreView", owner: self, options: [:])?[0] as! TPStoreView
        
        storeView.frame = CGRect(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY + 40, width: UIScreen.main.bounds.width, height: 440)
        storeView.center = CGPoint(x: UIScreen.main.bounds.midX,y: UIScreen.main.bounds.midY - 40)
        
        storeView.setup()
    }
    
    func shopPopupBackgroundPressed(gesture: UITapGestureRecognizer) {
        
        removePopup()
    }
    
    func removePopup() {
        
        shopPopupBackground.isHidden = true
        shopPopupBackground.alpha = 0
        
        if inPersonPopup {
            
            removePeoplePopup()
        }
        else if inItemPopup {
            
            removeItemsPopup()
        }
    }
    
    //MARK: ScrollView
    func setupShopScrollView() {
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.25))
        scrollView.center = CGPoint(x: MidX, y: MidY)
        
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.midY * 1.8, width: UIScreen.main.bounds.width, height: 50))
        
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor.clear
        pageControl.currentPageIndicatorTintColor = UIColor.clear
        pageControl.alpha = 0
    }
    
    func presentShopScrollView() {
        
        view.addSubview(pageControl)
        
        scrollView.delegate = self
        scrollView.isUserInteractionEnabled = true
        view.addSubview(scrollView)
        view.bringSubview(toFront: shopCoinBack)
        
        for index in 0..<3 {
            
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            
            scrollView.isPagingEnabled = true
            
            if index == 0 {
                
                peopleView.frame = frame
                scrollView.addSubview(peopleView)
            }
            else if index == 1 {
                
                itemsView.frame = frame
                scrollView.addSubview(itemsView)
            }
            else if index == 2{
                
                storeView.frame = frame
                scrollView.addSubview(storeView)
            }
            
            scrollView.showsHorizontalScrollIndicator = false
        }
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * 3, height: scrollView.frame.size.height)
        pageControl.addTarget(self, action: #selector(TPBaseViewController.changePage(_:)), for: UIControlEvents.valueChanged)
    }
    
    func changePage(_ sender: AnyObject) -> () {
        
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
        print(String(describing: pageNumber))
        
        if pageNumber == 0.0  {
            
            moveShopToPeople()
        }
        else if pageNumber == 1.0{
            
            moveShopToItems()
        }
        else if pageNumber == 2.0  {
            
            moveShopToStore()
        }
        
    }
    
    func removeScrollView() {
        
        pageControl.removeFromSuperview()
        scrollView.removeFromSuperview()
    }
    
    func presentPopupFor(person: TPPerson) {
        
        inPersonPopup = true
        
        peoplePopupView = Bundle.main.loadNibNamed("TPPeoplePopupView", owner: self, options: [:])?[0] as! TPPeoplePopupView
        
        peoplePopupView.setup(for: person)
        
        presentShopPopupBackground()
        
        view.addSubview(peoplePopupView)
        
        UIView.animate(withDuration: 0.3, delay: 0, animations: {
            
            self.peoplePopupView.transform = CGAffineTransform(translationX: 0, y: -10)
            self.peoplePopupView.alpha = 1
            
        }, completion: { finished in
            
            UIView.animate(withDuration: 0.3, delay: 0, animations: {
                
                self.peoplePopupView.transform = CGAffineTransform(translationX: 0, y: 2)
                
            })
        })
    }
    
    func presentShopPopupBackground() {
        
        shopPopupBackground.isHidden = false
        UIView.animate(withDuration: 0.2, animations: {
            
            self.shopPopupBackground.alpha = 1
            
        })
        
        view.bringSubview(toFront: shopPopupBackground)
    }
    
    func removePeoplePopup() {
        
        peoplePopupView.removeFromSuperview()
    }
    
    func presentPopupFor(item: TPItem) {
        
        inItemPopup = true
        
    }
    
    func removeItemsPopup() {
        
        inItemPopup = false
        
    }
}

//MARK: ButtonActions
extension TPBaseViewController {
    
    func openShop() {
        
        if CurrentPage != InShop {
            
            presentShop()
        }
    }
    
    func toggleMusic() {
        
        if Music {
            
            homeSceneBottomView.musicOffView.alpha = 1
            Music = false
        }
        else {
            
            homeSceneBottomView.musicOffView.alpha = 0
            Music = true
        }
        
        makeMusic(playing: Music)
        Defaults.set(Music, forKey: "Music")
    }
    
    func toggleSound() {
        
        if Sound {
            
            homeSceneBottomView.soundOffView.alpha = 1
            Sound = false
        }
        else {
            
            homeSceneBottomView.soundOffView.alpha = 0
            Sound = true
        }
        
        Defaults.set(Sound, forKey: "Sound")
    }
    
    func openLocation() {
        
        presentLocationView()
    }
    
    func playGame() {
        
        //Present GameScene
    }
}

//MARK: CoinPurchases
extension TPBaseViewController {
    
    func purchase(person: TPPerson) {
        
        if let price = Int(person.price) {
            
            if Coins > price {
                
                Coins = Coins - price
                
                for i in People {
                    
                    if i.name == person.name {
                        
                        i.unlocked = true
                    }
                }
                
                shopCoinBack.coinLabel.text = CommaNumberFormatter.string(from: NSNumber(value: Coins))
                
                peoplePopupView.completePurchase()
                
                savePeople()
            }
            else {
                
                //Go to Store
            }
        }
        
    }
    
    func purchase(item: TPItem) {
        
        if let price = Int(item.price) {
            
            if Coins > price {
                
                Coins = Coins - price
                
                Defaults.set(Coins, forKey: "Coins")
                
                for i in Items {
                    
                    if i.name == item.name {
                        
                        i.unlocked = true
                    }
                }
                
                saveItems()
            }
            else {
                
                //Go to Store
            }
        }
        
    }
}

//MARK: Location
extension TPBaseViewController {
    
    func presentLocationView() {
        //TODO: Add Location
        self.performSegue(withIdentifier: "showLocationPage", sender: nil)
    }
}

