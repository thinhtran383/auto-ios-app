import Foundation

// MARK: - Automation Settings Models
struct AutomationSettings {
    let networkReset: NetworkResetSettings
    let regionSettings: RegionSettings
    let timeZoneSettings: TimeZoneSettings
}

struct NetworkResetSettings {
    let enabled: Bool
    let confirmReset: Bool
}

struct RegionSettings {
    let targetRegion: String
    let targetCountry: String
}

struct TimeZoneSettings {
    let targetTimeZone: String
    let autoSetEnabled: Bool
}

// MARK: - Automation Actions
enum AutomationAction {
    case resetNetworkSettings
    case changeRegionToJapan
    case changeTimeZoneToTokyo
    case runAllScripts
}

// MARK: - Automation Status
enum AutomationStatus {
    case idle
    case running
    case completed
    case failed(String)
}

// MARK: - Default Settings
extension AutomationSettings {
    static let defaultSettings = AutomationSettings(
        networkReset: NetworkResetSettings(
            enabled: true,
            confirmReset: true
        ),
        regionSettings: RegionSettings(
            targetRegion: "Japan",
            targetCountry: "Japan"
        ),
        timeZoneSettings: TimeZoneSettings(
            targetTimeZone: "Asia/Tokyo",
            autoSetEnabled: true
        )
    )
}
