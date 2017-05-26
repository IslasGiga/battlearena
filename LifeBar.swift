//
//  Lifebar.swift
//  Battle Arena
//
//  Created by Felipe Borges on 24/05/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import Foundation
import SpriteKit

class LifeBar: SKSpriteNode {

    var maxHP: Int!
    var currentLife: Int!
    var lifeSprite: SKSpriteNode!
    var isTakingDame = false
    
    init(forCharacter character: CharacterCard){
        super.init(texture: nil, color: UIColor.black, size: CGSize(width: character.spriteNode.size.width, height: character.spriteNode.size.width/5))
        
        self.maxHP = (character.component(ofType: HealthComponent.self)?.healthPoints)!
        self.currentLife = self.maxHP
        
        self.position.y += character.spriteNode.size.height / 2 + self.size.height / 2
        
        //Red part that moves
        self.lifeSprite = SKSpriteNode(color: UIColor.red, size: self.size)
        self.zPosition = character.spriteNode.zPosition + 1
        self.lifeSprite.zPosition = self.zPosition + 1
        self.lifeSprite.anchorPoint = CGPoint(x: 0, y: 0.5)
        self.lifeSprite.position.x -= self.size.width / 2
        self.addChild(lifeSprite)
        self.isHidden = true
        
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func take(damage: Int){
        self.isTakingDame = true
        self.currentLife = self.currentLife - damage
        self.isHidden = false
        if currentLife > 0 {
            self.lifeSprite.run(SKAction.resize(toWidth: self.size.width * (CGFloat(currentLife) / CGFloat(maxHP)), duration: 0.3), completion: {
                self.isTakingDame = false
                self.run(SKAction.wait(forDuration: 0.2), completion: {
                    if !self.isTakingDame {
                        self.isHidden = true
                    }
                    
                })
                
            })
        }else{
            self.lifeSprite.run(SKAction.resize(toWidth: 0, duration: 0.3), completion: {
                self.isHidden = true
            })
            
        }
        
    }
}
