import Foundation

public class SyteError {
    
    var code: Int = 0
    var message: String?
    var data: Any?
    
    init(response: URLResponse?, error: Error?) {
        code = (response as? HTTPURLResponse)?.statusCode ?? 0
        message = error?.localizedDescription
        data = error
//        Logger.fail(error: error)
    }
    
    init(code: Int, message: String?, data: AnyObject?) {
        self.code = code
        self.message = message
        self.data = data
//        Logger.fail(error: data)
    }
    
    init(message: String, data: AnyObject?) {
        self.message = message
        self.data = data
//        Logger.fail(error: data)
    }
    init() {}
    
}

class NoInternetError: SyteError {
    
    override init() {
        super.init()
        code = -1001
        message = "No internet connection"
//        Logger.fail(error: message!)
    }
    
}

class InvalidApiError: SyteError {
    
    init(url: String) {
        super.init()
        code = 1002
        message = "API \(url) is invalid"
//        Logger.fail(error: url)
    }
    
}

class NoValidDataError: SyteError {
    
    init(rawData: AnyObject) {
        super.init()
        code = 1003
        message = "No valid data"
        data = rawData
//        Logger.fail(error: rawData)
    }
    
}

class NoDataError: SyteError {
    
    init(rawData: AnyObject?) {
        super.init()
        code = 1003
        message = "No valid data"
        data = rawData
//        Logger.fail(error: rawData)
    }
    
}

class UnauthorizationError: SyteError {
    
    init(config: Config) {
        super.init()
        code = 401
        message = "No accountID or token"
        data = [
            "accountID": config.accountID,
            "token": config.token
        ]
    }
    
}
