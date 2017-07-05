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
        sprite.xScale = 0.1
        sprite.yScale = 0.1
        sprite.position = CGPoint(x: self.frame.width / 2.0, y: self.frame.height / 2.0)
        
        self.addChild(sprite)
        
        let bulletSprite = self.createBulletSprite(at: sprite.position)
        let moveAction = SKAction.move(to: CGPoint(x: sprite.position.x, y: self.frame.height), duration: 0.6)
        self.addChild(bulletSprite)
        
        let remove = SKAction.removeFromParent()
        bulletSprite.run(SKAction.sequence([moveAction, remove]))
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
    }
    
    func fire() {
        if let sprite = self.childNode(withName: "SpaceShip") {
            let bulletSprite = self.createBulletSprite(at: sprite.position)
            self.addChild(bulletSprite)
            
            let moveAction = SKAction.move(to: CGPoint(x: sprite.position.x, y: self.frame.height), duration: 0.6)
            let remove = SKAction.removeFromParent()
            bulletSprite.run(SKAction.sequence([moveAction, remove]))
        }
    }
    
    func createBulletSprite(at position: CGPoint) -> SKSpriteNode {
        let bulletSprite = SKSpriteNode(imageNamed:"bullet_type_1")

        bulletSprite.xScale = 0.2
        bulletSprite.yScale = 0.2
        bulletSprite.position = position
        
        return bulletSprite
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       /* Called when a touch begins */
        for touch in touches {
            let location = touch.location(in: self)
            if let sprite = self.childNode(withName: "SpaceShip") {
                let action = SKAction.move(to: location, duration: 0.6)
                sprite.run(SKAction.repeatForever(action))
            }
        }
    }
   
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
