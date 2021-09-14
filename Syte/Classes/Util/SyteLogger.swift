//
//  SyteLogger.swift
//  Syte
//
//  Created by Artur Tarasenko on 19.08.2021.
//  Copyright © 2021 Syte.ai. All rights reserved.
//

import Foundation
import os.log

public final class SyteLogger {
    
    public enum LogLevel {
        case verbose, info, debug, warn, error
    }
    
    private static var logLevel = LogLevel.verbose
    private static let syteKeyword = ":SYTE:"
    
    private static func appendTag(tag: String) -> String {
        return syteKeyword + tag
    }
    
    public static func setLogLevel(_ level: LogLevel) {
        logLevel = level
    }
    
    public static func getLogLevel() -> LogLevel {
        return logLevel
    }
    
    public static func v(tag: String, message: String) {
        guard logLevel == .verbose else { return }
        log(type: .default, tag: tag, message: message)
    }
    
    public static func i(tag: String, message: String) {
        guard logLevel == .info else { return }
        log(type: .info, tag: tag, message: message)
    }
    
    public static func d(tag: String, message: String) {
        guard logLevel == .debug else { return }
        log(type: .debug, tag: tag, message: message)
    }
    
    public static func w(tag: String, message: String) {
        guard logLevel == .warn else { return }
        log(type: .error, tag: tag, message: message)
    }
    
    public static func e(tag: String, message: String) {
        guard logLevel == .error else { return }
        log(type: .fault, tag: tag, message: message)
    }
    
    private static func log(type: OSLogType, tag: String, message: String) {
        os_log("%@: %@", log: .syte, type: type, tag, message)
    }
    
}

extension OSLog {
    
    private static var subsystem = Bundle.main.bundleIdentifier ?? ""
    static let syte = OSLog(subsystem: subsystem, category: "SYTE")
    
}
