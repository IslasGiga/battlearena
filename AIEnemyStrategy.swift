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
            cards.append(cardLoader.load(name: "Dwarf", type: .character)!)
            break
        case .PlayRandom:
            
            break
        case .GankIncomingAtacker:
            cards.append(cardLoader.load(name: "Knight", type: .character)!)
            cards.append(cardLoader.load(name: "Elf", type: .character)!)
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
    func play(_ enemy : AIEnemy){
        //play random card move
        let cardIndex = Int(arc4random()%4)
        if let charCard = enemy.deck[cardIndex] as? CharacterCard {
            if charCard.getManaCost() < enemy.mana{
                game.spawnCharacter(fromCard: charCard, atPosition: CGPoint(x: 0, y: 100), team: 1)
                enemy.mana -= charCard.getManaCost()
            }
        }

        enemy.playingStrategy = false
    }
    
    func getAtackPosition(){
        
    }
    
    func getDefensePosition(){
        
    }
    
    func getGankPosition(){
        
    }
}
