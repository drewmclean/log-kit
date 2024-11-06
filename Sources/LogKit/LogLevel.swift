//
//  LogLevel.swift
//  
//
//  Created by Andrew McLean on 12/4/23.
//

import Foundation

public enum LogLevel: Int, CustomStringConvertible, Comparable, CaseIterable {
    case trace
    case debug
    case info
    case warning
    case error
    case critical

    var emojiPrefix: String? {
        switch self {
        case .trace:    return nil
        case .debug:    return nil
        case .info:     return "ℹ️"
        case .warning:  return "⚠️"
        case .error:    return "🔥"
        case .critical: return "⛔️"
        }
    }

    public var description: String {
        switch self {
        case .trace:    return ""
        case .info:     return "Info"
        case .debug:    return "Debug"
        case .warning:  return "Warn"
        case .error:    return "Error"
        case .critical: return "Critical"
        }
    }
    
    public static func < (lhs: LogLevel, rhs: LogLevel) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
