//
//  SecundaryTower.swift
//  Battle Arena
//
//  Created by Islas Girão Garcia on 15/05/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import GameplayKit

class SecundaryTower: CharacterCard {
    
    override init(image: UIImage, name: String, cardDescription: String, manaCost: Int, summoningTime: Int, level: Int, xp: Int, atackPoints: Int, atackSpeed: CGFloat, atackArea: Int, atackRange: CGFloat, speed: Int, healthPoints: Int, battleScene: BattleScene, teamId: Int, cardImage: UIImage, atackEffect: String) {
        super.init(image: image, name: name, cardDescription: cardDescription, manaCost: manaCost, summoningTime: 0, level: level, xp: xp, atackPoints: 20, atackSpeed: 0.5, atackArea: 1, atackRange: atackRange, speed: 0, healthPoints: 1000, battleScene: battleScene, teamId: teamId, cardImage: cardImage, atackEffect: "arrow")
        
        
        self.spriteNode.size = CGSize(width: 32, height: 32)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
