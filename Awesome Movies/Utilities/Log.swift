import Foundation
import os

public enum Category: String {
    case event = "Event"
    case state = "State"
    case models = "Models"
    case other = "Other"
}

public enum Log {
    private static var subsystem = Bundle.main.bundleIdentifier!

    public static func error(_ message: String, category: Category = .other) {
        log(message, category: category, type: .error)
    }

    public static func warning(_ message: String, category: Category = .other) {
        log(message, category: category, type: .fault)
    }

    public static func info(_ message: String, category: Category = .other) {
        log(message, category: category, type: .info)
    }

    public static func debug(_ message: String, category: Category = .other) {
        log(message, category: category, type: .debug)
    }

    private static func log(_ message: String, category: Category, type: OSLogType) {
        let logger = Logger(subsystem: subsystem, category: category.rawValue)
        switch type {
        case .error:
            logger.error("\(message, privacy: .public)")
        case .fault:
            logger.fault("\(message, privacy: .public)")
        case .info:
            logger.info("\(message, privacy: .public)")
        case .debug:
            logger.debug("\(message, privacy: .public)")
        default:
            logger.log("\(message, privacy: .public)")
        }
    }
}
