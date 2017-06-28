//
//  SplashScreenScene.swift
//  Battle Arena
//
//  Created by Islas Girão Garcia on 12/05/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import SpriteKit

class SplashScreenScene: SKScene {

    var gameViewController: GameViewController!
    
    override func didMove(to view: SKView) {
        
        self.run(SKAction.wait(forDuration: 3))
        if UserDefaults.value(forKey: "layerName") != nil {
        
            
        } else {
            
        }
        
        
        
    }
    
    
    
}
