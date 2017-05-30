//
//  CardLoader.swift
//  Battle Arena
//
//  Created by Felipe Borges on 30/05/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import Foundation
import SwiftyJSON

class CardLoader {
    
    func load(name: String) -> Card? {
        let url = Bundle.main.url(forResource: name, withExtension: ".json")
        
        if let url = url {
            
            var data: Data?
            
            do {
                data =
                    try Data(contentsOf: url)
                
            } catch let error {
                print("Got an error while loading the URL: \(error.localizedDescription)")
            }
            
            if let data = data {
                let json = JSON(data)
                do {
                    return try setCardAttributes(with: json)
                } catch let error {
                    print("Got an error while unpacking the JSON: \(error.localizedDescription)")
                }
            }
            return nil
            
        } else {
            return nil
        }
    }
    
    fileprivate func setCardAttributes(with json: JSON) throws -> Card {
        
        var card: Card
        
        guard let name = json["name"].string,
              let description = json["description"].string,
              let manaCost = json["manacost"].int,
              let summoningTime = json["summoningtime"].int
                else {
               throw NSException(name: NSExceptionName(rawValue: "No Card Exception"), reason: "The card could not be initialized with the current info", userInfo: nil) as! Error
        }
        
        card = Card(image: UIImage(named: "character")!, name: name, cardDescription: description, manaCost: manaCost, summoningTime: summoningTime, level: 1, xp: 1)
        
        return card
    }
    
}
