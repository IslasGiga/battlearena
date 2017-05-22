//
//  CharacterCard.swift
//  Battle Arena
//
//  Created by Islas Girão Garcia on 09/05/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import GameplayKit
import SpriteKit

enum States {
    case idle
    case atack
    case move
    case dead
}

class CharacterCard: Card {
    
    //state machine
    var state : States = .idle
    
    //Card Character SpriteNode
    var spriteNode : SKSpriteNode!
    
    
    //the team identifier of the monster
    var teamId: Int!
    
    //reference to the game scene
    var battleScene : BattleScene!
    
    //moving flag
    var isNotBusy : Bool = true
    
    init(image: UIImage, name: String, cardDescription: String, manaCost: Int, summoningTime: Int, level: Int, xp: Int, atackPoints: Int, atackSpeed: CGFloat, atackArea: Int, atackRange: CGFloat, speed: Int, healthPoints: Int , battleScene: BattleScene, teamId: Int) {
        
        
        super.init(image: image, name: name, cardDescription: cardDescription, manaCost: manaCost, summoningTime: summoningTime, level: level, xp: xp)
        
        self.addComponent(AtackComponent(atackPoints: atackPoints, atackSpeed: atackSpeed, atackArea: atackArea, atackRange: atackRange))
        
        self.addComponent(MovementComponent(speed: speed))
        
        self.addComponent(HealthComponent(healthPoints: healthPoints))
        
        self.addComponent(TargetIndexComponent())
        
        self.battleScene = battleScene
        
        self.spriteNode = SKSpriteNode.init(color: UIColor.brown, size: CGSize(width: 25, height: 25))
        
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
    
    func findNearestTargetAndAtack(){
        let characters = self.battleScene.characters
        for i in 00..<characters.count {
            if characters[i].teamId != self.teamId && characters[i].state != .dead {
                self.state = .atack
                if let target = self.component(ofType: TargetIndexComponent.self)?.targetIndex {
                    if distanceFromCharacter(character: characters[i]) < distanceFromCharacter(character: characters[target]){
                        self.component(ofType: TargetIndexComponent.self)?.targetIndex = i
                    }
                }else{
                    self.component(ofType: TargetIndexComponent.self)?.targetIndex = i
                }
            }
        }
    }
    
    //character moves towards target it's speed por 0.2 seconds
    func moveTowardsTarget(_ target: CharacterCard){
        if distanceFromCharacter(character: target) > (self.component(ofType: AtackComponent.self)?.atackRange)!{
            if self.isNotBusy{
                self.isNotBusy = false
                let angle = atan2(target.spriteNode.position.x - self.spriteNode.position.x, target.spriteNode.position.y - self.spriteNode.position.y)
                let xOffset = CGFloat((self.component(ofType: MovementComponent.self)?.speed)!) * sin(angle)
                let yOffset = CGFloat((self.component(ofType: MovementComponent.self)?.speed)!) * cos(angle)
                self.spriteNode.run(SKAction.moveBy(x: xOffset, y: yOffset, duration: 0.2), completion: {self.isNotBusy = true} )
            }
            
        }
    }
    
    func getManaCost()->CGFloat{
        let manaCost = CGFloat((self.component(ofType: InfoCardComponent.self)?.manaCost)!)
        return manaCost
    }
    
    func atack(){
        if self.isNotBusy{
            self.isNotBusy = false
            if let target = self.component(ofType: TargetIndexComponent.self)?.targetIndex {
                let enemie = self.battleScene.characters[target]
                
                let atackTime = (self.component(ofType: AtackComponent.self)?.atackSpeed)!
                //MARK: Add switch case for kind of atack
                //animateAtack() make character sprite animation on atack
                
                let atackSprite = SKSpriteNode(color: UIColor.red, size: CGSize(width: 5, height: 5))
                atackSprite.position = self.spriteNode.position
                atackSprite.zPosition = 5
                self.battleScene.addChild(atackSprite)
                let atackTarget = self.battleScene.characters[target].spriteNode.position
                atackSprite.run(SKAction.move(to: atackTarget, duration: TimeInterval(atackTime)), completion: {
                    atackSprite.removeFromParent()
                })
                
                self.spriteNode.run(SKAction.scale(by: 1, duration: TimeInterval(atackTime)), completion: {
                    enemie.component(ofType: HealthComponent.self)?.healthPoints -= (self.component(ofType: AtackComponent.self)?.atackPoints)!
                    if (enemie.component(ofType: HealthComponent.self)?.healthPoints)! <= 0 {
                        self.state = .idle
                        self.component(ofType: TargetIndexComponent.self)?.targetIndex = nil
                    }
                    self.isNotBusy = true
                })
                
                
            }
        }
    }
    
    func takeAction(){
        let characters : [CharacterCard] = self.battleScene.characters
        if (self.component(ofType: HealthComponent.self)?.healthPoints)! <= 0 {
            self.state = .dead
        }else{
            if let target = self.component(ofType: TargetIndexComponent.self)?.targetIndex {
                if (characters[target].component(ofType: HealthComponent.self)?.healthPoints)! <= 0 {
                    self.component(ofType: TargetIndexComponent.self)?.targetIndex = nil
                    self.state = .idle
                }
            }
        }
        
        switch self.state {
        case .idle:
            //            print("\(self.monsterName) \(self.id) is idle")
            self.findNearestTargetAndAtack()
        case .atack:
            let target = (self.component(ofType: TargetIndexComponent.self)?.targetIndex)!
            //print("\(self.monsterName) \(self.id) is atacking")
            if distanceFromCharacter(character: characters[target]) <= (self.component(ofType: AtackComponent.self)?.atackRange)! {
                //thow atack
                
                //print("\(self.monsterName) \(self.id) atacks \(monsters[self.target!].monsterName) \(monsters[self.target!].id)")
                
                self.atack()
                
            }else{
                self.state = .move
            }
        case .move:
            self.findNearestTargetAndAtack()
            //print("\(self.monsterName) \(self.id) is moving")
            let target = (self.component(ofType: TargetIndexComponent.self)?.targetIndex)!
            self.moveTowardsTarget(characters[target])
        case .dead:
            //print("\(self.monsterName) \(self.id) is dead")
            
            //
            //MARK: maybe this needs a flag for not repeating
            //
            
            self.spriteNode.removeFromParent()
        }
    }
    
}
