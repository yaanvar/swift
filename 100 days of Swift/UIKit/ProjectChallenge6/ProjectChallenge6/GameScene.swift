//
//  GameScene.swift
//  ProjectChallenge6
//
//  Created by Anvar Rahimov on 16.02.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var scoreLabel: SKLabelNode!
    var possibleEnemies = ["targetGood", "targetBad"]
    var gameTimer: Timer?
    var isGameOver = false
    var enemyCounter = 0
    var timeInterval = 1.0
    var timerLabel: SKLabelNode!
    var timer: Timer?
    
    var secondsRemaining = 60 {
        didSet {
            timerLabel.text = "Time remaining: \(secondsRemaining)"
        }
    }
    
    var score = 0 {
        didSet {
            scoreLabel?.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -2
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel?.text = "Score: \(score)"
        scoreLabel?.position = CGPoint(x: 20, y: 60)
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.zPosition = -1
        addChild(scoreLabel)
        
        timerLabel = SKLabelNode(fontNamed: "Chalkduster")
        timerLabel?.text = "Time remaining: \(secondsRemaining)"
        timerLabel?.position = CGPoint(x: 20, y: 680)
        timerLabel.horizontalAlignmentMode = .left
        timerLabel.zPosition = -1
        addChild(timerLabel)
        
        gameTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(oneSecond), userInfo: nil, repeats: true)
    }
    
    @objc func oneSecond() {
        if secondsRemaining == 0 {
            gameTimer?.invalidate()
            timer?.invalidate()
            isGameOver = true
        } else {
            secondsRemaining -= 1
        }
    }
    
    @objc func createEnemy() {
        enemyCounter += 1
        
        guard let enemy = possibleEnemies.randomElement() else { return }
        
        let sprite = SKSpriteNode(imageNamed: enemy)
        var size = Int.random(in: 100...200)
        sprite.name = enemy
        sprite.scale(to: CGSize(width: size, height: size))
        sprite.position = CGPoint(x: 1200, y: Int.random(in: 150...636))
        
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.categoryBitMask = 1
        sprite.physicsBody?.velocity = CGVector(dx: -Int.random(in: 200...500), dy: 0)
        sprite.physicsBody?.linearDamping = 0
        addChild(sprite)
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.x < -300 {
                node.removeFromParent()
            }
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        var location = touch.location(in: self)
        
        for node in children {
            if node.position == location {
                if node.name == "targetGood" {
                    score += 1
                } else if node.name == "targetBad" {
                    score -= 1
                }
            }
        }
    }
}
