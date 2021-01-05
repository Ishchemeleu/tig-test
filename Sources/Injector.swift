//
//  Injector.swift
//  Tigris
//
//  Created by Test on 2016-07-06.
//  Copyright © 2016 Test. All rights reserved.
//

import Foundation

public enum InjectorError: Error {
    case invalidKey
    case injectionInProcesss
}

public class Injector: InjectorProtocol {
    fileprivate var mappings: [String: InjectionMappingProtocol]
    fileprivate var mappingsInProcess: [String: Bool]

    init() {
        self.mappings = [:]
        self.mappingsInProcess = [:]
    }

    // MARK: - InjectorProtocol

    public func map<T>(object: T.Type, key: String?, initializeImmediately: Bool, scope: @escaping () -> T) {
        let mappingKey = self.mappingId(object, key: key)
        self.createMapping(object: object, key: mappingKey, initializeImmediately: initializeImmediately, scope: scope)
    }

    public func map<T>(object: T.Type, key: String?, scope: @escaping () -> T) {
        self.map(object: object, key: key, initializeImmediately: true, scope: scope)
    }

    public func map<T>(object: T.Type, scope: @escaping () -> T) {
        self.map(object: object, key: nil, scope: scope)
    }

    public func map<T>(object: T.Type, initializeImmediately: Bool, scope: @escaping () -> T) {
        self.map(object: object, key: nil, initializeImmediately: initializeImmediately, scope: scope)
    }

    public func get<T>(object: T.Type) -> T? {
        let key = self.mappingId(object)

        guard
            let returnValue = mappings[key],
            let returnObject = returnValue.result as? T
        else { return nil }

        return returnObject
    }

    public func unmap<T>(object: T.Type) {
        let key = self.mappingId(object)
        self.unmap(key)
    }

    public func hasMapping<T>(object: T.Type) -> Bool {
        let key = self.mappingId(object)
        return self.hasMapping(key)
    }

    public func unmap(_ key: String) {
        if self.hasMapping(key) {
            self.mappings.removeValue(forKey: key)
        }
    }

    public func hasMapping(_ key: String) -> Bool {
        return self.mappings.has(key)
    }

    fileprivate func createMapping<T>(object: T.Type, key: String, initializeImmediately: Bool, scope: @escaping () -> T) {
        self.mappingsInProcess[key] = true

        let mapping = InjectionMapping(object: object, key: key, initializeImmediately: initializeImmediately, scope: scope)
        self.mappings[key] = mapping
        self.mappingsInProcess.removeValue(forKey: key)
    }

    fileprivate func mappingId<T>(_ instance: T.Type, key: String? = nil) -> String {
        guard
            let key = key,
            !key.isEmpty
        else {
            return String(describing: instance)
        }
        return key
    }
}
