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
import Firebase
import FirebaseCore
import GoogleMobileAds

class TPBaseViewController: UIViewController {

    @IBOutlet var logoutButtonView : UIView!
    @IBOutlet var logoutButton : UIButton!
    @IBOutlet var logoutLabel : UILabel!
    
    //HomeScene
    var homeSceneBottomView: TPHomeSceneBottomView!
    var homeSceneLogoView: UIImageView!
    
    //EndScene
    var endSceneBottomView: TPEndSceneBottomView!
    var endSceneTopView: TPEndSceneTopView!
    var endSceneMiddleView: TPEndSceneMiddleView!
    var shareImageView: UIImageView!
    
    //Shop
    var shopTopView: TPShopTopView!
    var shopBackground: UIView!
    var shopPopupBackground: UIView!
    var shopCoinBack: TPCoinBack!
    
    var shopSegmentedControl: UISegmentedControl!
    
    var peopleView: TPPeopleView!
    var peoplePopupView: TPPeoplePopupView!
    var itemsView: TPItemsView!
    var itemsPopupView: TPItemsPopupView!
    var storeView: TPStoreView!
    var inItemPopup: Bool = false
    var inPersonPopup: Bool = false
    
    //Ads
    @IBOutlet weak var bannerView: GADBannerView!
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        
        if Defaults.integer(forKey: DefaultType.firstLaunch) == 0 {
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
        setupIAP()
        setupPeople()
        setupItems()
        setupSound()
        setupMusic()
        setupAds()
    }
    
    func setupScene() {
        
        let skView = self.view as! SKView
        skView.isMultipleTouchEnabled = false
        
        ThisGlobalScene = TPGlobalScene()
        ThisHomeScene = TPHomeScene(size: skView.bounds.size)
        ThisHomeScene.scaleMode = .aspectFill
        ThisGlobalScene = ThisHomeScene
        skView.presentScene(ThisHomeScene)
    }
    
    func setPerson(person: TPPerson) {
        
        for i in People {
            
            if i.name == person.name {
                
                i.current = true
            }
            else {
                
                i.current = false
            }
        }
        
        savePeople()
    }
    
    func lastPerson() -> TPPerson {
        
        for i in People {
            
            if i.current {
                
                return i
            }
        }
        
        return People[0]
    }
    
    func setItem(item: TPItem) {
        
        for i in Items {
            
            if i.name == item.name {
                
                i.current = true
            }
            else {
                
                i.current = false
            }
        }
        
        saveItems()
    }
    
