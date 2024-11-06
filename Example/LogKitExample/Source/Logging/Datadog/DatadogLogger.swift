//
//  DatadogLogger.swift
//  
//
//  Created by Andrew McLean on 8/10/23.
//

import Foundation
import DatadogCore
import DatadogLogs
import LogKit

final class DatadogLogger : LogKit.LoggerProtocol {
    var minimumLogLevel: LogKit.LogLevel = .error
    
    private let logger: DatadogLogs.LoggerProtocol
    
    let appendPrefixes: Bool = false
    
    public init(config: DatadogLoggerConfiguration, category: String, tags: [String]?) {
        let loggerConfig = DatadogLogs.Logger.Configuration.init(
            service: config.clientService.rawValue,
            name: category,
            networkInfoEnabled: config.isSendNetworkInfoEnabled,
            bundleWithRumEnabled: config.isRUMEnabled,
            bundleWithTraceEnabled: config.isTraceEnabled
        )
        self.logger = DatadogLogs.Logger.create(with: loggerConfig)
        self.logger.addAttribute(forKey: "category", value: category)
        tags?.forEach { self.logger.add(tag: $0) }
    }
    
    public func log(_ log: LogKit.Log, file: String = #fileID, line: Int = #line) {
        guard let ddLogLevel = log.level.datadogLogLevel else { return }
        
        logger.log(level: ddLogLevel, message: log.message, error: log.error, attributes: log.attributes as? [String: Encodable])
    }
    
}

fileprivate extension LogKit.LogLevel {
    
    var datadogLogLevel : DatadogLogs.LogLevel? {
        switch self {
        case .trace: return nil
        case .debug: return DatadogLogs.LogLevel.debug
        case .info: return DatadogLogs.LogLevel.info
        case .warning: return DatadogLogs.LogLevel.warn
        case .error: return DatadogLogs.LogLevel.error
        case .critical: return DatadogLogs.LogLevel.critical
        }
    }
    
}
