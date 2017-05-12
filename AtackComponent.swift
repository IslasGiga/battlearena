//
//  AtackComponent.swift
//  Battle Arena
//
//  Created by Islas Girão Garcia on 11/05/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import GameplayKit
import SpriteKit

class AtackComponent: GKComponent {

    let atackPoints: Int
    let atackSpeed: Int
    let atackArea: Int
    
    init(atackPoints: Int, atackSpeed: Int, atackArea: Int){
        self.atackSpeed = atackSpeed
        self.atackPoints = atackPoints
        self.atackArea = atackArea
        super.init()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
