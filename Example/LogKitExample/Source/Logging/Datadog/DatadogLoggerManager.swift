//
//  DatadogLoggerManager.swift
//
//
//  Created by Andrew McLean on 12/19/23.
//

import Foundation
import DatadogCore
import DatadogLogs
import DatadogRUM
import DatadogTrace
import DatadogCrashReporting
import LogKit

final class DatadogLoggerManager : LoggerManager {
    
    private let configuration: DatadogLoggerConfiguration
    
    init(config: DatadogLoggerConfiguration) {
        self.configuration = config
    }
    
    // Can't set "global" values in Datadog, they have to be set on each instance of DatadogLogger, or passed into log message directly.
    // PlayLogManager will keep track globalAttributes and pass them into each log() call.
    func setUserId(_ userId: String?) {}
    func setCustomValue(_ value: String?, key: String) {}
    
    func buildLogger(category: String, tags: [String]?) -> LogKit.LoggerProtocol {
        return DatadogLogger(
            config: configuration,
            category: category,
            tags: tags
        )
    }
    
    var description: String {
        return "DatadogLoggerManager(config: \(configuration))"
    }
    
    static func initialize(config: DatadogLoggerConfiguration) {
        Datadog.initialize(
            with: Datadog.Configuration(
                clientToken: config.clientToken,
                env: config.environment,
                site: config.site.datadogSite,
                service: config.clientService.rawValue,
                batchSize: .small,
                uploadFrequency: .frequent
            ),
            trackingConsent: .granted
        )
        
        Logs.enable()
        
        if config.isCrashReportingEnabled {
            CrashReporting.enable()
        }
        
        if config.isRUMEnabled {
            RUM.enable(
                with: RUM.Configuration(
                    applicationID: config.appID,
                    uiKitViewsPredicate: DefaultUIKitRUMViewsPredicate(),
                    uiKitActionsPredicate: DefaultUIKitRUMActionsPredicate()
                )
            )
        }
        
        if config.isTraceEnabled {
            Trace.enable(
                with: Trace.Configuration(
                    service: config.clientService.rawValue,
                    bundleWithRumEnabled: config.isRUMEnabled,
                    networkInfoEnabled: config.isSendNetworkInfoEnabled
                )
            )
        }
    }
    
}

