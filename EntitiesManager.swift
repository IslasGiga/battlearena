//
//  EntitiesManager.swift
//  Battle Arena
//
//  Created by Islas Girão Garcia on 12/05/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import GameplayKit
import SpriteKit

class EntitiesManager {

    let scene: SKScene!
    var entities = Set<GKEntity>()
    
    init(scene: SKScene){
        
        self.scene = scene
    }
    
    func add(_ entity: GKEntity){
    
        entities.insert(entity)
        
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.spriteNode{
            scene.addChild(spriteNode)
        }
        
    }
    
    func remove(_ entity: GKEntity){
        
        
        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.spriteNode{
            spriteNode.removeFromParent()
        }
        entities.remove(entity)
    }
    
    
}
