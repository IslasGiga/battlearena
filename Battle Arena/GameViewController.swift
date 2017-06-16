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

    
    @IBAction func registerUser(_ sender: Any) {
        
        
    }
    
    @IBOutlet weak var registerView: UIView!
    
    @IBOutlet weak var confirmButtom: UIButton!
    
    
    
    override func viewDidLoad() {
        
        let game = BattleScene()
        let cardLoader = CardLoader(scene: game)
        
        if let char = cardLoader.load(name: "Mummy", type: .character) {
            print((char.component(ofType: HealthComponent.self)?.healthPoints)!)
            print((char.component(ofType: InfoCardComponent.self)?.name)!)
            print((char.component(ofType: AtackComponent.self)?.atackPoints)!)
            print((char.component(ofType: MovementComponent.self)?.speed)!)
            
            print(char.self)
        }
        
        registerView.alpha = 0
        
        
        super.viewDidLoad()
        //self.loadBattleScene()
        self.loadMainMenuScene()
        
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
    
    func loadMainMenuScene(){
        if let scene = GKScene(fileNamed: "MainMenuScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! MainMenuScene? {
                
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


     // MARK: Load Battle Scene
    
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
