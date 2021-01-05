//
//  RealmeowError.swift
//  Tigris
//
//  Created by Test on 2016-11-12.
//  Copyright © 2016 Whiskerz AB. All rights reserved.
//

import Foundation

enum RealmeowError: Error {
    case realmQueueCantBeCreate
    case objectCantBeResolved
    case objectDoesntHavePrimaryKey
}
