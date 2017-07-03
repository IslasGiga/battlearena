//
//  CharacterCard.swift
//  Battle Arena
//
//  Created by Islas Girão Garcia on 09/05/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import GameplayKit
import SpriteKit
import AVFoundation

enum States {
    case idle
    case atack
    case move
    case dead
}


class CharacterCard: Card {
    
    //state machine
    var state : States = .idle
    
    //Card Character SpriteNode
    var spriteNode : SKSpriteNode!
    
    
    //the team identifier of the monster
    var teamId : Int!
    
    //reference to the game scene
    var battleScene : BattleScene!
    
    //moving flag
    var isNotBusy : Bool = true
    
    //LifeBarSprite
    var lifeBar : LifeBar?
    
    let audioPlayer = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: "\(Bundle.main.resourcePath!)/arrow.wav"))


    var cardImage : UIImage!
    
    var atackEffect : String!
    
    init(image: UIImage, name: String, cardDescription: String, manaCost: Int, summoningTime: Int, level: Int, xp: Int, atackPoints: Int, atackSpeed: CGFloat, atackArea: Int, atackRange: CGFloat, speed: Int, healthPoints: Int , battleScene: BattleScene, teamId: Int, cardImage: UIImage, atackEffect: String) {
        
        
        super.init(image: image,
                   name: name,
                   cardDescription: cardDescription,
                   manaCost: manaCost,
                   summoningTime: summoningTime,
                   level: level,
                   xp: xp)
        
        self.atackEffect = atackEffect
        
        self.addComponent(AtackComponent(atackPoints: atackPoints, atackSpeed: atackSpeed, atackArea: atackArea, atackRange: atackRange))
        
        self.addComponent(MovementComponent(speed: speed))
        
        self.addComponent(HealthComponent(healthPoints: healthPoints))
        
        self.addComponent(TargetIndexComponent())
        
        self.battleScene = battleScene
        
        self.spriteNode = SKSpriteNode(imageNamed: "character")
        
        self.cardImage = cardImage
        
        self.spriteNode.texture = SKTexture(image: image)
        
        self.teamId = teamId
        
        //MARK: Setting character life bar
        self.lifeBar = LifeBar(forCharacter: self)
        
        self.spriteNode.addChild(self.lifeBar!)
        
    }
    
