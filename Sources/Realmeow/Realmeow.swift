//
//  Realmeow.swift
//  Tigris
//
//  Created by Test on 2016-11-12.
//  Copyright © 2016 Whiskerz AB. All rights reserved.
//

import RealmSwift

public final class Realmeow<T> {
    internal var base: T
    
    public init(_ instance: T) {
        self.base = instance
    }
}

public final class RealmeowStatic<T> {
    internal var baseType: T.Type
    
    public init(_ instance: T.Type) {
        self.baseType = instance
    }
}

public protocol RealmeowCompatible {
    associatedtype CompatibleType
    
    var this: Realmeow<CompatibleType> { get }
    static var this: RealmeowStatic<CompatibleType> { get }
}

public extension RealmeowCompatible {
    public var this: Realmeow<Self> {
        get { return Realmeow(self) }
    }
    
    public static var this: RealmeowStatic<Self> {
        get { return RealmeowStatic(Self.self) }
    }
}

extension Object: RealmeowCompatible {}
