//
//  CharacterCard.swift
//  Battle Arena
//
//  Created by Islas Girão Garcia on 09/05/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import GameplayKit
import SpriteKit

class CharacterCard: Card {
    
    //Card Character State Machine
    var stateMachine : GKStateMachine!
    
    //Card Character SpriteNode
    var spriteNode : SKSpriteNode!
    
    
    //the team identifier of the monster
    var teamId: Int!
    
    //reference to the game scene
    var battleScene : BattleScene!
    
    //moving flag
    var isNotMoving : Bool = true
    
    init(image: UIImage, name: String, cardDescription: String, manaCost: Int, summoningTime: Int, level: Int, xp: Int, atackPoints: Int, atackSpeed: Int, atackArea: Int, atackRange: CGFloat, speed: Int, healthPoints: Int , battleScene: BattleScene, teamId: Int) {
        
        
        super.init(image: image, name: name, cardDescription: cardDescription, manaCost: manaCost, summoningTime: summoningTime, level: level, xp: xp)
        
        self.addComponent(AtackComponent(atackPoints: atackPoints, atackSpeed: atackSpeed, atackArea: atackArea, atackRange: atackRange))
        
        self.addComponent(MovementComponent(speed: speed))
        
        self.addComponent(HealthComponent(healthPoints: healthPoints))
        
        self.addComponent(TargetIndexComponent())
        
        self.battleScene = battleScene
        
        self.stateMachine = GKStateMachine(states: [IdleState.init(game: battleScene, associatedNodeName: name, associatedCard: self)])
        
        self.spriteNode = SKSpriteNode.init(color: UIColor.brown, size: CGSize(width: 50, height: 50))
        if teamId == 1{
            self.spriteNode.color = UIColor.lightGray
        }
        
        self.teamId = teamId
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //suport function for calculating distance between two characters
    func distanceFromCharacter(character: CharacterCard)-> CGFloat{
        var x, y : CGFloat
        x = character.spriteNode.position.x - self.spriteNode.position.x
        y = character.spriteNode.position.y - self.spriteNode.position.y
        return CGFloat(sqrt(x*x + y*y))
    }
    
    func findNearestTarget(){
        let monsters = self.battleScene.characters
        for i in 00..<monsters.count {
            if monsters[i].teamId != self.teamId && monsters[i].stateMachine.isKind(of: DeadState.self) {
                if let target = self.component(ofType: TargetIndexComponent.self)?.targetIndex {
                    if distanceFromCharacter(character: monsters[i]) < distanceFromCharacter(character: monsters[target]){
                        self.component(ofType: TargetIndexComponent.self)?.targetIndex = i
                    }
                }else{
                    self.component(ofType: TargetIndexComponent.self)?.targetIndex = i
                }
            }
        }
    }
    
    //character moves towards target it's speed per second
    func moveTowardsTarget(_ target: CharacterCard){
        if distanceFromCharacter(character: target) > (self.component(ofType: AtackComponent.self)?.atackRange)!{
            if self.isNotMoving{
                self.isNotMoving = false
                let angle = atan2(target.spriteNode.position.x - self.spriteNode.position.x, target.spriteNode.position.y - self.spriteNode.position.y)
                let xOffset = CGFloat((self.component(ofType: MovementComponent.self)?.speed)!) * sin(angle)
                let yOffset = CGFloat((self.component(ofType: MovementComponent.self)?.speed)!) * cos(angle)
                self.spriteNode.run(SKAction.moveBy(x: xOffset, y: yOffset, duration: 1), completion: {self.isNotMoving = true} )
            }
            
        }
    }
    
    
}
