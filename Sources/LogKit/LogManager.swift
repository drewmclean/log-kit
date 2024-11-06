//
//  LogManager.swift
//
//
//  Created by Andrew McLean on 11/10/23.
//

import Foundation
import OSLog

final public class LogManager {
    
    public static let shared: LogManager = LogManager()
    
    private let _log: os.Logger = .init(subsystem: Bundle.main.bundleIdentifier!, category: "LogKit")
    
    private var managers: [LoggerManager] = []
    
    public private(set) var isInitialized: Bool = false
    public private(set) var name: String = ""
    public private(set) var messagePrefixes: [LogMessagePrefix] = []
    public private(set) var globalAttributes: [String: Encodable?] = [:]
    
    private var _openProjectIds: Set<String> = .init()
    private var _activeProjectId: String = ""
    
    public func initialize(name: String, managers: [LoggerManager], messagePrefixes: [LogMessagePrefix]) {
        guard !isInitialized else {
            _log.error("LogManager already initialized.")
            return
        }
        
        self.name = name
        self.managers = managers
        self.messagePrefixes = messagePrefixes
        
        _log.info("Initializing LogManager(name: \(name), configs: \(managers.map{ $0.description }))")
        isInitialized = true
    }
    
    public func setUserId(_ userId: String?) {
        globalAttributes["userId"] = userId
        
        managers.forEach { $0.setUserId(userId) }
    }
    
    public func setCustomValue(_ value: String?, key: String) {
        globalAttributes[key] = value
        
        managers.forEach { $0.setCustomValue(value, key: key) }
    }
    
    public func setActiveProjectId(_ value: String?) {
        _activeProjectId = value ?? ""
        
        if !_activeProjectId.isEmpty {
            _openProjectIds.insert(_activeProjectId)
        }
        
        managers.forEach {
            $0.setCustomValue(_activeProjectId, key: "activeProjectId")
            $0.setCustomValue(getProjectIdsString(), key: "openProjectIds")
        }
    }
    
    public func removeOpenProjectId(_ value: String) {
        _openProjectIds.remove(value)
        
        if _activeProjectId == value {
            _activeProjectId = ""
        }
        
        managers.forEach {
            $0.setCustomValue(_activeProjectId, key: "activeProjectId")
            $0.setCustomValue(getProjectIdsString(), key: "openProjectIds")
        }
    }
    
    private func getProjectIdsString() -> String {
        Array(_openProjectIds).joined(separator: ", ")
    }
}

// MARK: Internal

extension LogManager {
    
    func buildLoggers(category: String, tags: [String]?) -> [LoggerProtocol] {
        _log.info("LogManager buildLoggers(category: \(category)")

        var loggers: [LoggerProtocol] = []

        managers.forEach {
            loggers.append($0.buildLogger(category: category, tags: tags))
        }
        
        return loggers
    }
    
    
}
