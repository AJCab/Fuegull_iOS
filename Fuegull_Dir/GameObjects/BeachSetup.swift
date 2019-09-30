//
//  BeachSetup.swift
//  Fuegull
//
//  Created by Adam Cabral on 9/29/19.
//  Copyright © 2019 Adam Cabral. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class beachSetup{
    var setupNum: UInt32
    
    init(){
        setupNum = arc4random_uniform(3)
    }
}
