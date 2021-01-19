//
//  Collection + Extensions.swift
//  CoreSwift
//
//  Created by   Валерий Мельников on 19.01.2021.
//

import Foundation
extension Collection{
    func sorted<Value: Comparable>(
        by keyPath: KeyPath<Element, Value>,
        _ comparator: (_ lhs: Value, _ rhs: Value) -> Bool) -> [Element] {
        sorted { comparator($0[keyPath: keyPath], $1[keyPath: keyPath]) }
    }
}