    func lastItem() -> TPItem {
        
        for i in Items {
            
            if i.current {
                
                return i
            }
        }
        
        return Items[0]
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
    
    @IBAction func logoutButtonPressed() {
        self.confirmLogout()
    }
    
    func confirmLogout () {
        let alert = UIAlertController(title: "You are about to Logout.", message: "Are you sure you would like to log out?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .default) { (action) in
            
            FIRAuth.auth()?.currentUser?.logout()
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        alert.addAction(yes)
        self.present(alert, animated: true, completion: nil)
    }
    
 }

//MARK: DataModel
extension TPBaseViewController {
    
    func setupPeople() {
        
        if let savedPeople = savedPeople() {
            
            People = savedPeople
            Person = lastPerson()
        }
        else {
            
            let person1 = TPPerson(name: "Donald Trump", price: "0", body: "Suit1", unlocked: true, current: true)
            let person2 = TPPerson(name: "Hillary Clinton", price: "5000", body: "Dress1", unlocked: false)
            let person3 = TPPerson(name: "Martin Shkreli", price: "10000", body: "Suit2", unlocked: false)
            let person4 = TPPerson(name: "Bernie Sanders", price: "20000", body: "Suit2", unlocked: false)
            let person5 = TPPerson(name: "Miley Cyrus", price: "30000", body: "Dress2", unlocked: false)
            let person6 = TPPerson(name: "Justin Bieber", price: "50000", body: "Suit2", unlocked: false)
            let person7 = TPPerson(name: "PewDiePie", price: "100000", body: "Suit1", unlocked: false)
            let person8 = TPPerson(name: "Kanye West", price: "250000", body: "Suit2", unlocked: false)
            let person9 = TPPerson(name: "Kim Kardashian", price: "500000", body: "Dress2", unlocked: false)
            
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
            Item = lastItem()
        }
        else {
            
            let item1 = TPItem(name: WeaponType.tomatoes, price: "0", coinsEarned: String(WeaponCoins.tomatoes), unlocked: true, current: true)
            let item2 = TPItem(name: WeaponType.fish, price: "1000", coinsEarned: String(WeaponCoins.fish), unlocked: false)
            let item3 = TPItem(name: WeaponType.swatters, price: "10000", coinsEarned: String(WeaponCoins.swatters), unlocked: false)
            let item4 = TPItem(name: WeaponType.gloves, price: "100000", coinsEarned: String(WeaponCoins.gloves), unlocked: false)
            let item5 = TPItem(name: WeaponType.nukes, price: "250000", coinsEarned: String(WeaponCoins.nukes), unlocked: false)
            
            Items = [item1, item2, item3, item4, item5]
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
        
        Coins = Defaults.integer(forKey: DefaultType.coins)
        
        if Debug {
            Coins = 1000000
        }
    }
    
    func saveCoins() {
        
        Defaults.set(Coins, forKey: DefaultType.coins)
    }
    
    func setupSound() {
        
        Sound = Defaults.bool(forKey: DefaultType.sound)
        
        if Sound {
            
            homeSceneBottomView.soundOffView.alpha = 0
        }
        else {
            homeSceneBottomView.soundOffView.alpha = 1
        }
    }
    
    func setupMusic() {
        
        Music = Defaults.bool(forKey: DefaultType.music)
        
        if Music {
            
            makeMusic(playing: Music)
            homeSceneBottomView.musicOffView.alpha = 0
        }
        else {
            
            homeSceneBottomView.musicOffView.alpha = 1
        }
    }
    
    func setupFirstLaunch() {
        
        if Defaults.integer(forKey: DefaultType.firstLaunch) == 0 {
            
            Defaults.set(1, forKey: DefaultType.firstLaunch)
            
            Defaults.set(true, forKey: DefaultType.music)
            Defaults.set(true, forKey: DefaultType.sound)
            
            trackFirebase(for: "NewUser")
        }
    }
    
    
    func makeMusic(playing choice: Bool) {
        
        if let path = Bundle.main.url(forResource: Sounds.background, withExtension: "mp3") {
            
            do {
                BackgroundMusic = try AVAudioPlayer(contentsOf: path)
                
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
    
        trackFirebase(for: "Shop")
        
        CurrentPage = InShop
        
        shopTopView.isHidden = false
        shopCoinBack.isHidden = false
        shopBackground.isHidden = false
        
        peopleView.isHidden = false
        itemsView.isHidden = true
        storeView.isHidden = true
        
        view.addSubview(peopleView)
        view.addSubview(itemsView)
        view.addSubview(storeView)
        
        itemsView.isHidden = true
        storeView.isHidden = true
        
        shopTopView.segmentedControl.selectedSegmentIndex = 0
        shopTopView.segmentedControl.isUserInteractionEnabled = true
        
        view.bringSubview(toFront: shopBackground)
        view.bringSubview(toFront: itemsView)
        view.bringSubview(toFront: peopleView)
        view.bringSubview(toFront: storeView)
        view.bringSubview(toFront: shopCoinBack)
        view.bringSubview(toFront: shopTopView)
        
        shopCoinBack.center = CGPoint(x: MidX,y: UIScreen.main.bounds.midY + UIScreen.main.bounds.height / 2 - shopCoinBack.frame.height / 2 - 40 )
    }
    
    func removeShop() {
        
        removePopup()
        
        shopTopView.isHidden = true
        shopBackground.isHidden = true
        shopPopupBackground.isHidden = true
        
        if CurrentScene == SceneType.homeScene {
            shopCoinBack.isHidden = true
        }
        else {
            shopCoinBack.center = CGPoint(x: MidX,y: UIScreen.main.bounds.midY + UIScreen.main.bounds.height / 2 - BaseViewController.shopCoinBack.frame.height / 2 - 200 )
        }
        
        CurrentPage = "None"
        
        peopleView.removeFromSuperview()
        itemsView.removeFromSuperview()
        storeView.removeFromSuperview()
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
        
        shopTopView.setup()
        
        let shopExitTapGesture = UITapGestureRecognizer(target: self, action: #selector(removeShop))
        shopTopView.exitButton.isUserInteractionEnabled = true
        shopTopView.exitButton.addGestureRecognizer(shopExitTapGesture)
        
        view.addSubview(shopTopView)
        
        shopTopView.segmentedControl.addTarget(self, action: #selector(shopSegmentAction(_:)), for: .valueChanged)
        
    }
    
    func shopSegmentAction(_ sender: UISegmentedControl!) {
        
        print("Pressed \(sender.selectedSegmentIndex)")
        
        switch sender.selectedSegmentIndex {
            
        case 0:
            moveShopToPeople()
        case 1:
            moveShopToItems()
        case 2:
            moveShopToStore()
        default:
            moveShopToPeople()
        }
    }
    
    func moveShopToPeople() {
        
        trackFirebase(for: "ShopPeople")
        
        peopleView.isHidden = false
        itemsView.isHidden = true
        storeView.isHidden = true
    }
    
    func moveShopToItems() {
        
        trackFirebase(for: "ShopItems")
        
        peopleView.isHidden = true
        itemsView.isHidden = false
        storeView.isHidden = true
    }
    
    func moveShopToStore() {
        
        trackFirebase(for: "ShopStore")
        
        peopleView.isHidden = true
        itemsView.isHidden = true
        storeView.isHidden = false
    }
    
    func setupShopCoinBack() {
        
        shopCoinBack = Bundle.main.loadNibNamed("TPCoinBack", owner: self, options: [:])?[0] as! TPCoinBack
        
        shopCoinBack.center = CGPoint(x: MidX,y: UIScreen.main.bounds.midY + UIScreen.main.bounds.height / 2 - shopCoinBack.frame.height / 2 - 100 )
        shopCoinBack.isHidden = true
        shopCoinBack.backgroundColor = UIColor.clear
        view.addSubview(shopCoinBack)
        
        let shopCoinBackGesture = UITapGestureRecognizer(target: self, action: #selector(moveShopToStore))
        shopCoinBack.isUserInteractionEnabled = true
        shopCoinBack.addGestureRecognizer(shopCoinBackGesture)
        
        Coins = Defaults.integer(forKey: DefaultType.coins)
        
        shopCoinBack.coinLabel.text = priceFormat(from: Coins)
        
    }
    
    func presentShopCoinBack() {
        
        view.addSubview(shopCoinBack)
        shopCoinBack.isHidden = false
    }
    
    func setupShopPeople() {
        
        peopleView = Bundle.main.loadNibNamed("TPPeopleView", owner: self, options: [:])?[0] as! TPPeopleView
        peopleView.setup()
    }
    
    func setupShopItems() {
        
        itemsView = Bundle.main.loadNibNamed("TPItemsView", owner: self, options: [:])?[0] as! TPItemsView
        itemsView.setup()
    }
    
    func setupShopStore() {
        
        storeView = Bundle.main.loadNibNamed("TPStoreView", owner: self, options: [:])?[0] as! TPStoreView
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
        
        inPersonPopup = false
        peoplePopupView.removeFromSuperview()
    }
    
    func presentPopupFor(item: TPItem) {
        
        inItemPopup = true
        
        itemsPopupView = Bundle.main.loadNibNamed("TPItemsPopupView", owner: self, options: [:])?[0] as! TPItemsPopupView
        
        itemsPopupView.setup(for: item)
        
        presentShopPopupBackground()
        
        view.addSubview(itemsPopupView)
        
        UIView.animate(withDuration: 0.3, delay: 0, animations: {
            
            self.itemsPopupView.transform = CGAffineTransform(translationX: 0, y: -10)
            self.itemsPopupView.alpha = 1
            
        }, completion: { finished in
            
            UIView.animate(withDuration: 0.3, delay: 0, animations: {
                
                self.itemsPopupView.transform = CGAffineTransform(translationX: 0, y: 2)
                
            })
        })
        
    }
    
    func removeItemsPopup() {
        
        inItemPopup = false
        itemsPopupView.removeFromSuperview()
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
        
        trackFirebase(for: "MusicTurned\(Music.description)")
        makeMusic(playing: Music)
        Defaults.set(Music, forKey: DefaultType.music)
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
        
        trackFirebase(for: "SoundTurned\(Sound.description)")
        Defaults.set(Sound, forKey: DefaultType.sound)
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
                        trackFirebase(for: "Buy_\(person.name)")
                    }
                }
                
                shopCoinBack.coinLabel.text = priceFormat(from: Coins)
                
                peoplePopupView.completePurchase()
                peopleView.collectionView.reloadData()
                
                savePeople()
                saveCoins()
            }
            else {
                
                trackFirebase(for: "TriedToBuy_\(person.name)")
                removePopup()
                shopTopView.segmentedControl.selectedSegmentIndex = 2
                moveShopToStore()
            }
        }
        
    }
    
    func purchase(item: TPItem) {
        
        if let price = Int(item.price) {
            
            if Coins > price {
                
                Coins = Coins - price
                
                Defaults.set(Coins, forKey: DefaultType.coins)
                
                for i in Items {
                    
                    if i.name == item.name {
                        
                        i.unlocked = true
                        trackFirebase(for: "Buy_\(item.name)")
                    }
                }
                
                shopCoinBack.coinLabel.text = priceFormat(from: Coins)
                
                itemsPopupView.completePurchase()
                itemsView.collectionView.reloadData()
                
                saveItems()
                saveCoins()
            }
            else {
                
                trackFirebase(for: "TriedToBuy_\(item.name)")
                removePopup()
                shopTopView.segmentedControl.selectedSegmentIndex = 2
                moveShopToStore()
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

//MARK: IAP
extension TPBaseViewController {
    
    func setupIAP() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(TPBaseViewController.handlePurchaseNotification(_:)),
                                               name: NSNotification.Name(rawValue: IAPHelper.IAPHelperPurchaseNotification),
                                               object: nil)

    }
    
    func handlePurchaseNotification(_ notification: Notification) {
        
        guard let productID = notification.object as? String else { return }
        
        for (_, product) in Products.enumerated() {
            
            guard product.productIdentifier == productID else { continue }
            
            addCoins(for: product.productIdentifier)
        }
    }
    
    func addCoins(for product: String) {
        
        if product == TPProducts.PileOfCoins {
            
            Coins = Coins + TPProducts.PileOfCoinsPrize
        }
        else if product == TPProducts.BagOfCoins {
            
            Coins = Coins + TPProducts.BagOfCoinsPrize
        }
        else if product == TPProducts.ChestOfCoins {
            
            Coins = Coins + TPProducts.ChestOfCoinsPrize
        }
        else if product == TPProducts.SmallLoanOfCoins {
            
            Coins = Coins + TPProducts.SmallLoanOfCoinsPrize
        }
        
        trackFirebase(for: "Purchased_\(product)")
        
        saveCoins()
        shopCoinBack.coinLabel.text = priceFormat(from: Coins)
    }
    
    func priceFormat(from price: Int) -> String {
        
        if let priceString = CommaNumberFormatter.string(from: NSNumber(value: price)) {
            
            return priceString
        }
        
        return "0"
    }
    
}

//MARK: Ads
extension TPBaseViewController: GADInterstitialDelegate  {
    
    func setupAds() {
        
        bannerView.adUnitID = "ca-app-pub-3779823216194929/9794925099"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        interstitial = getNewInterstitial()
    }
    
    func loadIntertisial() {
        
        if interstitial != nil {
            
            if interstitial.isReady  {
                
                interstitial.present(fromRootViewController: BaseViewController)
            }
        }
    }
    
    func getNewInterstitial() -> GADInterstitial {
        
        let request = GADRequest()
        let interstitialAd = GADInterstitial(adUnitID: "ca-app-pub-3779823216194929/3288949893")
        interstitialAd.delegate = self
        interstitialAd.load(request)
        
        return interstitialAd
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        
        interstitial = getNewInterstitial()
    }
    
}

//MARK: Sharing
extension TPBaseViewController {
    
    func shareScore() {
        
        let shareViewController = UIActivityViewController(activityItems: ["I just punched \(Person.name) in the face with \(Item.name) and scored \(Score) in the game #TrumpPunch - iTunes.apple.com/app/id1082962819"], applicationActivities: nil)
        
        shareViewController.excludedActivityTypes = [UIActivityType.postToFlickr,UIActivityType.mail,UIActivityType.print,UIActivityType.copyToPasteboard]
        
        BaseViewController.present(shareViewController, animated: true, completion: nil)
    }
}
