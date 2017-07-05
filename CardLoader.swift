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
    
    let scene: BattleScene
    
    init(scene: BattleScene) {
        self.scene = scene
    }
    
    func load(name: String, type: CardType) -> Card? {
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
                    return try setCardAttributes(with: json, for: type)
                } catch let error {
                    print("Got an error while unpacking the JSON: \(error.localizedDescription)")
                }
            }
            return nil
            
        } else {
            return nil
        }
    }
    
    fileprivate func setCardAttributes(with json: JSON, for type: CardType) throws -> Card {
        
        var card: Card
        
        guard let name = json["name"].string,
              let description = json["description"].string,
              let manaCost = json["manacost"].int,
              let summoningTime = json["summoningtime"].int
                else {
               throw NSException(name: NSExceptionName(rawValue: "No Card Exception"), reason: "The card could not be initialized with the current info - first exit", userInfo: nil) as! Error
        }
        
        switch type {
        case .character:
            guard let attackPoints = json["attack_points"].int,
                  let attackSpeed = json["attack_speed"].float,
                  let attackArea = json["attack_area"].int,
                  let attackRange = json["attack_range"].float,
                  let speed = json["movement_speed"].int,
                  let healthPoints = json["hp"].int,
                  let imageName = json["image"].string,
                  let cardImage = json["card_image"].string,
                  let atackEffect = json["atack_effect"].string,
                  let sizeWidth = json["size_width"].float,
                  let sizeHeight = json["size_height"].float
                        else {
                    throw NSException(name: NSExceptionName(rawValue: "No Info Exception"), reason: "The Character card could not be loaded with the current info", userInfo: nil) as! Error
            }
            
            var sound: String = "arrow"
            
            if let soundName = json["attack_sound"].string {
                if soundName.characters.count != 0 {
                    sound = soundName
                }
            }
            
            card = CharacterCard(image: UIImage(named: imageName)!,
                                         name: name,
                                         cardDescription: description,
                                         manaCost: manaCost,
                                         summoningTime: summoningTime,
                                         level: 1,
                                         xp: 1,
                                         atackPoints: attackPoints,
                                         atackSpeed: CGFloat(attackSpeed),
                                         atackArea: attackArea,
                                         atackRange: CGFloat(attackRange),
                                         speed: speed,
                                         healthPoints: healthPoints,
                                         battleScene: scene,
                                         teamId: 1,
                                         cardImage: UIImage(named: cardImage)!,
                                         atackEffect: atackEffect,
                                         nodeSize: CGSize(width: CGFloat(sizeWidth),
                                         height: CGFloat(sizeHeight)),
                                         soundName: sound)
            break
        default:
            card = Card(image: UIImage(named: "character")!, name: name, cardDescription: description, manaCost: manaCost, summoningTime: summoningTime, level: 1, xp: 1)
            break
        }
        
        return card
    }
    
}

enum CardType {
    case character
    case magic
    case construction
}
