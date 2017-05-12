//
//  HealthComponent.swift
//  Battle Arena
//
//  Created by Islas Girão Garcia on 09/05/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import GameplayKit
import SpriteKit

class HealthComponent: GKComponent {

    var healthPoints: Int
    
    init(healthPoints: Int) {
        self.healthPoints = healthPoints
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func takeDamage(damage: Int){
        self.healthPoints = self.healthPoints - damage
    }
    
    
    
    
}
