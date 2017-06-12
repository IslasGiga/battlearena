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
    
    var enemy : AIEnemy?
    
    var entitvar = [GKEntity]()
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
    
    var loader: CardLoader?
    
    //Cards on character menu
    var cards : [SKSpriteNode] = []
    
    //Player Deck of Cards (as colors for testing)
    var deck : [CharacterCard] = []
    
    //current selected card
    var selectedCard = 5
    
    //time passed in game
    var gameTime : TimeInterval = 0.0
    
    //time control variable
    var preveousUpdateTime : TimeInterval = 0
    
    //all characters in game
    var characters : [CharacterCard] = [] 
    
    var gameOver = false
    
    let names = ["Dwarf",
                 "Cyclope",
                 "Elf",
                 "Priest",
                 "Satyr",
                 "Mummy",
                 "Knight",
                 "Wizard"]
    
    //MARK: SceneDidLoad/DidMoveToScene
    
    override func didMove(to view: SKView) {

        loader = CardLoader(scene: self)


        //loading battle space, mana and menu elements
        loadUI()
        
        //loading Towers
        loadTowers()
        
        //loading Cards on menu
        loadCards()
        

        enemy = AIEnemy(game: self)

        
    }
    
    //runs twice when scene loads, why??
    override func sceneDidLoad() {
    }
    
    
    //MARK: Touch Responses
    func touchDown(atPoint pos : CGPoint) {
        if (self.battleNode?.contains(pos))! {
            if self.selectedCard != 5{
                summonCharacter(type: self.selectedCard + 1 , id: self.nextCharId, team: 0, pos: pos)
                
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
                for i in 0...3 {
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
                if node.name == "OKButtonCover"{
                    playAgain()
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
    
    
    func playAgain(){
        if let scene = GKScene(fileNamed: "BattleScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! BattleScene? {
                
                // Copy gameplay related content over to the scene
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                // Present the scene
                if let view = self.view {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }
    
    //MARK: Scene Update
    override func update(_ currentTime: TimeInterval) {
        
        //What happens inside this if stops when game is over
        if !gameOver {
            checkGameEnd()
            
            updateGameTime(currentTime)
            
            //update charactes actions
            for character in characters {
                character.takeAction()
            }
            
            enemy?.playStrategy(atIndex: enemy!.pickStrategy() )
        }
        
        updateMana(currentTime)
        
    }
    

    //keeps track of time in game, updates gameTime atribute with time spent since the game start
    func updateGameTime(_ currentTime: TimeInterval){
        if self.preveousUpdateTime == 0{

            self.preveousUpdateTime = currentTime
        }
        self.gameTime += currentTime - self.preveousUpdateTime
        self.preveousUpdateTime = currentTime
    }
    

    //increses mana and mana bar over time
    func updateMana(_ currentTime: TimeInterval){

        if (self.manaUpdateTime == 0) {
            self.manaUpdateTime = currentTime
        }else{
            if currentTime - self.manaUpdateTime >= 1 && !self.manaUpadateFlag {
                if self.mana < 100.0 {
                    self.manaUpadateFlag = true
                    self.manaBar?.run(SKAction.resize(byWidth: 0, height: 20, duration: 1), completion: {
                        self.mana += 10.0
                        self.manaUpdateTime = 0
                        self.manaUpadateFlag = false
                    })
                }
                if self.enemy!.mana < 100.0 {
                    self.enemy?.mana += 10.0
                    self.manaUpdateTime = 0
                }
                
            }
        }
    }
    
    
    //MARK: Summon Character function
    func summonCharacter(type: Int, id: Int, team: Int, pos: CGPoint) {
        
        let character = CharacterCard(image: #imageLiteral(resourceName: "character"), name: "CharType:\(type) id:\(id)", cardDescription: "Will be obtained from db", manaCost: type, summoningTime: 1, level: 1, xp: 0, atackPoints: type * 10, atackSpeed: (5.0 - CGFloat(type))*0.25, atackArea: 1, atackRange: 100.0 - CGFloat(type*10), speed: 10, healthPoints: 50*type, battleScene: self, teamId: team)
        let manaCost = character.getManaCost()*10.0
        if self.mana >= manaCost {
            self.characters.append(character)
            character.spriteNode.position = pos
            self.addChild(character.spriteNode)
            self.nextCharId += 1
            
            
            
            self.mana -= manaCost
            self.manaBar?.run(SKAction.resize(byWidth: 0, height: -manaCost*2, duration: 0.5))
            
            let object = deck[self.selectedCard]
            
            if self.selectedCard != 5 {
                //unselect card
                self.cards[selectedCard].run(SKAction.moveBy(x: 0, y: -12, duration: 0), completion: {
                    //TO DO: animate card changes
                })
                self.selectedCard = 5
            }
            
            
            deck.remove(at: deck.index(of: object)!)
            deck.append(object)
            
            loadMenuCards()
            
            
            
            
        } else {
            print("not enough mana")
        }
    }
    
    
    //MARK: Load UI
    func loadUI() {
        if let menuScene = SKScene(fileNamed: "MenuScene") {
            let newNode = menuScene.childNode(withName: "themenu")
            newNode?.removeFromParent()
            self.addChild(newNode!)
            
            
            for i in 0...4 {
                if let cardNode = newNode!.childNode(withName: "Card\(i)") as? SKSpriteNode{
                    self.cards.append(cardNode)
                }
                
            }
            
            if let battleNode = menuScene.childNode(withName: "BattleArea") as? SKSpriteNode {
                self.battleNode = battleNode
                self.battleNode?.color = UIColor.clear
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
    
    //MARK: Instance Towers
    func loadTowers(){
        //Default Range for all towers
        let towerRange = self.battleNode!.size.width/3
        
        //Primary Towers
        let primaryTowerA = PrimaryTower(image: #imageLiteral(resourceName: "turret"), name: "PrimaryTower", cardDescription: "You lose if this tower gets destroyed", manaCost: 0, summoningTime: 0, level: 1, xp: 0, atackPoints: 25, atackSpeed: 0.5, atackArea: 1, atackRange: towerRange, speed: 0, healthPoints: 2000, battleScene: self, teamId: 0)
        primaryTowerA.spriteNode.position = self.battleNode!.position
        primaryTowerA.spriteNode.position.y -= self.battleNode!.size.height/2 - primaryTowerA.spriteNode.size.height/2
        primaryTowerA.spriteNode.zPosition = 3
        self.characters.append(primaryTowerA)
        self.addChild(primaryTowerA.spriteNode)
        
        let primaryTowerB = PrimaryTower(image: #imageLiteral(resourceName: "turret"), name: "PrimaryTower", cardDescription: "You lose if this tower gets destroyed", manaCost: 0, summoningTime: 0, level: 1, xp: 0, atackPoints: 25, atackSpeed: 0.5, atackArea: 1, atackRange: towerRange, speed: 0, healthPoints: 2000, battleScene: self, teamId: 1)
        primaryTowerB.spriteNode.position = self.battleNode!.position
        primaryTowerB.spriteNode.position.y += self.battleNode!.size.height/2 - primaryTowerB.spriteNode.size.height/2
        primaryTowerB.spriteNode.zPosition = 3
        self.characters.append(primaryTowerB)
        self.addChild(primaryTowerB.spriteNode)
        
        for i in 0...2{
            let secundaryTower = SecundaryTower(image: #imageLiteral(resourceName: "turret"), name: "SecundaryTower", cardDescription: "Main sefenses of your territory", manaCost: 0, summoningTime: 0, level: 1, xp: 0, atackPoints: 20, atackSpeed: 0.5, atackArea: 1, atackRange: towerRange, speed: 0, healthPoints: 1000, battleScene: self, teamId: 0)
            
            secundaryTower.spriteNode.position = self.battleNode!.position
            secundaryTower.spriteNode.position.y -= self.battleNode!.size.height/2 - 4 * primaryTowerA.spriteNode.size.height/2
            secundaryTower.spriteNode.zPosition = 3
            
            secundaryTower.spriteNode.position.x -= CGFloat(1 - i) * self.battleNode!.size.width / 3
            
            self.characters.append(secundaryTower)
            self.addChild(secundaryTower.spriteNode)
        }
        
        for i in 0...2{
            let secundaryTower = SecundaryTower(image: #imageLiteral(resourceName: "turret"), name: "SecundaryTower", cardDescription: "Main sefenses of your territory", manaCost: 0, summoningTime: 0, level: 1, xp: 0, atackPoints: 20, atackSpeed: 0.5, atackArea: 1, atackRange: towerRange, speed: 0, healthPoints: 1000, battleScene: self, teamId: 1)
            
            secundaryTower.spriteNode.position = self.battleNode!.position
            secundaryTower.spriteNode.position.y += self.battleNode!.size.height/2 - 4 * primaryTowerA.spriteNode.size.height/2
            secundaryTower.spriteNode.zPosition = 3
            
            secundaryTower.spriteNode.position.x -= CGFloat(1 - i) * self.battleNode!.size.width / 3
            
            self.characters.append(secundaryTower)
            self.addChild(secundaryTower.spriteNode)
        }
    }
    
    //check for game end conditions
    func checkGameEnd(){
        if !gameOver{
            if characters[1].state == .dead{
                presentResult("BattleEndWin")
            }else if characters[0].state == .dead {
                presentResult("BattleEndLose")
            }else if self.gameTime >= 180 {
                var scoreA = 0
                var scoreB = 0
                for i in 2...4{
                    if characters[i].state == .dead {
                        scoreB += 1
                    }
                    if characters[i+3].state == .dead{
                        scoreA += 1
                    }
                }
                if scoreA > scoreB {
                    presentResult("BattleEndWin")
                }
                if scoreB > scoreA {
                    presentResult("BattleEndLose")
                }
            }
            if self.gameTime >= 240 {
                presentResult("BattleEndWin")
            }
        }
    }
    
    //Shows End of game Menu
    func presentResult(_ result: String){
        gameOver = true
        if let endScene = SKScene(fileNamed: result){
            if let endNode = endScene.childNode(withName: "EndScreen") {
                endNode.removeFromParent()
                endNode.setScale(0)
                endNode.position.y += 50
                self.addChild(endNode)
                endNode.run(SKAction.scale(to: 0.4, duration: 1), completion: {})
                //endNode.run(SKAction.playSoundFileNamed("EndGameSound", waitForCompletion: false))
                
            }
        }
    }
    
    func loadCards(){
        
        for value in names {
            let load = loader?.load(name: value, type: .character)
            if let load = load {
                let card = load as! CharacterCard
                deck.append(card)
            }
        }
        
        loadMenuCards()
    }
    
    func loadMenuCards(){
        for i in 0...4{
            cards[i].texture = deck[i].spriteNode.texture
        }
    }
    
    func spawnCharacter(fromCard card: CharacterCard, atPosition pos: CGPoint, team: Int){
        if let name = String((card.component(ofType: InfoCardComponent.self)?.name)!) {
            let cardLoader = CardLoader(scene: self)
            if let card = cardLoader.load(name: name, type: .character) as? CharacterCard{
                card.teamId = team
                card.spriteNode.position = pos
                card.component(ofType: InfoCardComponent.self)?.name = "\((card.component(ofType: InfoCardComponent.self)?.name)!)\(self.nextCharId)"
                self.nextCharId += 1
                self.characters.append(card)
                card.spriteNode.removeFromParent()
                self.addChild(card.spriteNode)
            }
        }
    }
    
    //MARK: Functions for AIEnemy measures
    
    func getAtackPosition() -> CGPoint{
        var lowerHpIndex = 0
        
        for i in 2...4 {
            let currentLowersHP = (self.characters[lowerHpIndex].component(ofType: HealthComponent.self)?.healthPoints)!
            let checkedHP = (self.characters[i].component(ofType: HealthComponent.self)?.healthPoints)!
            if checkedHP < currentLowersHP {
                lowerHpIndex = i
            }
        }
        
        var pos = self.battleNode!.position
        pos.y += 25
        
        if lowerHpIndex == 2 {
            pos.x -= self.battleNode!.size.width / 4
        }
        
        if lowerHpIndex == 4 {
            pos.x += self.battleNode!.size.width / 4
        }
        
        return pos
    }
    
    //returns a point near to the closest turrent to an enemy
    func getDefensePosition() -> CGPoint{
        var pos = CGPoint(x: 0, y: 0)
        
        if let enemyAtacker = playerAliveCharacter() {
            let atackedTowerIndex = nearestTower(toCharacter: enemyAtacker)
            pos = self.characters[atackedTowerIndex].spriteNode.position
            pos.x += 20
            pos.y -= 20
        }
        
        return pos
    }
    
    //return a point to summon a character to gank an atack
    func getGankPosition() -> CGPoint?{
        var pos : CGPoint
        if let gankableCharacter = playerAliveGankableCharacter() {
            let closestTurrent = self.characters[nearestTower(toCharacter: gankableCharacter)]
            pos = closestTurrent.spriteNode.position
            pos.x += 20
            pos.y -= 10
            return pos
        }
        
        return nil
    }
    
    //returns a player alive character or nil in case of unexistent
    func playerAliveCharacter() -> CharacterCard? {
        if self.characters.count > 8 {
            for i in 8...(self.characters.count - 1) {
                if isPlayerCharacterAndAlive(character: self.characters[i]) {
                    return self.characters[i]
                }
            }
        }
        return nil
    }
    
    //return an enemy's alive character if any or nil
    func enemyAliveCharacter() -> CharacterCard? {
        if self.characters.count > 8 {
            for i in 8...(self.characters.count - 1) {
                if isEnemyCharacterAndAlive(self.characters[i]) {
                    return self.characters[i]
                }
            }
        }
        return nil
    }
    
    func isEnemyCharacterAndAlive(_ character: CharacterCard) -> Bool{
        return character.state != .dead && character.teamId == 1
    }
    
    //verufies if characer is alive and in the players team
    func isPlayerCharacterAndAlive(character: CharacterCard) -> Bool{
        return character.state != .dead && character.teamId == 0
    }
    
    //verifies if character is close enought to a tourrent for a gank
    func isPlayerCharacterGankable(character: CharacterCard) -> Bool{
        var closeToATurrent = false
        
        let nearestTurretIndex = nearestTower(toCharacter: character)
        let nearestTurret = self.characters[nearestTurretIndex]
        let nearestTurretRange =  (nearestTurret.component(ofType: AtackComponent.self)?.atackRange)!
        if character.distanceFromCharacter(character: nearestTurret) < nearestTurretRange + 50.0 {
            closeToATurrent = true
        }
        
        return isPlayerCharacterAndAlive(character: character) && closeToATurrent
    }
    
    //return a gankable character or nill in inexistance
    func playerAliveGankableCharacter() -> CharacterCard? {
        var char : CharacterCard? = nil
        if self.characters.count > 8 {
            for i in 8...self.characters.count - 1 {
                if isPlayerCharacterGankable(character: self.characters[i]) {
                    char = self.characters[i]
                }
            }
        }
        
        return char
    }
    
    //return enemy tower index closest to the character
    func nearestTower(toCharacter character: CharacterCard) -> Int {
        var closest = 1
        for i in 5...7 {
            if character.distanceFromCharacter(character: self.characters[i]) < character.distanceFromCharacter(character: self.characters[closest]){
                closest = i
            }
        }
        return closest
    }
}
