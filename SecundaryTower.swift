//
//  SecundaryTower.swift
//  Battle Arena
//
//  Created by Islas Girão Garcia on 15/05/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import GameplayKit

class SecundaryTower: GKEntity {

    
    init(level: Int, healthPoints: Int, atack: GKComponent) {
        
        self.addComponent(HealthComponent(healthPoints: healthPoints))
        
        self.addComponent(atack)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
}
