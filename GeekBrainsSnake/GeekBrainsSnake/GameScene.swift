//
//  GameScene.swift
//  GeekBrainsSnake
//
//  Created by Евгений Шварцкопф on 30/10/2019.
//  Copyright © 2019 Евгений Шварцкопф. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var snake: Snake?
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        view.showsPhysics = true
        
        physicsBody?.categoryBitMask = ColliderCategories.EdgeBody
        physicsBody?.collisionBitMask = ColliderCategories.Snake | ColliderCategories.SnakeHead
        
        
        let counterClockwise = SKShapeNode()
        counterClockwise.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        counterClockwise.position = CGPoint(x: view.scene!.frame.minX + 30, y: view.scene!.frame.minY + 30)
        counterClockwise.fillColor = .gray
        counterClockwise.name = "leftButton"
        
        let clockwise = SKShapeNode()
        clockwise.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        clockwise.position = CGPoint(x: view.scene!.frame.maxX - 30 - 45, y: view.scene!.frame.minY + 30)
        clockwise.fillColor = .gray
        clockwise.name = "rightButton"
        
        addChild(counterClockwise)
        addChild(clockwise)
        
        createApple()
        
        snake = Snake(position: CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY))
        addChild(snake!)
        
        
    }
    
    func createApple() {
        let x = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX - 5)))
        let y = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY - 5)))
        let apple = Apple(position: CGPoint(x: x, y: y))
        addChild(apple)
    }
    
    func createSnake() {
        snake = Snake(position: CGPoint(x: view!.scene!.frame.midX, y: view!.scene!.frame.midY))
        addChild(snake!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let node = atPoint(touchLocation) as? SKShapeNode,
                node.name == "leftButton" || node.name == "rightButton" else {
                    return
            }
            
            node.fillColor = .yellow
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let node = atPoint(touchLocation) as? SKShapeNode,
                node.name == "leftButton" || node.name == "rightButton" else {
                    return
            }
            
            node.fillColor = .gray
            
            if node.name == "leftButton" {
                moveLeft()
            } else {
                moveRight()
            }
        }
        
    }
    
    func moveLeft() {
        snake?.angle -= CGFloat(Double.pi / 2)
    }
    
    func moveRight() {
        snake?.angle += CGFloat(Double.pi / 2)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        snake?.move()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodies = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        let unknownObject = bodies ^ ColliderCategories.SnakeHead
        
        switch unknownObject {
        case ColliderCategories.Apple:
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            snake?.addBody()
            apple?.removeFromParent()
            createApple()
        case ColliderCategories.EdgeBody:
            snake?.removeFromParent()
            createSnake()
        default: break
        }
        
    }
    
}
