//
//  Array+Extensions.swift
//
//
//  Created by Andrew McLean on 12/27/23.
//

import Foundation

extension Array where Element: Equatable {
    func mergedWithUniqueValues(from otherArray: [Element]) -> [Element] {
        var resultArray = self
        
        for element in otherArray {
            if !resultArray.contains(element) {
                resultArray.append(element)
            }
        }
        
        return resultArray
    }
}
