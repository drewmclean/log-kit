//
//  LoggerManager.swift
//
//
//  Created by Andrew McLean on 12/9/23.
//

import Foundation

public protocol LoggerManager : CustomStringConvertible {
        
    func setUserId(_ userId: String?)
    func setCustomValue(_ value: String?, key: String)
    
    func buildLogger(category: String, tags: [String]?) -> LoggerProtocol
}
