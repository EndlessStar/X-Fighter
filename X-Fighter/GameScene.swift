//
//  GameScene.swift
//  X-Fighter
//
//  Created by long on 17/7/3.
//  Copyright (c) 2017年 long. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        /*
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!"
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
        myLabel.name = "HelloNode"
        
        self.addChild(myLabel)
        */
        
        let sprite = SKSpriteNode(imageNamed:"Spaceship")
        
        sprite.name = "SpaceShip"
        sprite.xScale = 0.3
        sprite.yScale = 0.3
        sprite.position = CGPoint(x: self.frame.width / 2.0, y: self.frame.height / 2.0)
        
        self.addChild(sprite)
        
        let light = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: 20.0, height: 20.0))
        light.zPosition = 50.0
        sprite.addChild(light)
        
        let bulletSprite = self.createBulletSprite(at: sprite.position)
        let moveAction = SKAction.move(to: CGPoint(x: sprite.position.x, y: self.frame.height), duration: 0.6)
        self.addChild(bulletSprite)
        
        let remove = SKAction.removeFromParent()
        bulletSprite.run(SKAction.sequence([moveAction, remove]))
        
        let makeBullets = SKAction.sequence([SKAction.perform(#selector(fire), onTarget: self),
                                           SKAction.wait(forDuration: 0.30, withRange: 0.15)])
        let makeRocks = SKAction.sequence([SKAction.perform(#selector(addRock), onTarget: self),
                                           SKAction.wait(forDuration: 0.10, withRange: 0.15)])
        
        self.run(SKAction.repeatForever(makeBullets))
        self.run(SKAction.repeatForever(makeRocks))
        
        self.addSwitchButton()
    }
    
    func fire() {
        if let sprite = self.childNode(withName: "SpaceShip") {
            let bulletSprite = self.createBulletSprite(at: sprite.position)
            bulletSprite.physicsBody = SKPhysicsBody(rectangleOf: bulletSprite.size)
            bulletSprite.physicsBody?.isDynamic = false
            self.addChild(bulletSprite)
            
            let moveAction = SKAction.move(to: CGPoint(x: sprite.position.x, y: self.frame.height), duration: 0.6)
            let remove = SKAction.removeFromParent()
            bulletSprite.run(SKAction.sequence([moveAction, remove]))
        }
    }
    
    func addSwitchButton() {
        let button = UIButton(frame: CGRect(x: 20, y: 20, width: 100, height: 20))
        button.setTitle("Switch", for: .normal)
        button.addTarget(self, action: #selector(clickSwitchButton(sender:)), for: .touchUpInside)
        self.view?.addSubview(button)
        
//        let ball = SKShapeNode(ellipseIn: CGRect(x: self.frame.midX, y: self.frame.midY, width: 100, height: 100))
//        ball.fillColor = UIColor.green
//        ball.strokeColor = UIColor.red
//        ball.lineWidth = 3.0
//        ball.glowWidth = 15.0
//        self.addChild(ball)
//        let switchLabel = SKLabelNode(text: "Switch")
//        switchLabel.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
//        switchLabel.fontName = "Chalkduster"
//        switchLabel.color = UIColor.red
//        switchLabel.fontSize = 30.0
//        switchLabel.zPosition = 1.0
//        self.addChild(switchLabel)
//
//        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
//        myLabel.text = "Hello, World!"
//        myLabel.fontSize = 20
//        myLabel.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
//        myLabel.name = "HelloNode"
//        self.addChild(myLabel)
    }
    
    func clickSwitchButton(sender: UIButton?) {
        let transition = SKTransition.fade(with: UIColor.red, duration: 2)
        let videoScene = VideoScene(size: self.size)
        
        transition.pausesOutgoingScene = false
        transition.pausesIncomingScene = false
        
        if self.view?.scene == self {
            self.view?.presentScene(videoScene, transition: transition)
        } else {
            self.view?.presentScene(self, transition: transition)
        }
    }
    
    func addRock() {
        let rock = SKSpriteNode(imageNamed: "meteorite_type_1")
        rock.position = CGPoint(x: CGFloat(drand48()) * self.frame.width, y: self.frame.height)
        rock.name = "Rock"
        rock.xScale = 0.5
        rock.yScale = 0.5
        rock.physicsBody = SKPhysicsBody(rectangleOf: rock.size)
        rock.physicsBody?.usesPreciseCollisionDetection = true
        self.addChild(rock)
    }
    
    override func didSimulatePhysics() {
        self .enumerateChildNodes(withName: "Rock") { (node, stop) in
            if (node.position.y < 0) {
                node.removeFromParent()
            }
        }
    }
    
    func createBulletSprite(at position: CGPoint) -> SKSpriteNode {
        let bulletSprite = SKSpriteNode(imageNamed:"bullet_type_1")

        bulletSprite.xScale = 0.2
        bulletSprite.yScale = 0.2
        bulletSprite.position = position
        
        return bulletSprite
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//       /* Called when a touch begins */
//        for touch in touches {
//            let location = touch.location(in: self)
//            if let sprite = self.childNode(withName: "SpaceShip") {
//                let action = SKAction.move(to: location, duration: 0.3)
//                sprite.run(SKAction.repeatForever(action))
//            }
//        }
//    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if let sprite = self.childNode(withName: "SpaceShip") {
                let action = SKAction.move(to: location, duration: 0.2)
                sprite.run(SKAction.repeatForever(action))
            }
        }
    }
   
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
