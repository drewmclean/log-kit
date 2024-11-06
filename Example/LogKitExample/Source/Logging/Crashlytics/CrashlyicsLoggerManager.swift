//
//  CrashlyticsLoggerManager.swift
//
//
//  Created by Andrew McLean on 12/19/23.
//

import Foundation
import FirebaseCrashlytics
import LogKit

final class CrashlyticsLoggerManager : LoggerManager {
    
    private let crashlytics: Crashlytics

    init(crashlytics: Crashlytics = Crashlytics.crashlytics()) {
        self.crashlytics = crashlytics
    }
    
    func setUserId(_ userId: String?) { 
        crashlytics.setUserID(userId)
    }
    func setCustomValue(_ value: String?, key: String) { 
        crashlytics.setCustomValue(value, forKey: key)
    }
    
    func buildLogger(category: String, tags: [String]?) -> LoggerProtocol {
        return CrashlyticsLogger(crashlytics: crashlytics)
    }
    
    var description: String {
        return "CrashlyticsLoggerManager()"
    }
}
