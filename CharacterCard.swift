//
//  CharacterCard.swift
//  Battle Arena
//
//  Created by Islas Girão Garcia on 09/05/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import GameplayKit
import SpriteKit

class CharacterCard: Card {

    init(image: UIImage, name: String, cardDescription: String, manaCost: Int, summoningTime: Int, level: Int, xp: Int,atackPoints: Int, atackSpeed: Int, atackArea: Int, speed: Int, healthPoints: Int) {
        
        
        super.init(image: image, name: name, cardDescription: cardDescription, manaCost: manaCost, summoningTime: summoningTime, level: level, xp: xp)
        
        self.addComponent(AtackComponent(atackPoints: atackPoints, atackSpeed: atackSpeed, atackArea: atackArea))
        
        self.addComponent(MovementComponent(speed: speed))
        
        self.addComponent(HealthComponent(healthPoints: healthPoints))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
