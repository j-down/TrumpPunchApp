//
//  TPStoreCollectionViewCell.swift
//  TrumpPunch
//
//  Created by Admin on 2/27/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

//
//  TPPeopleCollectionViewCell.swift
//  TrumpPunch
//
//  Created by Admin on 2/21/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

class TPStoreCollectionViewCell: UICollectionViewCell {
    
    var product: SKProduct!
    
    
    @IBOutlet weak var productImageView: UIImageView!
    
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    
    
    func setup(for product: SKProduct) {
        
        self.product = product
        
        backgroundColor = UIColor.clear
        
        let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(cellTapped(gesture:)))
        tapGesture.minimumPressDuration = 0
        
        isUserInteractionEnabled = true
        isExclusiveTouch = true
        
        addGestureRecognizer(tapGesture)
        
        setupContent()
    }
    
    func setupContent() {
        
        if let name = resourceNameForProductIdentifier(product.productIdentifier) {
            
            productImageView.image = UIImage(named: name)
        }
        
        
    }
    
    func cellTapped(gesture: UITapGestureRecognizer) {
        
        if gesture.state == .ended {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
                self.productImageView.transform = CGAffineTransform.identity
            }, completion: { finished in
                
                //TODO: make do 
                
            })
        }
        else if gesture.state == .began {
            
            UIView.animate(withDuration: 0.1, delay: 0, animations: {
                
               self.productImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            })
        }
        
    }
}

