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
    var cardLoader : CardLoader
    init(type: Strategy, game: BattleScene){
        
        self.game = game
        self.cardLoader = CardLoader(scene: game)
        
        switch type{
        case .AtackEnemyTurrent:
            cards.append(cardLoader.load(name: "Cyclope", type: .character)!)
            break
        case .SendSupportToAtack:
            cards.append(cardLoader.load(name: "Satyr", type: .character)!)
            break
        case .PlayRandom:
            
            break
        case .GankIncomingAtacker:
            
            break
        case .WaitForMana:
            
            break
        }
        
        
        for card in cards {
            manaCost += CGFloat((card.component(ofType: InfoCardComponent.self)?.manaCost)!)
        }
    }
    
    func value() -> Int{
        return 0
    }
    
    func addCard(_ named: String){
        if let card = cardLoader.load(name: named, type: .character){
            self.cards.append(card)
        }
        
    }
}
