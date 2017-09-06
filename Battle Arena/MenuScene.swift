//
//  MenuScene.swift
//  Battle Arena
//
//  Created by Felipe Borges on 19/06/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class MenuScene: SKScene {
    
    var fractionShown: Group = .battleGroup
    
    var initialFractionNodes = [SKSpriteNode]()
    
    var inventoryNode: SKNode?
    var storeNode: SKNode?
    var menuGroup: SKNode?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
       // addAlertView(with: "New player", and: "Insert your name so we can register you")
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "setAlertControllerNotification"), object: nil)
        
        //  testing
        
//        let node = childNode(withName:  "inventoryGroup")
//        let action = SKAction.moveTo(x: 0, duration: 1)
//        action.timingMode = .easeInEaseOut
//        
//        node?.run(action)
        
        
    }
    
    
    
    func loadRegisterView() {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let listOfNodes = nodes(at: touch.location(in: self))
        
        
        
        for node in listOfNodes {
        
            if node.name == "singleplayerButton" {
                if let scene = GKScene(fileNamed: "BattleScene") {
                    
                // Get the SKScene from the loaded GKScene
                    if let sceneNode = scene.rootNode as! BattleScene? {
                    
                    // Copy gameplay related content over to the scene
                    
                    // Set the scale mode to scale to fit the window
                        sceneNode.scaleMode = .aspectFill
                    // Present the scene
                        view?.presentScene(sceneNode)
                    }
                }
            }
            
            if node.name == "multiplayerButton" {
                alert(title: "Unavailable", message: "This game mode is not available yet!")
            }
            
            if (node.name == "inventoryButton" || node.name == "battleButton" || node.name == "storeButton") {
                let group = MenuScene.GroupFromString(string: (node.name?.replacingOccurrences(of: "Button", with: "Group"))!)
                
                if let group = group {
                    switchView(fractionToShow: group)
                }
            }
        }
    }
    
    func switchView(fractionToShow: Group) {
        if fractionShown == fractionToShow { return }
        
        if fractionShown.rawValue < fractionToShow.rawValue {
            moveGroupsToLeft(shown: fractionShown, toShow: fractionToShow)
        } else {
            moveGroupsToRight(shown: fractionShown, toShow: fractionToShow)
        }
        
        fractionShown = fractionToShow
    }
    
    func moveGroupsToLeft(shown: Group, toShow: Group) {
        let shownAction = SKAction.moveTo(x: -750, duration: 0.4)
        shownAction.timingMode = .easeInEaseOut
        
        let toShowAction = SKAction.moveTo(x: 0, duration: 0.4)
        toShowAction.timingMode = .easeInEaseOut
        
        let shownNode = childNode(withName: "\(shown)")
        let toShowNode = childNode(withName: "\(toShow)")
        
        shownNode?.run(shownAction)
        toShowNode?.run(toShowAction)
    }
    
    func moveGroupsToRight(shown: Group, toShow: Group) {
        let shownAction = SKAction.moveTo(x: 750, duration: 0.4)
        shownAction.timingMode = .easeInEaseOut
        
        let toShowAction = SKAction.moveTo(x: 0, duration: 0.4)
        toShowAction.timingMode = .easeInEaseOut
        
        let shownNode = childNode(withName: "\(shown)")
        let toShowNode = childNode(withName: "\(toShow)")
        
        shownNode?.run(shownAction)
        toShowNode?.run(toShowAction)
    }
    
    static func GroupFromString(string: String) -> Group? {
        var i = 0
        while let item = Group(rawValue: i) {
            if String(describing: item) == string { return item }
            i += 1
        }
        return nil
    }
    
    func alert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

enum Group: Int {
    case inventoryGroup = 0
    case battleGroup = 1
    case storeGroup = 2
}
