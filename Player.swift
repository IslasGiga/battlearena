//
//  Player.swift
//  Battle Arena
//
//  Created by Islas Girão Garcia on 09/05/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import UIKit

class Player: NSObject {

    
    let name: String
    let id: Int
    let facebookId: Int
    let coins: Int
    let crystal: Int
    let level: Int
    let medals: Int
    let cards: [Card]
    let deck: [Card]
    let numberOfMatchs: Int
    let teamId: Int
    
    
    init(name: String, id: Int, facebookId: Int, coins: Int, crystal: Int, level: Int, medals: Int, cards: [Card], deck: [Card], numberOfMatchs: Int, teamId: Int){
    
        self.name = name
        self.id = id
        self.facebookId = facebookId
        self.coins = coins
        self.crystal = crystal
        self.level = level
        self.medals = medals
        self.cards = cards
        self.deck = deck
        self.numberOfMatchs = numberOfMatchs
        self.teamId = teamId
        super.init()
        
    }
}
