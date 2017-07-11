//
//  VideoScene.swift
//  X-Fighter
//
//  Created by user on 2017/7/11.
//  Copyright © 2017年 long. All rights reserved.
//

import Foundation
import SpriteKit

class VideoScene: SKScene {
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.blue
        
        let videoNode = SKVideoNode(fileNamed: "Sample.m4v")
        videoNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        videoNode.size = self.frame.size
        self.addChild(videoNode)
        
        videoNode.play()
    }
}
