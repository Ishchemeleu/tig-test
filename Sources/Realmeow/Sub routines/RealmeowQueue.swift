//
//  RealmeowQueue.swift
//  Tigris
//
//  Created by Test on 2016-11-12.
//  Copyright © 2016 Whiskerz AB. All rights reserved.
//

import Foundation
import RealmSwift

internal struct RealmeowQueue {
    let realm: Realm
    let queue: DispatchQueue
    
    init?() {
        queue = DispatchQueue(label: UUID().uuidString)
        var tmp: Realm? = nil
        queue.sync { tmp = try? Realm() }
        guard let valid = tmp else { return nil }
        self.realm = valid
    }
}
