//
//  AIEnemy.swift
//  Battle Arena
//
//  Created by Marcus Reuber Almeida Moraes Silva on 02/06/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import SpriteKit

class AIEnemy {
    var deck : [Card] = []
    var strategies : [AIEnemyStrategy] = []
    var mana : CGFloat = 70.0
    var game : BattleScene
    
    init(game: BattleScene){
        self.game = game
    }
}
