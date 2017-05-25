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

    let max: Int
    var currentLife: Int
    
    var life: SKSpriteNode
    
    convenience init() {
        self.init(withMax: 100)
    }
    
    init(withMax max: Int) {
        self.max = max
        currentLife = max
        
        let sprite = SKScene(fileNamed: "LifeBar")!.childNode(withName: "parent") as! SKSpriteNode
        
        super.init(texture: nil, color: UIColor.clear, size: sprite.size)

        sprite.removeFromParent()
        
        let child = sprite.childNode(withName: "child") as SKSpriteNode
        self.life = child
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func removeLife(amount: Int) {
        
    }
    
    
}
