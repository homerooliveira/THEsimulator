//
//  Array.swift
//  THESimulatorFramework
//
//  Created by Homero Oliveira on 23/08/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

extension Array {
    func orderedIndexOf(elem: Element, isBefore: (Element, Element) -> Bool) -> Int {
        var low = 0
        var high = self.count - 1
        while low <= high {
            let mid = (low + high) / 2
            if isBefore(self[mid], elem) {
                low = mid + 1
            } else if isBefore(elem, self[mid]) {
                high = mid - 1
            } else {
                return mid // found at position mid
            }
        }
        return low // not found, would be inserted at position lo
    }
    
    mutating func insertOrdered(elem: Element, isBefore: (Element, Element) -> Bool) {
        let index = orderedIndexOf(elem: elem, isBefore: isBefore)
        insert(elem, at: index)
    }
}

extension Array where Element: Comparable {
    mutating func insertOrdered(elem: Element) {
        let index = orderedIndexOf(elem: elem, isBefore: <)
        insert(elem, at: index)
    }
}
