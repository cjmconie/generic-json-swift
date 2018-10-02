//
//  Merge.swift
//  GenericJSON
//
//  Created by Cameron McOnie on 2018/10/02.
//  Copyright © 2018 Tomáš Znamenáček. All rights reserved.
//

import Foundation

extension JSON {
    
    /// Merges a JSON type into this JSON.
    ///
    /// Primative values which are not present in this JSON are NOT added.
    /// Primative values which are present are overwritten.
    /// Array values are appended.
    /// Nested JSON is handled in the same way.
    public mutating func merge(with other: JSON) throws {
        try self.merge(with: other, typecheck: true)
    }
    
    /// Merges a JSON type into this JSON and returns a copy.
    ///
    public func merged(with other: JSON) throws -> JSON {
        var merged = self
        try merged.merge(with: other, typecheck: true)
        return merged
    }

    /// Worker function which preforms a mutating merge.
    ///
    /// Only self's keys are considered.
    /// Both self and other must have the same top level json structure.
    fileprivate mutating func merge(with other: JSON, typecheck: Bool) throws {

        switch self {
        case let .object(object):
            for (key, _) in object {
                if let otherValue = other[key] {
                    try self[key]!.merge(with: otherValue, typecheck: false)
                } else {
                    //self
                }
            }
        case let .array(arrayValue):
            if let otherArray = other.arrayValue {
                self = JSON.array(arrayValue + otherArray)
            }
        default:
            self = other
        }

    }
    
    /// Worker function which performs a mutating merge.
    ///
    /// The keys of other are used to merge into self.
    /// Both self and other must have the same top level json structure.
//    fileprivate mutating func merge(with other: JSON, typecheck: Bool) throws {
//
//        switch self {
//        case .object:
//            if let otherObject = other.objectValue {
//                for (key, _) in otherObject {
//                    if self[key] != nil {
//                        try self[key]!.merge(with: otherObject[key]!, typecheck: false)
//                    } else {
//                        self[key] = otherObject[key] // add it
//                    }
//                }
//            }
//        case let .array(arrayValue):
//            if let otherArray = other.arrayValue {
//                self = JSON.array(arrayValue + otherArray)
//            }
//        default:
//            self = other
//        }
//
//    }
    
}


