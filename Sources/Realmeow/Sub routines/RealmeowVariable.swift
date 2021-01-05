//
//  RealmeowVariable.swift
//  Tigris
//
//  Created by Test on 2016-11-12.
//  Copyright © 2016 Whiskerz AB. All rights reserved.
//

import Realm
import RealmSwift

extension Realmeow where T: Object {
    public var isManaged: Bool {
        return (self.base.realm != nil)
    }
    
    public var managed: T? {
        guard let realm = try? Realm(), let key = T.primaryKey() else { return nil }
        let object = realm.object(ofType: T.self, forPrimaryKey: self.base.value(forKey: key))
        return object
    }
    
    public var unmanaged: T {
        return self.base.detached()
    }
}

fileprivate extension Object {
    fileprivate func detached() -> Self {
        let detached = type(of: self).init()
        for property in objectSchema.properties {
            guard let value = value(forKey: property.name) else { continue }
            if let detachable = value as? Object {
                detached.setValue(detachable.detached(), forKey: property.name)
            } else {
                detached.setValue(value, forKey: property.name)
            }
        }
        return detached
    }
}
