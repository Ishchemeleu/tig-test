//
//  RealmeowQuery.swift
//  Tigris
//
//  Created by Test on 2016-11-12.
//  Copyright © 2016 Whiskerz AB. All rights reserved.
//

import Foundation
import RealmSwift

public extension RealmeowStatic where T: Object {
    public func fromRealm<K>(with primaryKey: K) throws -> T? {
        let realm = try Realm()
        return realm.object(ofType: self.baseType, forPrimaryKey: primaryKey)
    }
    
    public func all() throws -> Results<T> {
        let realm = try Realm()
        return realm.objects(self.baseType)
    }
}
