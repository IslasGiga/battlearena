//
//  MainMenuScene.swift
//  Battle Arena
//
//  Created by Islas Girão Garcia on 16/06/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import UIKit
import SpriteKit

class MainMenuScene: SKScene {

    var gameViewController: GameViewController!
    
    override func didMove(to view: SKView) {
    
        loadRegisterView()
        
    }
    
    func loadRegisterView(){
    
        gameViewController.registerView.alpha = 1
        
        
        
    }
    
    func loadStartBattleScene(){
        
    }
    
    
}
