//
//  InjectionMapping.swift
//  Tigris
//
//  Created by Test on 2016-07-06.
//  Copyright © 2016 Test. All rights reserved.
//

import Foundation

protocol InjectionMappingProtocol {
    var result: Any? { get }
}

open class InjectionMapping<T>: InjectionMappingProtocol {
    fileprivate var instance: T.Type
    fileprivate var mappingId: String
    fileprivate var scope: () -> T
    var result: Any?

    init(object: T.Type, key: String, initializeImmediately: Bool, scope: @escaping () -> T) {
        self.instance = object
        self.mappingId = key
        self.scope = scope

        self.asSingleton(initializeImmediately)
    }

    private func asSingleton(_ initializeImmediately: Bool = false) {
        if initializeImmediately {
            self.result = scope()
        }
    }
}
