//
//  AIEnemyStrategy.swift
//  Battle Arena
//
//  Created by Marcus Reuber Almeida Moraes Silva on 02/06/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//
import Foundation
import GameplayKit
import SpriteKit

enum Strategy {
    case PlayRandom
    case GankIncomingAtacker
    case SendSupportToAtack
    case WaitForMana
    case AtackEnemyTurrent
}

class AIEnemyStrategy {
    let game : BattleScene
    var cards : [Card] = []
    var manaCost : CGFloat = 0.0
    
    init(type: Strategy, game: BattleScene){
        
        self.game = game
        
        for card in cards {
            manaCost += CGFloat((card.component(ofType: InfoCardComponent.self)?.manaCost)!)
        }
    }
    
    func value() -> Int{
        return 0
    }
}
