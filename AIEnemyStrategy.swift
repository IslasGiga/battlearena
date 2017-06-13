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
    
    var valueCheck : () -> Int
    
    var enemyMove : (_ enemy: AIEnemy) -> ()
    
    init(type: Strategy, game: BattleScene){
        
        self.game = game
        self.cardLoader = CardLoader(scene: game)
        
        switch type{
        case .AtackEnemyTurrent:
            //cards.append(cardLoader.load(name: "Cyclope", type: .character)!)
            
            valueCheck = { () -> Int in
                var value = 0
                if game.enemyAliveCharacter() == nil && game.playerAliveCharacter() == nil {
                    value = 8
                }
                
                return value
            }
            
            self.enemyMove = { (_ enemy: AIEnemy) -> () in
                var pos = CGPoint(x: 0, y: 50)
                
                if let aliveChar = game.enemyAliveCharacter() {
                    pos.x = aliveChar.spriteNode.position.x
                }
                
                //play random card move
                let cardIndex = Int(arc4random()%4)
                if let charCard = enemy.deck[cardIndex] as? CharacterCard {
                    if charCard.getManaCost() < enemy.mana{
                        game.spawnCharacter(fromCard: charCard, atPosition: pos, team: 1)
                        enemy.mana -= charCard.getManaCost()
                    }
                }
                
                enemy.playingStrategy = false
            }
            
            break
            
        case .SendSupportToAtack:
            //cards.append(cardLoader.load(name: "Satyr", type: .character)!)
            //cards.append(cardLoader.load(name: "Dwarf", type: .character)!)
            
            
            valueCheck = { () -> Int in
                var value = 0
                if game.enemyAliveCharacter() != nil {
                    value = 11
                }
                return value
            }
            
            self.enemyMove = { (_ enemy: AIEnemy) -> () in
                var pos = CGPoint(x: 0, y: 50)
                
                if let aliveChar = game.enemyAliveCharacter() {
                    pos.x = aliveChar.spriteNode.position.x
                }
                
                //play random card move
                let cardIndex = Int(arc4random()%4)
                if let charCard = enemy.deck[cardIndex] as? CharacterCard {
                    if charCard.getManaCost() < enemy.mana{
                        game.spawnCharacter(fromCard: charCard, atPosition: pos, team: 1)
                        enemy.mana -= charCard.getManaCost()
                    }
                }
                
                enemy.playingStrategy = false
            }
            
            break
            
        case .PlayRandom:
            
            valueCheck = { () -> Int in
                return 5
            }
            
            self.enemyMove = { (_ enemy: AIEnemy) -> () in
                let pos = game.getAtackPosition()
                
                //play random card move
                let cardIndex = Int(arc4random()%4)
                if let charCard = enemy.deck[cardIndex] as? CharacterCard {
                    if charCard.getManaCost() < enemy.mana{
                        game.spawnCharacter(fromCard: charCard, atPosition: pos, team: 1)
                        enemy.mana -= charCard.getManaCost()
                    }
                }
                
                enemy.playingStrategy = false

                
            }
            
            break
            
        case .GankIncomingAtacker:
            //cards.append(cardLoader.load(name: "Knight", type: .character)!)
            //cards.append(cardLoader.load(name: "Elf", type: .character)!)
            
            valueCheck = { () -> Int in
                var value = 0
                if game.playerAliveGankableCharacter() != nil {
                    value = 12
                }
                return value
            }
            
            self.enemyMove = { (_ enemy: AIEnemy) -> () in
                var pos = CGPoint(x: 0, y: 50)
                if let gankPos = game.getGankPosition() {
                    pos = gankPos
                }
                
                //play random card move
                let cardIndex = Int(arc4random()%4)
                if let charCard = enemy.deck[cardIndex] as? CharacterCard {
                    if charCard.getManaCost() < enemy.mana{
                        game.spawnCharacter(fromCard: charCard, atPosition: pos, team: 1)
                        enemy.mana -= charCard.getManaCost()
                    }
                }
                
                enemy.playingStrategy = false
                
            }
            
            break
            
        case .WaitForMana:
            valueCheck = { () -> Int in
                
                if game.enemy!.mana < 100.0 {
                    return 10
                }else{
                    return 0
                }
            }
            
            self.enemyMove = { (_ enemy: AIEnemy) -> () in
                enemy.playingStrategy = false
            }
            
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
    
    //returns a position to summon an atacking mob closest to the weakest player turret
    func getAtackPosition() -> CGPoint{
        var lowerHpIndex = 0
        
        for i in 2...4 {
            let currentLowersHP = (game.characters[lowerHpIndex].component(ofType: HealthComponent.self)?.healthPoints)!
            let checkedHP = (game.characters[i].component(ofType: HealthComponent.self)?.healthPoints)!
            if checkedHP < currentLowersHP {
                lowerHpIndex = i
            }
        }
        
        var pos = game.battleNode!.position
        pos.y += 25
        
        if lowerHpIndex == 2 {
            pos.x -= game.battleNode!.size.width / 4
        }
        
        if lowerHpIndex == 4 {
            pos.x += game.battleNode!.size.width / 4
        }
        
        return pos
    }
    
    //returns a point near to the closest turrent to an enemy
    func getDefensePosition() -> CGPoint{
        var pos = CGPoint(x: 0, y: 0)
        
        if let enemyAtacker = playerAliveCharacter() {
            let atackedTowerIndex = nearestTower(toCharacter: enemyAtacker)
            pos = game.characters[atackedTowerIndex].spriteNode.position
            pos.x += 20
            pos.y -= 20
        }
        
        return pos
    }
    
    //return a point to summon a character to gank an atack
    func getGankPosition() -> CGPoint?{
        var pos : CGPoint
        if let gankableCharacter = playerAliveGankableCharacter() {
            let closestTurrent = game.characters[nearestTower(toCharacter: gankableCharacter)]
            pos = closestTurrent.spriteNode.position
            pos.x += 20
            pos.y -= 10
            return pos
        }
        
        return nil
    }
    
    //returns a player alive character or nil in case of unexistent
    func playerAliveCharacter() -> CharacterCard? {
        if game.characters.count > 8 {
            for i in 8...game.characters.count {
                if isPlayerCharacterAndAlive(character: game.characters[i]) {
                    return game.characters[i]
                }
            }
        }
        return nil
    }
    
    //verufies if characer is alive and in the players team
    func isPlayerCharacterAndAlive(character: CharacterCard) -> Bool{
        return character.state != .dead && character.teamId == 0
    }
    
    //verifies if character is close enought to a tourrent for a gank
    func isPlayerCharacterGankable(character: CharacterCard) -> Bool{
        var closeToATurrent = false
        
        let nearestTurretIndex = nearestTower(toCharacter: character)
        let nearestTurret = game.characters[nearestTurretIndex]
        let nearestTurretRange =  (nearestTurret.component(ofType: AtackComponent.self)?.atackRange)!
        if character.distanceFromCharacter(character: nearestTurret) < nearestTurretRange + 50.0 {
            closeToATurrent = true
        }
        
        return isPlayerCharacterAndAlive(character: character) && closeToATurrent
    }
    
    
    //return a gankable character or nill in inexistance
    func playerAliveGankableCharacter() -> CharacterCard? {
        var char : CharacterCard? = nil
        if game.characters.count > 8 {
            for i in 8...game.characters.count {
                if isPlayerCharacterGankable(character: game.characters[i]) {
                    char = game.characters[i]
                }
            }
        }
        
        return char
    }
    
    
    //return enemy tower index closest to the character
    func nearestTower(toCharacter character: CharacterCard) -> Int {
        var closest = 1
        for i in 5...7 {
            if character.distanceFromCharacter(character: game.characters[i]) < character.distanceFromCharacter(character: game.characters[closest]){
                closest = i
            }
        }
        return closest
    }
    
    func trySummoningRandomChar(forEnemy enemy: AIEnemy, atPosition pos: CGPoint){
        //play random card move
        let cardIndex = Int(arc4random()%4)
        if let charCard = enemy.deck[cardIndex] as? CharacterCard {
            if charCard.getManaCost() < enemy.mana{
                game.spawnCharacter(fromCard: charCard, atPosition: pos, team: 1)
                enemy.mana -= charCard.getManaCost()
            }
        }
        
        enemy.playingStrategy = false
    }
}
