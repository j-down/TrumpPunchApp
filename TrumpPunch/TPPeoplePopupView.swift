//
//  TPPeoplePopupView.swift
//  TrumpPunch
//
//  Created by Admin on 2/20/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation
import UIKit

class TPPeoplePopupView: UIView {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var faceImageView: UIImageView!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var coinView: UIImageView!
        
    var person = TPPerson()
    
    func setup(for person: TPPerson) {
        
        self.person = person
        
        center = CGPoint(x: UIScreen.main.bounds.midX,y: UIScreen.main.bounds.midY - 40)
        
        clipsToBounds = true
        layer.borderColor = UIColor.clear.cgColor // Set border color
        layer.borderWidth = 1 // Set border width
        layer.cornerRadius = 20
        alpha = 0
        
        nameLabel.text = person.name
        faceImageView.image = UIImage(named: person.name)
        
        if person.unlocked {
            
            buyButton.setBackgroundImage(UIImage(named: "BigBlueButton"), for: .normal)
            buyButton.setTitle("Punch", for: .normal)
            coinView.isHidden = true
        }
        else {
            
            if let intPrice = Int(person.price) {
                
                let price = CommaNumberFormatter.string(from: NSNumber(value: intPrice))
                buyButton.setTitle(price, for: .normal)
                coinView.isHidden = false
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
                
                if self.person.unlocked {
                    
                    Person = self.person
                    
                    BaseViewController.setPerson(person: Person)
                    trackFirebase(for: "SelectedPerson\(Person.name)")
                    ThisGlobalScene.presentGameScene()
                }
                else {
                    
                    BaseViewController.purchase(person: self.person)
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
        
        buyButton.setTitle("Punch", for: .normal)
        buyButton.setBackgroundImage(UIImage(named: "BigBlueButton"), for: .normal)
        coinView.alpha = 0
    }
    
}