//    init(abstractCard: AbstractCharacterCard, battleScene: BattleScene, teamId: Int) {
//        super.init(image: abstractCard.image,
//                   name: abstractCard.name,
//                   cardDescription: abstractCard.cardDescription,
//                   manaCost: abstractCard.manaCost,
//                   summoningTime: abstractCard.summoningTime,
//                   level: abstractCard.level,
//                   xp: abstractCard.xp)
//        
//        self.addComponent(AtackComponent(atackPoints: abstractCard.attackPoints,
//                                         atackSpeed: abstractCard.attackSpeed,
//                                         atackArea: abstractCard.attackArea,
//                                         atackRange: abstractCard.attackRange))
//        
//        self.addComponent(MovementComponent(speed: abstractCard.speed))
//        self.addComponent(HealthComponent(healthPoints: abstractCard.healthPoints))
//        self.addComponent(TargetIndexComponent())
//        
//        self.battleScene = battleScene
//        
//        self.spriteNode = SKSpriteNode(imageNamed: "character")
//        
//        if teamId == 1{
//            self.spriteNode.color = UIColor.lightGray
//        }
//        
//        self.spriteNode.texture = SKTexture(image: abstractCard.image)
//        
//        self.teamId = teamId
//        
//        //MARK: Setting character life bar
//        self.lifeBar = LifeBar(forCharacter: self)
//        
//        self.spriteNode.addChild(self.lifeBar!)
//        
//    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //suport function for calculating distance between two characters
    func distanceFromCharacter(character: CharacterCard)-> CGFloat{
        var x, y : CGFloat
        x = character.spriteNode.position.x - self.spriteNode.position.x
        y = character.spriteNode.position.y - self.spriteNode.position.y
        return CGFloat(sqrt(x*x + y*y))
    }
    
    func findNearestTargetAndAtack(){
        let characters = self.battleScene.characters
        for i in 0..<characters.count {
            if characters[i].teamId != self.teamId && characters[i].state != .dead {
                self.state = .atack
                if let target = self.component(ofType: TargetIndexComponent.self)?.targetIndex {
                    if distanceFromCharacter(character: characters[i]) < distanceFromCharacter(character: characters[target]){
                        self.component(ofType: TargetIndexComponent.self)?.targetIndex = i
                    }
                }else{
                    self.component(ofType: TargetIndexComponent.self)?.targetIndex = i
                }
            }
        }
        
        
        
        
    }
    
    //character moves towards target it's speed por 0.2 seconds
    func moveTowardsTarget(_ target: CharacterCard){
        if distanceFromCharacter(character: target) > (self.component(ofType: AtackComponent.self)?.atackRange)!{
            if self.isNotBusy{
                self.isNotBusy = false
                let angle = atan2(target.spriteNode.position.x - self.spriteNode.position.x, target.spriteNode.position.y - self.spriteNode.position.y)
                let xOffset = CGFloat((self.component(ofType: MovementComponent.self)?.speed)!) * sin(angle)
                let yOffset = CGFloat((self.component(ofType: MovementComponent.self)?.speed)!) * cos(angle)
                
                //Mark: Animated Moviment Insertion
                //self.animateMoviment()
                self.animateWalk()
                
                self.spriteNode.run(SKAction.moveBy(x: xOffset, y: yOffset, duration: 0.2), completion: {self.isNotBusy = true} )
            }
            
        }
    }
    
    
    func getManaCost()->CGFloat{
        let manaCost = CGFloat((self.component(ofType: InfoCardComponent.self)?.manaCost)!)
        return manaCost
    }
    
    func atack(){
        if self.isNotBusy{
            self.isNotBusy = false
            if let target = self.component(ofType: TargetIndexComponent.self)?.targetIndex {
                let enemie = self.battleScene.characters[target]
                let atackTime = (self.component(ofType: AtackComponent.self)?.atackSpeed)!
                //MARK: Add switch case for kind of atack
                //animateAtack() make character sprite animation on atack
                
//                let atackSprite = SKSpriteNode(color: UIColor.red, size: CGSize(width: 5, height: 5))
//                atackSprite.position = self.spriteNode.position
//                atackSprite.zPosition = 5
//                self.battleScene.addChild(atackSprite)
                
                audioPlayer?.play()
//                
//                let atackTarget = self.battleScene.characters[target].spriteNode.position
//                atackSprite.run(SKAction.move(to: atackTarget, duration: TimeInterval(atackTime)), completion: {
//                    atackSprite.removeFromParent()
//                })
                
//                particleAtack(sksName: "Fireball.sks", particleName: "fireball", target: self.battleScene.characters[target])
                
                animateAtack()
                
                //MARK: Isso é pura gambearra!!! TODO: FIX
                self.spriteNode.run(SKAction.scale(by: 1, duration: TimeInterval(atackTime)), completion: {
                    enemie.component(ofType: HealthComponent.self)?.healthPoints -= (self.component(ofType: AtackComponent.self)?.atackPoints)!
                    enemie.lifeBar?.take(damage: (self.component(ofType: AtackComponent.self)?.atackPoints)!)
                    
                    if (enemie.component(ofType: HealthComponent.self)?.healthPoints)! <= 0 {
                        self.state = .idle
                        self.component(ofType: TargetIndexComponent.self)?.targetIndex = nil
                    }
                    self.isNotBusy = true
                })
                
                
            }
        }
    }
    
    func projectileAtack(projectileName: String, target: Int){
        let atackSprite = SKSpriteNode(imageNamed: projectileName)
        atackSprite.position = self.spriteNode.position
        atackSprite.zPosition = 5
        self.battleScene.addChild(atackSprite)
        let atackTime = (self.component(ofType: AtackComponent.self)?.atackSpeed)!
        let atackTarget = self.battleScene.characters[target].spriteNode.position
        atackSprite.run(SKAction.move(to: atackTarget, duration: TimeInterval(atackTime)), completion: {
            atackSprite.removeFromParent()
        })
    }
    
    func particleAtack(sksName: String, particleName: String, target: CharacterCard){
        let angle = atan2(target.spriteNode.position.x - self.spriteNode.position.x, target.spriteNode.position.y - self.spriteNode.position.y)
        print(angle)
    }
    
    func animateAtack(){
        let targetIndex = self.component(ofType: TargetIndexComponent.self)?.targetIndex
        let target = self.battleScene.characters[targetIndex!].spriteNode.position
        //let angle = atan2(target.x - self.spriteNode.position.x, target.y - self.spriteNode.position.y)
        
        
        if let particle = SKEmitterNode(fileNamed: "\(self.atackEffect!).sks"){
            particle.position = self.spriteNode.position
            particle.removeFromParent()
            particle.emissionAngle = (CGFloat.pi/2) * quad()
            particle.emissionAngleRange = 0
            
            let effectNode = SKEffectNode()
            effectNode.addChild(particle)
            self.battleScene.addChild(effectNode)
            particle.run(SKAction.move(to: target, duration: 1), completion: {
                particle.removeFromParent()
            })
        }else if self.atackEffect != "" {
            let sprite = SKSpriteNode(imageNamed: self.atackEffect)
            sprite.position = self.spriteNode.position
            sprite.run(SKAction.rotate(byAngle: self.angle() - CGFloat.pi/2 , duration: 0))
            sprite.removeFromParent()
            self.battleScene.addChild(sprite)
            sprite.setScale(0.4)
            sprite.run(SKAction.move(to: target, duration: 1), completion: {
                sprite.removeFromParent()
            })
        }

    }
    
    func quad() -> CGFloat {
        let targetIndex = self.component(ofType: TargetIndexComponent.self)?.targetIndex
        let target = self.battleScene.characters[targetIndex!].spriteNode.position
        let pos = self.spriteNode.position
        
        let x = target.x - pos.x
        let y = target.y - pos.x
        
        if x >= 0.0 {
            if y >= 0.0 {
                return 0.0
            }else{
                return 3.0
            }
        }else{
            if y >= 0.0 {
                return 1.0
            }else{
                return 2.0
            }
        }
        
    }
    
    func angle() -> CGFloat {
        let targetIndex = self.component(ofType: TargetIndexComponent.self)?.targetIndex
        let target = self.battleScene.characters[targetIndex!].spriteNode.position
        let pos = self.spriteNode.position
        
        let x = target.x - pos.x
        let y = target.y - pos.y
        
        return CGFloat(atan2f(Float(y), Float(x)))
    }
    
    func direction() -> String {
        let targetIndex = self.component(ofType: TargetIndexComponent.self)?.targetIndex
        let target = self.battleScene.characters[targetIndex!].spriteNode.position
        let pos = self.spriteNode.position
        
        let x = target.x - pos.x
        let y = target.y - pos.x
        
        if x > 10.0 {
            if y > 10.0{
                return "NE"
            }else if y < -10.0 {
                return "NW"
            }else{
                return "N"
            }
        }else if x < 0.0 {
            if y > 10.0{
                return "SE"
            }else if y < -10.0 {
                return "SW"
            }else{
                return "S"
            }
        }else{
            if y > 10.0{
                return "E"
            }else if y < -10.0 {
                return "W"
            }else{
                return "N"
            }
        }
        
    }
    
    
    //deprecated
