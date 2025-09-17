import Foundation
import os.log

// MARK: - Logger Utility
class AutomationLogger {
    static let shared = AutomationLogger()
    
    private let logger = Logger(subsystem: "com.example.boxautomation", category: "automation")
    
    private init() {}
    
    // MARK: - Logging Methods
    
    func logInfo(_ message: String) {
        logger.info("\(message)")
        print("ℹ️ [INFO] \(message)")
    }
    
    func logWarning(_ message: String) {
        logger.warning("\(message)")
        print("⚠️ [WARNING] \(message)")
    }
    
    func logError(_ message: String) {
        logger.error("\(message)")
        print("❌ [ERROR] \(message)")
    }
    
    func logSuccess(_ message: String) {
        logger.info("✅ \(message)")
        print("✅ [SUCCESS] \(message)")
    }
    
    func logAction(_ action: String) {
        logger.info("🎯 \(action)")
        print("🎯 [ACTION] \(action)")
    }
    
    // MARK: - Automation Specific Logging
    
    func logScriptStart(_ scriptName: String) {
        logInfo("Starting script: \(scriptName)")
    }
    
    func logScriptComplete(_ scriptName: String) {
        logSuccess("Script completed: \(scriptName)")
    }
    
    func logScriptFailed(_ scriptName: String, error: Error) {
        logError("Script failed: \(scriptName) - \(error.localizedDescription)")
    }
    
    func logNavigation(_ destination: String) {
        logAction("Navigating to: \(destination)")
    }
    
    func logTap(_ location: CGPoint) {
        logAction("Tapping at: \(location)")
    }
    
    func logDelay(_ seconds: Double) {
        logInfo("Waiting for \(seconds) seconds...")
    }
}

// MARK: - Logging Extensions
extension AutomationService {
    func logCurrentAction(_ action: String) {
        AutomationLogger.shared.logAction(action)
    }
    
    func logError(_ error: Error) {
        AutomationLogger.shared.logError(error.localizedDescription)
    }
    
    func logSuccess(_ message: String) {
        AutomationLogger.shared.logSuccess(message)
    }
}
