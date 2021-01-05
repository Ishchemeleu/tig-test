//
//  RealmeowDelete.swift
//  Tigris
//
//  Created by Test on 2016-11-12.
//  Copyright © 2016 Whiskerz AB. All rights reserved.
//

import Realm
import RealmSwift

public extension RealmeowStatic where T: Object {
    public func deleteAll() throws {
        let realm = try Realm()
        let objects = realm.objects(self.baseType)
        if objects.count > 0 {
            try realm.write {
                realm.delete(objects)
            }
        }
    }
}

public extension Realmeow where T: Object {
    public func delete() throws {
        self.isManaged ? try managed_delete() : try unmanaged_delete()
    }
}

fileprivate extension Realmeow where T: Object {
    fileprivate func managed_delete() throws {
        guard let rq = RealmeowQueue() else { throw RealmeowError.realmQueueCantBeCreate }
        let ref = ThreadSafeReference(to: self.base)
        try rq.queue.sync {
            guard let object = rq.realm.resolve(ref) else { throw RealmeowError.objectCantBeResolved }
            try rq.realm.write {
                rq.realm.delete(object)
            }
        }
    }
    
    fileprivate func unmanaged_delete() throws {
        guard let rq = RealmeowQueue() else { throw RealmeowError.realmQueueCantBeCreate }
        guard let key = T.primaryKey() else { throw RealmeowError.objectCantBeResolved }
        
        try rq.queue.sync {
            let value = self.base.value(forKey: key)
            if let object = rq.realm.object(ofType: T.self, forPrimaryKey: value) {
                try rq.realm.write {
                    rq.realm.delete(object)
                }
            }
        }
    }
}