//    func animateMoviment(){
//        DispatchQueue.main.async {
//            let name = (self.component(ofType: InfoCardComponent.self)?.name)!
//            if let moveAnimation = SKAction(named: "\(name)Walk\(self.direction())"){
//                self.spriteNode.run(moveAnimation)
//            }
//        }
//        
//    }
    
    func animateWalk(){
        DispatchQueue.main.async {
            let name = (self.component(ofType: InfoCardComponent.self)?.name)!
            if let moveAnimation = self.battleScene.moveAnimations["\(name)\(self.direction())"] {
                self.spriteNode.run(moveAnimation)
            }
        }
    }
    
    //MARK: Function called for each character at the scene update for they to take actions based on their state
    func takeAction(){
        let characters : [CharacterCard] = self.battleScene.characters
        if (self.component(ofType: HealthComponent.self)?.healthPoints)! <= 0 {
            self.state = .dead
            
        }else{
            if let target = self.component(ofType: TargetIndexComponent.self)?.targetIndex {
                if (characters[target].component(ofType: HealthComponent.self)?.healthPoints)! <= 0 {
                    self.component(ofType: TargetIndexComponent.self)?.targetIndex = nil
                    self.state = .idle
                }
            }
        }
        
        switch self.state {
        case .idle:
            //            print("\(self.monsterName) \(self.id) is idle")
            //Islas: Aqui pode ser onde reseta a imagem pra uma parada ou uma animação de respirando, mas acho q ela só seria vista se parassemos tudo no fim do jogo
            self.findNearestTargetAndAtack()
        case .atack:
            let target = (self.component(ofType: TargetIndexComponent.self)?.targetIndex)!
            //print("\(self.monsterName) \(self.id) is atacking")
            if distanceFromCharacter(character: characters[target]) <= (self.component(ofType: AtackComponent.self)?.atackRange)! {
                //thow atack
                
                //print("\(self.monsterName) \(self.id) atacks \(monsters[self.target!].monsterName) \(monsters[self.target!].id)")
                
                
                //Islas: colocar dentro da função atack a animação de ataque
                self.atack()
                
            }else{
                self.state = .move
            }
        case .move:
            self.findNearestTargetAndAtack()
            
            
            
            //print("\(self.monsterName) \(self.id) is moving")
            let target = (self.component(ofType: TargetIndexComponent.self)?.targetIndex)!
            
           
            self.moveTowardsTarget(characters[target])
        case .dead:
            //print("\(self.monsterName) \(self.id) is dead")
            
            //
            //MARK: maybe this needs a flag for not repeating
            //
            //Islas: Animar morte aqui, para garantir que a animação não será interrompida e coloca pra ser removido do parent no fim da animação com um completion handler da animação. Acho q tem q fazer uma flag pra isso não se repetir tbm
            self.spriteNode.removeFromParent()
        }
    }
    
}
