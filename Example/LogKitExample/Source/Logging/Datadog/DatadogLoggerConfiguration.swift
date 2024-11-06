//
//  DatadogLoggerConfiguration.swift
//  
//
//  Created by Andrew McLean on 12/4/23.
//

import Foundation
import DatadogInternal
import DatadogCore
import DatadogCrashReporting
import DatadogLogs
import DatadogRUM
import DatadogTrace

public struct DatadogLoggerConfiguration {
    public enum Site : String {
        case us1
        case us5
        
        var datadogSite: DatadogSite {
            switch self {
            case .us1: return .us1
            case .us5: return .us5
            }
        }
    }
    
    public enum ClientService : String {
        case macOS = "macOS-gen2"
        case iOS = "iOS-gen2"
    }
    
    public let environment: String
    public let site: Site
    public let clientToken: String
    public let clientService: ClientService
    public let appID: String
    public let isCrashReportingEnabled: Bool
    public let isRUMEnabled: Bool
    public let isTraceEnabled: Bool
    public let isSendNetworkInfoEnabled: Bool
    
    public init(
        environment: String,
        site: Site,
        clientToken: String,
        clientService: ClientService,
        appID: String,
        isCrashReportingEnabled: Bool = false,
        isRUMEnabled: Bool = false,
        isTraceEnabled: Bool = false,
        isSendNetworkInfoEnabled: Bool = false
    ) {
        self.environment = environment
        self.site = site
        self.clientToken = clientToken
        self.clientService = clientService
        self.appID = appID
        self.isCrashReportingEnabled = isCrashReportingEnabled
        self.isRUMEnabled = isRUMEnabled
        self.isTraceEnabled = isTraceEnabled
        self.isSendNetworkInfoEnabled = isSendNetworkInfoEnabled
    }
    
}
