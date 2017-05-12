//
//  LevelCardComponent.swift
//  Battle Arena
//
//  Created by Islas Girão Garcia on 11/05/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import GameplayKit
import SpriteKit

class LevelCardComponent: GKComponent {

    let level: Int
    let xp: Int
    
    init(level: Int, xp: Int) {
        
        self.level = level
        self.xp = xp
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
