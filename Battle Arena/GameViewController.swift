//
//  GameViewController.swift
//  Battle Arena
//
//  Created by Islas Girão Garcia on 08/05/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadBattleScene()
        
        
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //    if let scene = GKScene(fileNamed: "BattleScene") {
    //
    //        // Get the SKScene from the loaded GKScene
    //        if let sceneNode = scene.rootNode as! BattleScene? {
    //
    //            // Copy gameplay related content over to the scene
    //            sceneNode.entities = scene.entities
    //            sceneNode.graphs = scene.graphs
    //
    //            // Set the scale mode to scale to fit the window
    //            sceneNode.scaleMode = .aspectFill
    //
    //            // Present the scene
    //            if let view = self.view as! SKView? {
    //                view.presentScene(sceneNode)
    //
    //                view.ignoresSiblingOrder = true
    //
    //                view.showsFPS = true
    //                view.showsNodeCount = true
    //            }
    //        }
    //    }
    
    // MARK: Load Splash Screen Scene
    
    func loadSpashScreenScene(){
        if let scene = GKScene(fileNamed: "SplashScreenScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! SplashScreenScene? {
                
                // Copy gameplay related content over to the scene
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                sceneNode.gameViewController = self
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
        
    }
    
    // MARK: Load Splash Screen Scene
    
    func loadBattleScene(){
        if let scene = GKScene(fileNamed: "BattleScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! BattleScene? {
                
                // Copy gameplay related content over to the scene
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
        
    }
    
    
}
