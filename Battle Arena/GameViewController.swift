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
    
    
    
    @IBOutlet weak var playerNameTextField: UITextField!
 

    @IBAction func registerUser(_ sender: UIButton) {
        let name = playerNameTextField.text!
        
        UserDefaults.standard.set(name, forKey: "playerName")
        registerView.alpha = 0
    }
    
    @IBOutlet weak var registerView: UIView!
    
    @IBOutlet weak var confirmButtom: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        
        
        
//        self.loadBattleScene()
        //self.loadMainMenuScene()

        loadMenuScene()
        
        if !checkForExistingUser() {
            registerView.alpha = 1
        }
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
    
    func loadMenuScene(){
        if let scene = GKScene(fileNamed: "MenuuScene") {
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! MenuScene? {
                
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
    
    func prepareObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setAlertController),
                                               name: NSNotification.Name(rawValue: "setAlertControllerNotification"),
                                               object: nil)
    }
    
    func setAlertController() {
        print("HI I'M BORGEZ")
    }
    
//    func addAlertView(with title: String, and message: String) {
//        let alertController = UIAlertController(title: title,
//                                                message: message,
//                                                preferredStyle: .alert)
//        let viewController = self
//        
//        let registerAction = UIAlertAction(title: "Register", style: .default) { (action) in
//            
//            let text = alertController.textFields?[0].text
//            
//            if (text?.characters.count)! > 0 {
//                print("REGISTER")
//            } else {
//                let alert = UIAlertController(title: "Invalid name", message: "The name field is empty", preferredStyle: .alert)
//                
//            }
//            
//        }
//        
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        
//        alertController.addTextField { textField in
//            textField.placeholder = "Name"
//        }
//        
//        alertController.addAction(registerAction)
//        alertController.addAction(cancelAction)
//        
//        viewController.present(alertController, animated: true, completion: nil)
//        }
    
    func checkForExistingUser() -> Bool {
        let playerName = UserDefaults.standard.object(forKey: "playerName")
        
        return playerName != nil
    }
    

}


