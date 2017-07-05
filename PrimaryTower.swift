//
//  PrimaryTower.swift
//  Battle Arena
//
//  Created by Islas Girão Garcia on 15/05/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import GameplayKit

class PrimaryTower: CharacterCard {
    
    
    override init(image: UIImage, name: String, cardDescription: String, manaCost: Int, summoningTime: Int, level: Int, xp: Int, atackPoints: Int, atackSpeed: CGFloat, atackArea: Int, atackRange: CGFloat, speed: Int, healthPoints: Int, battleScene: BattleScene, teamId: Int, cardImage: UIImage, atackEffect: String, soundName: String) {
        super.init(image: image, name: name, cardDescription: cardDescription, manaCost: manaCost, summoningTime: 0, level: level, xp: xp, atackPoints: 70, atackSpeed: 0.5, atackArea: 1, atackRange: atackRange, speed: 0, healthPoints: 2000, battleScene: battleScene, teamId: teamId, cardImage: cardImage, atackEffect: "arrow", soundName: soundName)
        
        self.spriteNode.size = CGSize(width: 28, height: 40)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
