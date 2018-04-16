//
//  Logger.swift
//  Logger
//
//  Created by Evgeny Kalashnikov on 04.04.2018.
//  Copyright © 2018 Evgeny Kalashnikov. All rights reserved.
//

import Foundation

public protocol LoggerListener: class {
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
    private weak var listener: LoggerListener?
    
    public init(listener: LoggerListener? = nil) {
        self.listener = listener
    }
    
    public func fatal(_ any: Any?..., filePath: String = #file, line: Int = #line, functionName: String = #function) {
        self.log(any: any, prefix: "❌", filePath: filePath, line: line, functionName: functionName, listenerCall: self.listener?.loggedFatal)
    }
    
    public func fatal(_ any: Any..., filePath: String = #file, line: Int = #line, functionName: String = #function) {
        self.log(any: any, prefix: "❌", filePath: filePath, line: line, functionName: functionName, listenerCall: self.listener?.loggedFatal)
    }
    
    public func warning(_ any: Any?..., filePath: String = #file, line: Int = #line, functionName: String = #function) {
        self.log(any: any, prefix: "⚠️", filePath: filePath, line: line, functionName: functionName, listenerCall: self.listener?.loggedWarning)
    }
    
    public func warning(_ any: Any..., filePath: String = #file, line: Int = #line, functionName: String = #function) {
        self.log(any: any, prefix: "⚠️", filePath: filePath, line: line, functionName: functionName, listenerCall: self.listener?.loggedWarning)
    }
    
    public func success(_ any: Any?..., filePath: String = #file, line: Int = #line, functionName: String = #function) {
        self.log(any: any, prefix: "✅", filePath: filePath, line: line, functionName: functionName, listenerCall: self.listener?.loggedSuccess)
    }
    
    public func success(_ any: Any..., filePath: String = #file, line: Int = #line, functionName: String = #function) {
        self.log(any: any, prefix: "✅", filePath: filePath, line: line, functionName: functionName, listenerCall: self.listener?.loggedSuccess)
    }
    
    public func log(any: Any?..., prefix: String = "", filePath: String = #file, line: Int = #line, functionName: String = #function) {
        self.log(any: any, prefix: prefix, filePath: filePath, line: line, functionName: functionName, listenerCall: self.listener?.loggedCustom)
    }
    
    public func log(any: Any..., prefix: String = "", filePath: String = #file, line: Int = #line, functionName: String = #function) {
        self.log(any: any, prefix: prefix, filePath: filePath, line: line, functionName: functionName, listenerCall: self.listener?.loggedCustom)
    }
}

private extension Logger {
    func log(any: [Any?], prefix: String = "", filePath: String = #file, line: Int = #line, functionName: String = #function, listenerCall: ((_ text: String) -> Void)?) {
        let anys = any.compactMap { String(describing: $0) }.joined(separator: " | ")
        let fileName = URL(fileURLWithPath: filePath).lastPathComponent
        let text = "\(prefix) \(fileName):\(line) \(functionName) — \(anys)"
        listenerCall?(text)
        print(text)
    }
    
    func log(any: [Any], prefix: String = "", filePath: String = #file, line: Int = #line, functionName: String = #function, listenerCall: ((_ text: String) -> Void)?) {
        let anys = any.compactMap { String(describing: $0) }.joined(separator: " | ")
        let fileName = URL(fileURLWithPath: filePath).lastPathComponent
        let text = "\(prefix) \(fileName):\(line) \(functionName) — \(anys)"
        listenerCall?(text)
        print(text)
    }
}
