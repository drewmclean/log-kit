//
//  AppDelegate.swift
//  LogKitExample
//
//  Created by Andrew McLean on 12/8/23.
//

import UIKit
import LogKit
import DatadogCore
import DatadogLogs
import OSLog

enum TestError : Error, CustomStringConvertible {
    case testWarning
    case testError
    case testCritcal

    var description: String {
        switch self {
        case .testWarning: return "This is test warning error description"
        case .testError: return "This is test error description"
        case .testCritcal: return "This is test critical error description"
        }
    }
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let datadogConfig: DatadogLoggerConfiguration = .init(
            environment: "staging",
            site: .us5,
            clientToken: "my-client-token",
            clientService: .iOS,
            appID: "com.andrewmclean.LogKitExample"
        )
        
        let managers: [LoggerManager] = [
            OSLoggerManager(),
            DatadogLoggerManager(config: datadogConfig),
            CrashlyticsLoggerManager()
        ]

        LogManager.shared.initialize(
            name: "LogKitExampleLogger",
            managers: managers,
            messagePrefixes: [.category, .tags, .level]
        )
        
        LogManager.shared.setUserId("my-user-id-here")
        
        let log =  AppLog.services
        let log2 =  AppLog.view

        let attributes: [String : String] = [
            "Logger1Key1" : "Logger1Value1",
            "Logger1Key2" : "Logger1Value2"
        ]
        
        log.trace("Logger1 This is warning log test.", attributes: attributes)
        log.debug("Logger1 This is debug log test.", attributes: attributes)
        log.info("Logger1 This is info log test.", error: TestError.testWarning, attributes: attributes)
        log.warning("Logger1 This is warn log test.", error: TestError.testError, attributes: attributes)
        log.error("Logger1 This is error log test.", error: TestError.testCritcal, attributes: attributes)
        
        let attributes2: [String : String] = [
            "Logger2AttributeKey1" : "Logger2AttributeValue1",
            "Logger2AttributeKey2" : "Logger2AttributeValue2"
        ]

        log2.trace("Logger2 This is warning log test.", attributes: attributes2)
        log2.debug("Logger2 This is debug log test.", attributes: attributes2)
        log2.info("Logger2 This is info log test.", error: TestError.testWarning, attributes: attributes2)
        log2.warning("Logger2 This is warn log test.", error: TestError.testError, attributes: attributes2)
        log2.error("Logger2 This is error log test.", error: TestError.testCritcal, attributes: attributes2)

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    func testDataDogLogLevels() throws {
        
    }

}

