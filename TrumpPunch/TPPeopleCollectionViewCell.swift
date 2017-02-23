//
//  TPPeopleCollectionViewCell.swift
//  TrumpPunch
//
//  Created by Admin on 2/21/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation
import UIKit

class TPPeopleCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var personBackImageView: UIImageView!
    
    @IBOutlet weak var personFaceImageView: UIImageView!
    
    var person = TPPerson()
    
    func setup(for person: TPPerson) {
    
        self.person = person
        backgroundColor = UIColor.clear
        
        let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(cellTapped(gesture:)))
        tapGesture.minimumPressDuration = 0
        
        isUserInteractionEnabled = true
        isExclusiveTouch = true
        
        addGestureRecognizer(tapGesture)
        
        setupContent()
    }
    
    func setupContent() {
        
        personBackImageView.image = UIImage(named: "PersonBack")
        personFaceImageView.image = UIImage(named: person.name)
        
        if !person.unlocked {
            
            if let image = personFaceImageView.image {
                
                personFaceImageView.image = convertToGrayScale(image: image)
            }
        }
    }
    
    func cellTapped(gesture: UITapGestureRecognizer) {
        
        if gesture.state == .ended {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
                self.personBackImageView.transform = CGAffineTransform.identity
            }, completion: { finished in
                
                BaseViewController.presentPopupFor(person: self.person)
                
            })
        }
        else if gesture.state == .began {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
                self.personBackImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
        }
        
    }
}
