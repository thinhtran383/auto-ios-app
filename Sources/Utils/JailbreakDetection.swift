import Foundation
import UIKit

// MARK: - Jailbreak Detection Utility
class JailbreakDetection {
    static let shared = JailbreakDetection()
    
    private init() {}
    
    // MARK: - Jailbreak Detection Methods
    
    func isJailbroken() -> Bool {
        return checkFileSystem() || checkURLSchemes() || checkSandbox() || checkDynamicLibraries()
    }
    
    private func checkFileSystem() -> Bool {
        let jailbreakFiles = [
            "/Applications/Cydia.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt",
            "/private/var/lib/apt/",
            "/private/var/Users/",
            "/var/log/syslog",
            "/private/var/tmp/cydia.log",
            "/private/var/lib/cydia",
            "/private/var/mobile/Library/SBSettings/Themes",
            "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
            "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
            "/private/var/stash"
        ]
        
        for file in jailbreakFiles {
            if FileManager.default.fileExists(atPath: file) {
                return true
            }
        }
        
        return false
    }
    
    private func checkURLSchemes() -> Bool {
        let jailbreakSchemes = [
            "cydia://",
            "undecimus://",
            "sileo://",
            "zbra://"
        ]
        
        for scheme in jailbreakSchemes {
            if let url = URL(string: scheme) {
                if UIApplication.shared.canOpenURL(url) {
                    return true
                }
            }
        }
        
        return false
    }
    
    private func checkSandbox() -> Bool {
        do {
            try "test".write(toFile: "/private/test.txt", atomically: true, encoding: .utf8)
            try FileManager.default.removeItem(atPath: "/private/test.txt")
            return true
        } catch {
            return false
        }
    }
    
    private func checkDynamicLibraries() -> Bool {
        let suspiciousLibraries = [
            "MobileSubstrate",
            "libsubstrate",
            "SubstrateInserter",
            "libhooker"
        ]
        
        let imageCount = _dyld_image_count()
        for i in 0..<imageCount {
            if let imageName = _dyld_get_image_name(i) {
                let name = String(cString: imageName)
                for library in suspiciousLibraries {
                    if name.contains(library) {
                        return true
                    }
                }
            }
        }
        
        return false
    }
    
    // MARK: - Jailbreak Tools Detection
    
    func getJailbreakTool() -> String? {
        if FileManager.default.fileExists(atPath: "/Applications/Cydia.app") {
            return "Cydia"
        }
        
        if FileManager.default.fileExists(atPath: "/Applications/Sileo.app") {
            return "Sileo"
        }
        
        if FileManager.default.fileExists(atPath: "/Applications/Zebra.app") {
            return "Zebra"
        }
        
        if let url = URL(string: "undecimus://") {
            if UIApplication.shared.canOpenURL(url) {
                return "unc0ver"
            }
        }
        
        if let url = URL(string: "chimera://") {
            if UIApplication.shared.canOpenURL(url) {
                return "Chimera"
            }
        }
        
        return nil
    }
    
    // MARK: - System Information
    
    func getSystemInfo() -> [String: String] {
        var info: [String: String] = [:]
        
        info["iOS Version"] = UIDevice.current.systemVersion
        info["Device Model"] = UIDevice.current.model
        info["Device Name"] = UIDevice.current.name
        
        if let jailbreakTool = getJailbreakTool() {
            info["Jailbreak Tool"] = jailbreakTool
        }
        
        info["Jailbroken"] = isJailbroken() ? "Yes" : "No"
        
        return info
    }
}
