//
//  CharacterState.swift
//  Battle Arena
//
//  Created by Marcus Reuber Almeida Moraes Silva on 15/05/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import SpriteKit
import GameplayKit

class CharacterState : GKState {
    //MARK: Properties
    
    // a reference to the battle scene, used to alter sprites
    var game : BattleScene!
    
    //the name of the node in the battle scene that is associated with this state
    var associatedNodeName: String!
    
    //Knows what card we are playing with
    var associatedCharacterCard : CharacterCard!
    
    //Convenience property to get the state's associated sprite node
//    var associatedCard: SKSpriteNode? {
//        return game.childNode(withName: "//\(associatedNodeName)") as? SKSpriteNode
//    }
    
    // MARK: Initialization
    
    init(game: BattleScene, associatedNodeName: String, associatedCard: CharacterCard) {
        super.init()
        self.game = game
        self.associatedNodeName = associatedNodeName
        self.associatedCharacterCard = associatedCard
    }
    
    //MARK: GKState overrides
    
    override func didEnter(from previousState: GKState?) {
        if (self.associatedCharacterCard.component(ofType: HealthComponent.self)?.healthPoints)! <= 0 {
            self.stateMachine?.enter(DeadState.self)
            return
        }else{
            if let targetIndex = (self.associatedCharacterCard.component(ofType: TargetIndexComponent.self)?.targetIndex) {
                if (game.characters[targetIndex].component(ofType: HealthComponent.self)?.healthPoints)! <= 0 {
                    self.associatedCharacterCard.component(ofType: TargetIndexComponent.self)?.targetIndex = nil
                        self.stateMachine?.enter(IdleState.self)
                }
            }
        }
    }
    
    override func willExit(to nextState: GKState) {
        
    }
    
    //MARK: Methods
    
    //find nearest alive target
    
    
    //Character movement method
}
