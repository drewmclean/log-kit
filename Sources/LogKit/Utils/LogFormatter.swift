//
//  LogFormatter.swift
//
//
//  Created by Andrew McLean on 12/10/23.
//

import Foundation

struct LogFormatter {
    
    func format(_ message: String, level: LogLevel, category: String, tags: [String]?, error: Error?, with prefixes: [LogMessagePrefix]) -> String {
        if prefixes.isEmpty { return message }
        
        var prefixFormats: [String] = []
        var args: [String] = []
        prefixes.forEach { prefix in
            switch prefix {
            case .category:
                prefixFormats.append(LogMessagePrefix.formatString)
                args.append(category)
            case .level:
                if let emoji = level.emojiPrefix {
                    prefixFormats.append("%@")
                    args.append(emoji)
                }
            case .tags:
                tags?.forEach { tag in
                    prefixFormats.append(LogMessagePrefix.formatString)
                    args.append(tag)
                }
            }
        }
        
        var format = "\(prefixFormats.joined(separator: " ")) %@"
        
        args.append(message)
        
        if let error = error {
            format += " Error: %@"
            args.append(error.localizedDescription)
        }

        return String(format: format, arguments: args)
    }
}
