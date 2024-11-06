//
//  Logger.swift
//
//
//  Created by Andrew McLean on 12/9/23.
//

import Foundation

public struct Logger {
    public typealias Attributes = [String : Encodable?]
    private static let manager: LogManager = .shared
    
    private let formatter: LogFormatter = LogFormatter()
    
    private var globalAttributes: Attributes {
        return Self.manager.globalAttributes
    }
    
    private let loggers: [LoggerProtocol]
    private let category: String
    private let tags: [String]?

    public var isEnabled: Bool = true
    
    public init(category: String, tags: String...) {
        self.loggers = Self.manager.buildLoggers(category: category, tags: tags)
        self.category = category
        self.tags = tags
    }

    public func log(
        _ level: LogLevel,
        message: String,
        _ tags: String...,
        error: Error? = nil,
        attributes: Attributes? = nil,
        file: String = #fileID,
        line: Int = #line
    ) {
        _log(level, message: message, tags: tags, error: error, attributes: attributes, file: file, line: line)
    }
    
    public func trace(
        _ message: String,
        _ tags: String...,
        error: Error? = nil,
        attributes: Attributes? = nil,
        file: String = #fileID,
        line: Int = #line
    ) {
        _log(.trace, message: message, tags: tags, error: error, attributes: attributes, file: file, line: line)
    }
    
    public func debug(
        _ message: String,
        _ tags: String...,
        error: Error? = nil,
        attributes: Attributes? = nil,
        file: String = #fileID,
        line: Int = #line
    ) {
        _log(.debug, message: message, tags: tags, error: error, attributes: attributes, file: file, line: line)
    }
    
    public func info(
        _ message: String,
        _ tags: String...,
        error: Error? = nil,
        attributes: Attributes? = nil,
        file: String = #fileID,
        line: Int = #line
    ) {
        _log(.info, message: message, tags: tags, error: error, attributes: attributes, file: file, line: line)
    }

    public func warning(
        _ message: String,
        _ tags: String...,
        error: Error? = nil,
        attributes: Attributes? = nil,
        file: String = #fileID,
        line: Int = #line
    ) {
        _log(.warning, message: message, tags: tags, error: error, attributes: attributes, file: file, line: line)
    }

    public func error(
        _ message: String,
        _ tags: String...,
        error: Error? = nil,
        attributes: Attributes? = nil,
        file: String = #fileID,
        line: Int = #line
    ) {
        _log(.error, message: message, tags: tags, error: error, attributes: attributes, file: file, line: line)
    }

    public func critical(
        _ message: String,
        _ tags: String...,
        error: Error? = nil,
        attributes: Attributes? = nil,
        file: String = #fileID,
        line: Int = #line
    ) {
        _log(.critical, message: message, tags: tags, error: error, attributes: attributes, file: file, line: line)
    }
    
}

private extension Logger {
    
    // MARK: Internal Log
    
    func _log(
        _ level: LogLevel,
        message: String,
        tags: [String],
        error: Error? = nil,
        attributes: Attributes? = nil,
        file: String = #fileID,
        line: Int = #line
    ) {
        guard isEnabled else { return }
        
        let mergedAttributes = mergingAttributes(attributes)
        let mergedTags = mergingTags(tags)
        let prefixedMessage = formatter.format(message, level: level, category: category, tags: mergedTags, error: error, with: Self.manager.messagePrefixes)
             
        loggers.forEach {
            guard level >= $0.minimumLogLevel else { return }
            
            $0.log(
                Log(
                    level: level,
                    message: $0.appendPrefixes ? prefixedMessage : message,
                    tags: mergedTags,
                    error: error,
                    attributes: mergedAttributes
                ),
                file: file,
                line: line
            )
        }
    }
    
    // MARK: Helpers
    
    private func mergingAttributes(_ attributes: Attributes?) -> Attributes? {
        guard !Self.manager.globalAttributes.isEmpty else { return attributes }
        return attributes?.merging(globalAttributes) { (current, new) in current }
    }
    
    private func mergingTags(_ tags: [String]?) -> [String]? {
        guard
            let logTags = tags,
            let loggerTags = self.tags
        else {
            return tags
        }
        return loggerTags.mergedWithUniqueValues(from: logTags)
    }
    
}
