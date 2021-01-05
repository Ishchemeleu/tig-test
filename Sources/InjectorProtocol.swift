//
//  Injector.swift
//  Tigris
//
//  Created by Test on 2016-07-06.
//  Copyright © 2016 Test. All rights reserved.
//

import Foundation

public protocol InjectorProtocol {
    func map<T>(object: T.Type, key: String?, scope: @escaping () -> T)

    func map<T>(object: T.Type, key: String?, initializeImmediately: Bool, scope: @escaping () -> T)

    func map<T>(object: T.Type, scope: @escaping () -> T)

    func map<T>(object: T.Type, initializeImmediately: Bool, scope: @escaping () -> T)

    func get<T>(object: T.Type) -> T?

    func unmap<T>(object: T.Type)

    func hasMapping<T>(object: T.Type) -> Bool

    func unmap(_ key: String)

    func hasMapping(_ key: String) -> Bool
}
