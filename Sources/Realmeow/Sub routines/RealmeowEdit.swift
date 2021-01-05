//
//  RealmeowEdit.swift
//  Tigris
//
//  Created by Test on 2016-11-12.
//  Copyright © 2016 Whiskerz AB. All rights reserved.
//

import Realm
import RealmSwift

extension Realmeow where T: Object {
    public func edit(_ closure: @escaping (_ T: T) -> Void) throws {
        self.isManaged ? try managed_edit(closure) : try unmanaged_dit(closure)
    }
}

fileprivate extension Realmeow where T: Object {
    fileprivate func managed_edit(_ closure: @escaping (_ T: T) -> Void) throws {
        guard let rq = RealmeowQueue() else { throw RealmeowError.realmQueueCantBeCreate }
        let ref = ThreadSafeReference(to: self.base)
        try rq.queue.sync {
            guard let object = rq.realm.resolve(ref) else { throw RealmeowError.objectCantBeResolved }
            try rq.realm.write { closure(object) }
        }
    }
    
    fileprivate func unmanaged_dit(_ closure: @escaping (_ T: T) -> Void) throws  {
        closure(self.base)
    }
}
