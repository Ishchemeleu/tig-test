//
//  Context.swift
//  Tigris
//
//  Created by Test on 2016-07-06.
//  Copyright © 2016 Test. All rights reserved.
//

import Foundation

public protocol ContextProtocol {
    var injector: InjectorProtocol { get }

    func configure(_ config: Config..., completion: () -> Void)
}

public struct Context: ContextProtocol {
    fileprivate let _injector: InjectorProtocol = Injector()

    public var injector: InjectorProtocol {
        return _injector
    }

    public init() {}

    public func configure(_ configs: Config..., completion: () -> Void) {
        for config in configs {
            config.configure(injector)
        }
        completion()
    }
}
