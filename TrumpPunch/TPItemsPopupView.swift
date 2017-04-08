//
//  TPItemsPopupView.swift
//  TrumpPunch
//
//  Created by Admin on 2/20/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation
import UIKit

class TPItemsPopupView: UIView {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var rightItemImageView: UIImageView!
    @IBOutlet weak var leftItemImageView: UIImageView!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var coinImageView: UIImageView!
    
    var item = TPItem()
    
    func setup(for item: TPItem) {
    
        center = CGPoint(x: UIScreen.main.bounds.midX,y: UIScreen.main.bounds.midY - 40)
        
        clipsToBounds = true
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 20
        alpha = 0
    
        self.item = item
        
        rightItemImageView.image = UIImage(named: "\(item.name)_Right")
        leftItemImageView.image = UIImage(named: "\(item.name)_Left")
        
        nameLabel.text = item.name
        descriptionLabel.text = "\(item.coinsEarned) coins per combo"
        
        if item.unlocked {
            
            buyButton.setBackgroundImage(UIImage(named: "BigBlueButton"), for: .normal)
            buyButton.setTitle("Use", for: .normal)
            coinImageView.isHidden = true
        }
        else {
            
            if let intPrice = Int(item.price) {
                
                let price = CommaNumberFormatter.string(from: NSNumber(value: intPrice))
                buyButton.setTitle(price, for: .normal)
                coinImageView.isHidden = false
            }
        }
        
        let buyButtonTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(buyButtonPressed(gesture:)))
        buyButtonTapGesture.minimumPressDuration = 0
        
        buyButton.isUserInteractionEnabled = true
        buyButton.addGestureRecognizer(buyButtonTapGesture)
    }
    
    func buyButtonPressed(gesture: UITapGestureRecognizer) {
        
        if gesture.state == .ended {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
                self.buyButton.transform = CGAffineTransform.identity
            }, completion: { finished in
                
                if self.item.unlocked {
                    
                    Item = self.item
                    
                    trackFirebase(for: "SelectedItem\(Item.name)")
                    BaseViewController.setItem(item: Item)
                    ThisGlobalScene.presentGameScene()
                }
                else {
                    
                    BaseViewController.purchase(item: self.item)
                }
                
            })
        }
        else if gesture.state == .began {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
                self.buyButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
        }
        
    }
    
    func completePurchase() {
        
        buyButton.setTitle("Use", for: .normal)
        buyButton.setBackgroundImage(UIImage(named: "BigBlueButton"), for: .normal)
        coinImageView.alpha = 0
    }
}
