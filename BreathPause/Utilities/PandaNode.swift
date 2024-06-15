//
//  PandaNode.swift
//  BreathPause
//
//  Created by Nir Neuman on 11/06/2024.
//

import SpriteKit

class PandaNode: SKSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "panda.png")
        super.init(texture: texture, color: .clear, size: texture.size())
        self.setupAnimations()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupAnimations()
    }
    
    private func setupAnimations() {
        // Add breathing animation (scale up and down)
        let breatheIn = SKAction.scale(to: 1.1, duration: 1.5)
        let breatheOut = SKAction.scale(to: 1.0, duration: 1.5)
        let breathingSequence = SKAction.sequence([breatheIn, breatheOut])
        let repeatBreathing = SKAction.repeatForever(breathingSequence)
        self.run(repeatBreathing)
    }
    
    func stopBreathing() {
        self.removeAllActions()
    }
    
    func startBreathing() {
        let breatheIn = SKAction.scale(to: 1.1, duration: 1.5)
        let breatheOut = SKAction.scale(to: 1.0, duration: 1.5)
        let breathingSequence = SKAction.sequence([breatheIn, breatheOut])
        let repeatBreathing = SKAction.repeatForever(breathingSequence)
        self.run(repeatBreathing)
    }
}
