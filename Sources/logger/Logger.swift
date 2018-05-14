//
//  Logger.swift
//  Logger
//
//  Created by Evgeny Kalashnikov on 04.04.2018.
//  Copyright © 2018 Evgeny Kalashnikov. All rights reserved.
//

import Foundation

public protocol LoggerListener {
    func loggedFatal(text: String)
    func loggedWarning(text: String)
    func loggedSuccess(text: String)
    func loggedCustom(text: String)
}

public extension LoggerListener {
    func loggedSuccess(text: String) { /* for optional protocoling */ }
    func loggedCustom(text: String) { /* for optional protocoling */ }
}

public class Logger {
    private static var listeners = [String : LoggerListener]()
    
    public static func register<T: LoggerListener>(listener: T) {
        self.listeners["\(T.self)"] = listener
    }
    
    public static func removeListener<T: LoggerListener>(type: T.Type) {
        self.listeners.removeValue(forKey: "\(T.self)")
    }
    
    public static func removeAllListeners() {
        self.listeners.removeAll()
    }
    
    public static func fatal(_ any: Any?..., filePath: String = #file, line: Int = #line, functionName: String = #function) {
        self.log(any: any, prefix: "❌", filePath: filePath, line: line, functionName: functionName, listenerCall: { text in
            self.listeners.forEach({ (listener) in
                listener.value.loggedFatal(text: text)
            })
        })
    }
    
    public static func fatal(_ any: Any..., filePath: String = #file, line: Int = #line, functionName: String = #function) {
        self.log(any: any, prefix: "❌", filePath: filePath, line: line, functionName: functionName, listenerCall: { text in
            self.listeners.forEach({ (listener) in
                listener.value.loggedFatal(text: text)
            })
        })
    }
    
    public static func warning(_ any: Any?..., filePath: String = #file, line: Int = #line, functionName: String = #function) {
        self.log(any: any, prefix: "⚠️", filePath: filePath, line: line, functionName: functionName, listenerCall: { text in
            self.listeners.forEach({ (listener) in
                listener.value.loggedWarning(text: text)
            })
        })
    }
    
    public static func warning(_ any: Any..., filePath: String = #file, line: Int = #line, functionName: String = #function) {
        self.log(any: any, prefix: "⚠️", filePath: filePath, line: line, functionName: functionName, listenerCall: { text in
            self.listeners.forEach({ (listener) in
                listener.value.loggedWarning(text: text)
            })
        })
    }
    
    public static func success(_ any: Any?..., filePath: String = #file, line: Int = #line, functionName: String = #function) {
        self.log(any: any, prefix: "✅", filePath: filePath, line: line, functionName: functionName, listenerCall: { text in
            self.listeners.forEach({ (listener) in
                listener.value.loggedSuccess(text: text)
            })
        })
    }
    
    public static func success(_ any: Any..., filePath: String = #file, line: Int = #line, functionName: String = #function) {
        self.log(any: any, prefix: "✅", filePath: filePath, line: line, functionName: functionName, listenerCall: { text in
            self.listeners.forEach({ (listener) in
                listener.value.loggedSuccess(text: text)
            })
        })
    }
    
    public static func log(any: Any?..., prefix: String = "", filePath: String = #file, line: Int = #line, functionName: String = #function) {
        self.log(any: any, prefix: prefix, filePath: filePath, line: line, functionName: functionName, listenerCall: { text in
            self.listeners.forEach({ (listener) in
                listener.value.loggedCustom(text: text)
            })
        })
    }
    
    public static func log(any: Any..., prefix: String = "", filePath: String = #file, line: Int = #line, functionName: String = #function) {
        self.log(any: any, prefix: prefix, filePath: filePath, line: line, functionName: functionName, listenerCall: { text in
            self.listeners.forEach({ (listener) in
                listener.value.loggedCustom(text: text)
            })
        })
    }
}

private extension Logger {
    static func log(any: [Any?], prefix: String = "", filePath: String = #file, line: Int = #line, functionName: String = #function, listenerCall: ((_ text: String) -> Void)?) {
        let anys = any.compactMap { String(describing: $0) }.joined(separator: " | ")
        let fileName = URL(fileURLWithPath: filePath).lastPathComponent
        let text = "\(prefix) \(fileName):\(line) \(functionName) — \(anys)"
        listenerCall?(text)
        print(text)
    }
    
    static func log(any: [Any], prefix: String = "", filePath: String = #file, line: Int = #line, functionName: String = #function, listenerCall: ((_ text: String) -> Void)?) {
        let anys = any.compactMap { String(describing: $0) }.joined(separator: " | ")
        let fileName = URL(fileURLWithPath: filePath).lastPathComponent
        let text = "\(prefix) \(fileName):\(line) \(functionName) — \(anys)"
        listenerCall?(text)
        print(text)
    }
}
