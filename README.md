# logger

You can print fatal, warning, success and your own log. Library add file name, line, function name and emoji for fast error finding

## Examples

### Example 1 (simple use)
```swift
import logger

let logger = Logger()
logger.fatal("any object 1", "any object 2") // can be optional

// result: ❌ "file name":4 "function name" — "any object 1" | "any object 2"
```

### Example 2 (with listener)
Listener can be used for sending reports to bug tracking system
```swift
import logger

let logger = Logger(listener: self)
logger.warning("any object 1", "any object 2") // can be optional

// result: ⚠️ "file name":4 "function name" — "any object 1" | "any object 2"


extension "class name": LoggerListener {

    func loggedFatal(text: String) {
        // send to bug tracking system
    }

    func loggedWarning(text: String) {
        // send to bug tracking system
    }

    func loggedSuccess(text: String) { // optional func
        // send to bug tracking system or do nothing
    }

    func loggedCustom(text: String) { // optional func
        // send to bug tracking system or do nothing
    }
}

```
