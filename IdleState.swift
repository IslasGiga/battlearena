//
//  IdleState.swift
//  Battle Arena
//
//  Created by Marcus Reuber Almeida Moraes Silva on 15/05/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import SpriteKit
import GameplayKit

class IdleState : CharacterState {
    
    
    required override init(game: BattleScene, associatedNodeName: String, associatedCard: CharacterCard) {
        super.init(game: game, associatedNodeName: associatedNodeName, associatedCard: associatedCard)
    }
    
    override func didEnter(from previousState: GKState?) {
        
    }
}
