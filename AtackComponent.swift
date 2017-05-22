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
    let atackSpeed: CGFloat
    let atackArea: Int
    let atackRange: CGFloat
    
    init(atackPoints: Int, atackSpeed: CGFloat, atackArea: Int, atackRange: CGFloat){
        self.atackSpeed = atackSpeed
        self.atackPoints = atackPoints
        self.atackArea = atackArea
        self.atackRange = atackRange
        super.init()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
