//
//  TPPerson.swift
//  TrumpPunch
//
//  Created by Admin on 2/20/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation

class TPItem: NSObject, NSCoding {
    
    var name: String
    var price: String
    var coinsEarned: String
    var unlocked: Bool
    var current: Bool
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("items")
    
    struct PropertyKey {
        
        static let nameKey = "name"
        static let priceKey = "price"
        static let coinsEarnedKey = "coinsEarned"
        static let unlockedKey = "unlocked"
        static let currentKey = "current"
    }
    
    init(name: String = "Setup", price: String = "0", coinsEarned: String = "0", unlocked: Bool = false, current: Bool = false) {
        
        self.name = name
        self.price = price
        self.coinsEarned = coinsEarned
        self.unlocked = unlocked
        self.current = current
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(price, forKey: PropertyKey.priceKey)
        aCoder.encode(coinsEarned, forKey: PropertyKey.coinsEarnedKey)
        aCoder.encode(unlocked, forKey: PropertyKey.unlockedKey)
        aCoder.encode(current, forKey: PropertyKey.currentKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        let price = aDecoder.decodeObject(forKey: PropertyKey.priceKey) as! String
        let coinsEarned = aDecoder.decodeObject(forKey: PropertyKey.coinsEarnedKey) as! String
        let unlocked = aDecoder.decodeBool(forKey: PropertyKey.unlockedKey)
        let current = aDecoder.decodeBool(forKey: PropertyKey.currentKey)
        
        self.init(name: name, price: price, coinsEarned: coinsEarned, unlocked: unlocked, current: current)
        
    }
    
    func toAny() -> Any {
        
        return [
            
            "name" : name,
            "price" : price,
            "coinsEarned" : coinsEarned,
            "unlocked" : unlocked,
            "current" : current
        ]
    }
}
