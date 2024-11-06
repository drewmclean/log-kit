//
//  OSLoggerManager.swift
//
//
//  Created by Andrew McLean on 12/19/23.
//

import Foundation

final public class OSLoggerManager : LoggerManager {
    
    public init() { }
    
    public func setUserId(_ userId: String?) {}
    public func setCustomValue(_ value: String?, key: String) {}
    
    public func buildLogger(category: String, tags: [String]?) -> LoggerProtocol {
        return OSLogger(category: category)
    }
    
    public var description: String {
        return "OSLoggerManager"
    }
    
}
