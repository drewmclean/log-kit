//
//  Log.swift
//
//
//  Created by Andrew McLean on 12/10/23.
//

import Foundation

public struct Log {
    public let level: LogLevel
    public let message: String
    public let tags: [String]?
    public let error: Error?
    public let attributes: Logger.Attributes?
    
    public init(level: LogLevel, message: String, tags: [String]? = nil, error: Error? = nil, attributes: Logger.Attributes? = nil) {
        self.level = level
        self.message = message
        self.tags = tags
        self.error = error
        self.attributes = attributes
    }
    
}
