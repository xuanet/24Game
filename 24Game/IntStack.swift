//
//  IntStack.swift
//  24Game
//
//  Created by Kevin Xu on 7/12/23.
//

import Foundation

struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    mutating func count() -> Int {
        return items.count
    }
    mutating func clear() {
        items.removeAll()
    }
    func contains(_ value: Int) -> Bool {
        return items.contains(value)
    }
}
