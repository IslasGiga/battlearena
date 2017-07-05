//
//  SpriteComponent.swift
//  Battle Arena
//
//  Created by Islas Girão Garcia on 12/05/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import GameplayKit
import SpriteKit

class SpriteComponent: GKComponent {

    let spriteNode: SKSpriteNode!
    
    
    init(name: String){
        
        self.spriteNode = SKSpriteNode(texture: SKTexture(imageNamed: name))
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
