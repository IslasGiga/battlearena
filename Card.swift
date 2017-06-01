//
//  Card.swift
//  Battle Arena
//
//  Created by Islas Girão Garcia on 09/05/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import UIKit
import GameplayKit
import SpriteKit

class Card: GKEntity {


    init(image: UIImage, name: String, cardDescription: String, manaCost: Int, summoningTime: Int, level: Int, xp: Int) {
        

        super.init()
        
        self.addComponent(InfoCardComponent(image: image, name: name, cardDescription: cardDescription, manaCost: manaCost, summoningTime: summoningTime))
        
        self.addComponent(SpriteComponent(name: name))
        
        self.addComponent(LevelCardComponent(level: level, xp: xp))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
