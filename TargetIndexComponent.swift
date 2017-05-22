//
//  TargetIndexComponent.swift
//  Battle Arena
//
//  Created by Marcus Reuber Almeida Moraes Silva on 18/05/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import GameplayKit
import SpriteKit

class TargetIndexComponent: GKComponent {
    
    var targetIndex: Int?
    
    override init() {
        super.init()
    }
    func setTargetIndex(_ targetIndex: Int){
        self.targetIndex = targetIndex
    }
    
    func getTargetIndex() -> Int? {
        return self.targetIndex
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

