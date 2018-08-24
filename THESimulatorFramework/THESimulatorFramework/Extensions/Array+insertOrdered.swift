//
//  Array.swift
//  THESimulatorFramework
//
//  Created by Homero Oliveira on 23/08/18.
//  Copyright © 2018 Homero Oliveira. All rights reserved.
//

import Foundation

extension Array {
    mutating func insertOrdered(elem: Element, isBefore: (Element, Element) -> Bool) {
        var low = startIndex
        var high = endIndex
        while low < high {
            let mid = (low + high) / 2
            if isBefore(self[mid], elem) {
                low = mid + 1
            } else if isBefore(elem, self[mid]) {
                high = mid - 1
            } else {
                insert(elem, at: mid)
            }
        }
        insert(elem, at: low)
    }
}

extension Array where Element: Comparable {
    mutating func insertOrdered(elem: Element) {
        var low = startIndex
        var high = endIndex
        while low < high {
            let mid = (low + high) / 2
            if self[mid] < elem {
                low = mid + 1
            } else if elem < self[mid] {
                high = mid - 1
            } else {
                insert(elem, at: mid)
            }
        }
        insert(elem, at: low)
    }
}
