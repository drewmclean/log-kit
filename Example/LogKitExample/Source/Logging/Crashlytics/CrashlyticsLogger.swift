//
//  CrashlyticsLogger.swift
//
//
//  Created by Andrew McLean on 12/16/23.
//

import Foundation
import FirebaseCore
import FirebaseCrashlytics
import LogKit

final class CrashlyticsLogger : LoggerProtocol {
    
    private let crashlytics: Crashlytics
    
    let minimumLogLevel: LogLevel = .info
    let appendPrefixes: Bool = true
    
    public init(crashlytics: Crashlytics) {
        self.crashlytics = crashlytics
    }
    
    public func log(_ log: Log, file: String = #fileID, line: Int = #line) {
        crashlytics.log("\(file):\(line) \(log.message)")
        
        if let error = log.error {
            crashlytics.record(error: error, userInfo: log.attributes)
        }
    }
    
}


