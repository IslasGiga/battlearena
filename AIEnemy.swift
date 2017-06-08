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
    let loader : CardLoader?
    var strategies : [AIEnemyStrategy] = []
    var mana : CGFloat = 70.0
    var game : BattleScene
    var playingStrategy = false
    init(game: BattleScene){
        self.game = game
        self.strategies.append(AIEnemyStrategy(type: .PlayRandom, game: game))
        
        self.loader = CardLoader(scene: game)
        let names = ["Dwarf",
                     "Cyclope",
                     "Elf",
                     "Priest",
                     "Satyr",
                     "Mummy",
                     "Knight",
                     "Wizard"]
        for value in names {
            let load = loader?.load(name: value, type: .character)
            if let load = load {
                let card = load as! CharacterCard
                deck.append(card)
            }
        }
    }
    
    func pickStrategy() -> Int{
        var max = 0
        for i in 0...self.strategies.count-1 {
            if self.strategies[i].value() > self.strategies[max].value(){
                max = i
            }
        }
        return max
    }
    
    func playStrategy(atIndex i: Int) {
        if !playingStrategy{
            if mana >= self.strategies[i].manaCost{
                playingStrategy = true
                self.strategies[i].play(self)
            }
        }
    }
    
    func playCard(atIndex i : Int, atPosition: CGPoint){
        
    }
}
