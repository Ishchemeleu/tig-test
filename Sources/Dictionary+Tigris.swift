//
//  Dictionary+Tigris.swift
//  Tigris
//
//  Created by Test on 2016-07-06.
//  Copyright © 2016 Test. All rights reserved.
//

import Foundation

public extension Dictionary {
    public func has(_ key: Key) -> Bool {
        return index(forKey: key) != nil
    }
}
