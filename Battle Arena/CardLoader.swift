//
//  CardLoader.swift
//  Battle Arena
//
//  Created by Felipe Borges on 26/05/17.
//  Copyright © 2017 Iracema Studio. All rights reserved.
//

import Foundation
import SwiftyJSON

class CardLoader {
    init(path: String) {
        let resourcePath = Bundle.main.paths(forResourcesOfType: ".json", inDirectory: "Cards")
        print(resourcePath)
        
    }
}
