//
//  TPItemsCollectionViewCell.swift
//  TrumpPunch
//
//  Created by Admin on 2/22/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation
import UIKit

class TPItemsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var itemBackImageView: UIImageView!
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    var item = TPItem()
    
    func setup(for item: TPItem) {
        
        self.item = item
        backgroundColor = UIColor.clear
        
        isUserInteractionEnabled = true
        isExclusiveTouch = true
        
        let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(cellTapped(gesture:)))
        tapGesture.minimumPressDuration = 0
        addGestureRecognizer(tapGesture)
        
        setupContent()
    }
    
    func setupContent() {
        
        itemImageView.image = UIImage(named: item.name)
        itemNameLabel.text = item.name
    }
    
    func cellTapped(gesture: UITapGestureRecognizer) {
        
        if gesture.state == .ended {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
                self.itemBackImageView.transform = CGAffineTransform.identity
            }, completion: { finished in
                
                BaseViewController.presentPopupFor(item: self.item)
            })
        }
        else if gesture.state == .began {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
                self.itemBackImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
        }
        
    }
}
