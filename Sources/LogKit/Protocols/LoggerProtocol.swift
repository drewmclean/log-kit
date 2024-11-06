//
//  LoggerProtocol.swift
//
//
//  Created by Andrew McLean on 12/10/23.
//

import Foundation

public protocol LoggerProtocol {
    var minimumLogLevel: LogLevel { get }
    var appendPrefixes: Bool { get }
    
    func log(_ log: Log, file: String, line: Int)
    
}
