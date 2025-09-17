import SwiftUI

struct SystemInfoView: View {
    @State private var systemInfo: [String: String] = [:]
    @State private var isJailbroken: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Device Information")) {
                    ForEach(Array(systemInfo.keys.sorted()), id: \.self) { key in
                        HStack {
                            Text(key)
                                .font(.subheadline)
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            Text(systemInfo[key] ?? "Unknown")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                }
                
                Section(header: Text("Jailbreak Status")) {
                    HStack {
                        Image(systemName: isJailbroken ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundColor(isJailbroken ? .green : .red)
                        
                        Text(isJailbroken ? "Device is Jailbroken" : "Device is NOT Jailbroken")
                            .font(.headline)
                            .foregroundColor(isJailbroken ? .green : .red)
                    }
                    
                    if isJailbroken {
                        Text("✅ Automation features are available")
                            .font(.caption)
                            .foregroundColor(.green)
                    } else {
                        Text("❌ Automation features require jailbreak")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                
                Section(header: Text("About")) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("BoxAutomation v1.0")
                            .font(.headline)
                        
                        Text("This app is designed for jailbroken iOS devices to automate system settings changes.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text("Features:")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("• Reset Network Settings")
                            Text("• Change Region to Japan")
                            Text("• Set Time Zone to Tokyo")
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("System Info")
            .onAppear {
                loadSystemInfo()
            }
        }
    }
    
    private func loadSystemInfo() {
        systemInfo = JailbreakDetection.shared.getSystemInfo()
        isJailbroken = JailbreakDetection.shared.isJailbroken()
    }
}
