//
//  TPPerson.swift
//  TrumpPunch
//
//  Created by Admin on 2/20/17.
//  Copyright © 2017 Downing Development. All rights reserved.
//

import Foundation

class TPPerson: NSObject, NSCoding {
    
    var name: String
    var price: String
    var body: String
    var unlocked: Bool
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("people")
    
    struct PropertyKey {
        
        static let nameKey = "name"
        static let priceKey = "price"
        static let bodyKey = "body"
        static let unlockedKey = "unlocked"
    }
    
    init(name: String = "Setup", price: String = "0", body: String = "Setup", unlocked: Bool = false) {
        
        self.name = name
        self.price = price
        self.body = body
        self.unlocked = unlocked
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(price, forKey: PropertyKey.priceKey)
        aCoder.encode(body, forKey: PropertyKey.bodyKey)
        aCoder.encode(unlocked, forKey: PropertyKey.unlockedKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        let price = aDecoder.decodeObject(forKey: PropertyKey.priceKey) as! String
        let body = aDecoder.decodeObject(forKey: PropertyKey.bodyKey) as! String
        let unlocked = aDecoder.decodeBool(forKey: PropertyKey.unlockedKey)
        
        self.init(name: name, price: price, body: body, unlocked: unlocked)
        
    }
    
    func toAny() -> Any {
        
        return [
            
            "name" : name,
            "price" : price,
            "body" : body,
            "unlocked" : unlocked
        ]
    }
}
