//
//  OSLogger.swift
//
//
//  Created by Andrew McLean on 12/4/23.
//

import Foundation
import OSLog

final class OSLogger : LoggerProtocol {
    private static let bundleSubsystemString: String = Bundle.main.bundleIdentifier!

    private let category: String
    
    let minimumLogLevel: LogLevel = .trace
    let appendPrefixes: Bool = true
    
    private let logger: os.Logger

    init(category: String) {
        self.category = category
        self.logger = .init(
            subsystem: Self.bundleSubsystemString,
            category: category
        )
    }
    
    public func log(_ log: Log, file: String = #fileID, line: Int = #line) {
        logger.log(level: log.level.osLogLevel, "\(log.message)")
    }
    
}

fileprivate extension LogLevel {
    
    var osLogLevel : OSLogType {
        switch self {
        case .trace: return .default
        case .debug: return .debug
        case .info: return .info
        case .warning: return .error
        case .error: return .error
        case .critical: return .fault
        }
    }
    
}
