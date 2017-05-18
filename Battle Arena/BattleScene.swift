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
    
    var characters : [CharacterCard] = []
    
    override func didMove(to view: SKView) {
        
        
    }
    
    //runs twice when scene loads, why??
    override func sceneDidLoad() {
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
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
        
    }
    
    func summonCharacter(type: Int, id: Int, team: Int){
        let character = CharacterCard(image: #imageLiteral(resourceName: "Spaceship"), name: "Char\(id)", cardDescription: "Will be obtained from db", manaCost: type, summoningTime: 1, level: 1, xp: 0, atackPoints: type * 10, atackSpeed: 5 - type, atackArea: 1, atackRange: 100.0 - CGFloat(type*10), speed: 10, healthPoints: 50*type, battleScene: self, teamId: team)
        
    }
}
