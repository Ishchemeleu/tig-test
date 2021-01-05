//
//  RealmeowSave.swift
//  Tigris
//
//  Created by Test on 2016-11-12.
//  Copyright © 2016 Whiskerz AB. All rights reserved.
//

import RealmSwift

extension Realmeow where T: Object {
    public func save(update: Bool = false) throws {
        let _ = try self.saved(update: update)
    }
    
    public func saved(update: Bool = false) throws -> T {
        return (self.isManaged) ? try managed_save(update: update) : try unmanaged_save(update: update)
    }
    
    public func update() throws {
        let _ = (self.isManaged) ? try managed_save(update: true) : try unmanaged_save(update: true)
    }
}

fileprivate extension Realmeow where T: Object {
    fileprivate func managed_save(update: Bool) throws -> T {
        let ref = ThreadSafeReference(to: self.base)
        guard let rq = RealmeowQueue() else {
            throw RealmeowError.realmQueueCantBeCreate
        }
        return try rq.queue.sync {
            guard let object = rq.realm.resolve(ref) else { throw RealmeowError.objectCantBeResolved }
            rq.realm.beginWrite()
            let ret = rq.realm.create(T.self, value: object, update: update)
            try rq.realm.commitWrite()
            return ret
        }
    }
    
    fileprivate func unmanaged_save(update: Bool) throws -> T {
        let realm = try Realm()
        realm.beginWrite()
        let ret = realm.create(T.self, value: self.base, update: update)
        try realm.commitWrite()
        return ret
    }
}
