//
//  GameViewController.swift
//  GeekBrainsSnake
//
//  Created by Евгений Шварцкопф on 30/10/2019.
//  Copyright © 2019 Евгений Шварцкопф. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gameScene = GameScene(size: view.bounds.size) // холст по размеру экрана, на котором будет игра
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        gameScene.scaleMode = .resizeFill
        skView.presentScene(gameScene)
    }
}
