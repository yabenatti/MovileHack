//
//  Purveyor.swift
//  MovileHack
//
//  Created by Movile Hack on 19/08/2018.
//  Copyright © 2018 Yasmin Benatti. All rights reserved.
//

import Foundation

final class Purveyor : Hashable, Equatable {
    //MARK: - Properties
    let id: String
    let name: String
    
    // MARK: - Initializers
    init (id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    // MARK: - Hashable
    var hashValue: Int {
        return self.id.hashValue
    }
    
    // MARK: - Equatable
    static func == (lhs: Purveyor, rhs: Purveyor) -> Bool {
        return lhs.id == rhs.id
    }
}
