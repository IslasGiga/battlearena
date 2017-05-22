//
//  GameScene.swift
//  Battle Arena
//
//  Created by Islas Girão Garcia on 08/05/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import SpriteKit
import GameplayKit

class BattleScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    
    //for identifying distincts character nodes
    var nextCharId = 0
    
    //battle area
    var battleNode : SKSpriteNode?
    
    //mana bar sprite
    var manaBar : SKSpriteNode?
    
    //current mana level percentage
    var mana : CGFloat = 70.0
    
    //for controlling mana bar
    var manaUpdateTime : TimeInterval = 0
    var manaUpadateFlag : Bool = false
    var maxManaSize : CGFloat = 200
    
    //Cards on character menu
    var cards : [SKSpriteNode] = []
    
    //current selected card
    var selectedCard = 5
    
    
    
    //all characters in game
    var characters : [CharacterCard] = []
    
    override func didMove(to view: SKView) {
        //loading battle space, mana and menu elements
        if let menuScene = SKScene(fileNamed: "MenuScene"){
            let newNode = menuScene.childNode(withName: "themenu")
            newNode?.removeFromParent()
            self.addChild(newNode!)
            
            for i in 0...4{
                if let cardNode = newNode!.childNode(withName: "Card\(i)") as? SKSpriteNode{
                    self.cards.append(cardNode)
                }
                
            }
            
            if let battleNode = menuScene.childNode(withName: "BattleArea") as? SKSpriteNode {
                self.battleNode = battleNode
                battleNode.removeFromParent()
                self.addChild(battleNode)
                
            }
            
            if let barNode = menuScene.childNode(withName: "Bar") as? SKSpriteNode{
                self.maxManaSize = barNode.size.height
                self.manaBar = barNode.childNode(withName: "Mana") as? SKSpriteNode
                barNode.removeFromParent()
                self.addChild(barNode)
            }
            
            
        }
        
    }
    
    //runs twice when scene loads, why??
    override func sceneDidLoad() {
        
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if (self.battleNode?.contains(pos))! {
            if self.selectedCard != 5{
                summonCharacter(type: self.selectedCard, id: self.nextCharId, team: 0, pos: pos)
                
            }else{
                summonCharacter(type: 2, id: self.nextCharId, team: 1, pos: pos)
            }
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
            let location = t.location(in: self)
            if let node : SKSpriteNode = self.atPoint(location) as? SKSpriteNode {
                for i in 1...4 {
                    if node.name == "Card\(i)"{
                        print("card\(i)")
                        if self.selectedCard != i {
                            if self.selectedCard != 5 {
                                self.cards[self.selectedCard].run(SKAction.moveBy(x: 0, y: -12, duration: 0.5))
                            }
                            self.selectedCard = i
                            self.cards[self.selectedCard].run(SKAction.moveBy(x: 0, y: 12, duration: 0.5))
                        }
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if (self.manaUpdateTime == 0) {
            self.manaUpdateTime = currentTime
        }else{
            if currentTime - self.manaUpdateTime >= 1 && self.mana < 100.0 && !self.manaUpadateFlag{
                self.manaUpadateFlag = true
                self.manaBar?.run(SKAction.resize(byWidth: 0, height: 20, duration: 1), completion: {
                    self.mana += 10.0
                    self.manaUpdateTime = 0
                    self.manaUpadateFlag = false
                })
            }
        }
        
        //update charactes actions
        for character in characters {
            character.takeAction()
        }
    }
    
    func summonCharacter(type: Int, id: Int, team: Int, pos: CGPoint){
        let character = CharacterCard(image: #imageLiteral(resourceName: "Spaceship"), name: "CharType:\(type) id:\(id)", cardDescription: "Will be obtained from db", manaCost: type, summoningTime: 1, level: 1, xp: 0, atackPoints: type * 10, atackSpeed: (5.0 - CGFloat(type))*0.25, atackArea: 1, atackRange: 100.0 - CGFloat(type*10), speed: 10, healthPoints: 50*type, battleScene: self, teamId: team)
        let manaCost = character.getManaCost()*10.0
        if self.mana >= manaCost {
            self.characters.append(character)
            character.spriteNode.position = pos
            self.addChild(character.spriteNode)
            self.nextCharId += 1
            self.mana -= manaCost
            self.manaBar?.run(SKAction.resize(byWidth: 0, height: -manaCost*2, duration: 0.5))
            
            if self.selectedCard != 5{
                //unselect card
                self.cards[selectedCard].run(SKAction.moveBy(x: 0, y: -12, duration: 0))
                self.selectedCard = 5
            }
        }else{
            print("not enough mana")
        }
        
    }
}
