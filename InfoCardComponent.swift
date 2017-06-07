//
//  VisualCardComponent.swift
//  Battle Arena
//
//  Created by Islas Girão Garcia on 12/05/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import GameplayKit
import SpriteKit

class InfoCardComponent: GKComponent {

    let image: UIImage
    var name: String
    let cardDescription: String
    let manaCost: Int
    let summoningTime: Int
    
    
    init(image: UIImage, name: String, cardDescription: String, manaCost: Int, summoningTime: Int) {
        
        self.image = image
        self.name = name
        self.cardDescription = cardDescription
        self.manaCost = manaCost
        self.summoningTime = summoningTime
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
