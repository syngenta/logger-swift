//
//  Logger.swift
//  Logger
//
//  Created by Evgeny Kalashnikov on 04.04.2018.
//  Copyright © 2018 Evgeny Kalashnikov. All rights reserved.
//

import Foundation

protocol LoggerListener: class {
    func loggedFatal(text: String)
    func loggedWarning(text: String)
    func loggedSuccess(text: String)
    func loggedCustom(text: String)
}

extension LoggerListener {
    func loggedSuccess(text: String) { /* for optional protocoling */ }
    func loggedCustom(text: String) { /* for optional protocoling */ }
}

class Logger { 
    weak var listener: LoggerListener?
    
    init(listener: LoggerListener? = nil) {
        self.listener = listener
    }
    
    func fatal(_ any: Any?..., filePath: String = #file, line: Int = #line, functionName: String = #function) {
        self.log(any: any, prefix: "❌", filePath: filePath, line: line, functionName: functionName, listenerCall: self.listener?.loggedFatal)
    }
    
    func fatal(_ any: Any..., filePath: String = #file, line: Int = #line, functionName: String = #function) {
        self.log(any: any, prefix: "❌", filePath: filePath, line: line, functionName: functionName, listenerCall: self.listener?.loggedFatal)
    }
    
    func warning(_ any: Any?..., filePath: String = #file, line: Int = #line, functionName: String = #function) {
        self.log(any: any, prefix: "⚠️", filePath: filePath, line: line, functionName: functionName, listenerCall: self.listener?.loggedWarning)
    }
    
    func warning(_ any: Any..., filePath: String = #file, line: Int = #line, functionName: String = #function) {
        self.log(any: any, prefix: "⚠️", filePath: filePath, line: line, functionName: functionName, listenerCall: self.listener?.loggedWarning)
    }
    
    func success(_ any: Any?..., filePath: String = #file, line: Int = #line, functionName: String = #function) {
        self.log(any: any, prefix: "✅", filePath: filePath, line: line, functionName: functionName, listenerCall: self.listener?.loggedSuccess)
    }
    
    func success(_ any: Any..., filePath: String = #file, line: Int = #line, functionName: String = #function) {
        self.log(any: any, prefix: "✅", filePath: filePath, line: line, functionName: functionName, listenerCall: self.listener?.loggedSuccess)
    }
    
    func log(any: Any?..., prefix: String = "", filePath: String = #file, line: Int = #line, functionName: String = #function) {
        self.log(any: any, prefix: prefix, filePath: filePath, line: line, functionName: functionName, listenerCall: self.listener?.loggedCustom)
    }
    
    func log(any: Any..., prefix: String = "", filePath: String = #file, line: Int = #line, functionName: String = #function) {
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
