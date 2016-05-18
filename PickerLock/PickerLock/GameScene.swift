//
//  GameScene.swift
//  PickerLock
//
//  Created by 藤井陽介 on 2016/05/18.
//  Copyright (c) 2016年 touyou. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var Circle = SKSpriteNode()
    var Person = SKSpriteNode()
    
    var Path = UIBezierPath()
    
    var gameStarted = Bool()
    
    var movingClockWise = Bool()
    
    
    override func didMoveToView(view: SKView) {
        
        Circle = SKSpriteNode(imageNamed: "Circle")
        Circle.size = CGSize(width: 300, height: 300)
        Circle.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        Person = SKSpriteNode(imageNamed: "Person")
        Person.size = CGSize(width: 40, height: 7)
        Person.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + 124)
        Person.zRotation = 3.14 / 2
        
        self.addChild(Circle)
        
        self.addChild(Person)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if gameStarted {
            if movingClockWise {
                moveCounterClockWise()
                movingClockWise = false
            } else {
                moveClockWise()
                movingClockWise = true
            }
        } else {
            moveClockWise()
            movingClockWise = true
            gameStarted = true
        }
        
    }
    
    func moveClockWise() {
        
        let dx = Person.position.x - self.frame.width / 2
        let dy = Person.position.y - self.frame.height / 2
        
        let rad = atan2(dy, dx)
        
        Path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width / 2, y: self.frame.height / 2), radius: 124, startAngle: rad, endAngle: rad + CGFloat(M_PI * 4), clockwise: true)
        let follow = SKAction.followPath(Path.CGPath, asOffset: false, orientToPath: true, speed: 200)
        Person.runAction(SKAction.repeatActionForever(follow).reversedAction())
    
    }
    
    func moveCounterClockWise() {
        
        let dx = Person.position.x - self.frame.width / 2
        let dy = Person.position.y - self.frame.height / 2
        
        let rad = atan2(dy, dx)
        
        Path = UIBezierPath(arcCenter: CGPoint(x: self.frame.width / 2, y: self.frame.height / 2), radius: 124, startAngle: rad, endAngle: rad + CGFloat(M_PI * 4), clockwise: true)
        let follow = SKAction.followPath(Path.CGPath, asOffset: false, orientToPath: true, speed: 200)
        Person.runAction(SKAction.repeatActionForever(follow))
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
