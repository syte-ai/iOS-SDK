import Foundation

struct Logger {
    static var isDebugging = false
    static func start(url: String) {
        if isDebugging {
            print("FETCH STARTED: \(url)")
        }
    }
    
    static func succeed(response: Any?) {
        if isDebugging {
            print("FETCH SUCCEEDED: \(response ?? "")")
        }
    }
    
    static func fail(error: Any?) {
        if isDebugging {
            print("FETCH FAILED: \(error ?? "")")
        }
    }
    
}
