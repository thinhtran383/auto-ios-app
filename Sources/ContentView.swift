import SwiftUI

struct ResetNetworkView: View {
    @StateObject private var automationService = ResetNetworkService()
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var showingSystemInfo = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Header
                VStack(spacing: 8) {
                    HStack {
                        Text("BoxAutomation App 1")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Button(action: {
                            showingSystemInfo = true
                        }) {
                            Image(systemName: "info.circle")
                                .font(.title2)
                                .foregroundColor(.blue)
                        }
                    }
                    
                    Text("Reset Network Settings")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 20)
                
                // Status Section
                VStack(spacing: 12) {
                    HStack {
                        Text("Status:")
                            .font(.headline)
                        Spacer()
                        StatusBadge(status: automationService.status)
                    }
                    
                    if automationService.status == .running {
                        ProgressView(value: automationService.progress)
                            .progressViewStyle(LinearProgressViewStyle())
                        
                        Text(automationService.currentAction)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Main Action Button
                Button(action: {
                    Task {
                        await automationService.resetNetworkSettings()
                    }
                }) {
                    HStack {
                        Image(systemName: "wifi.slash")
                        Text("Reset Network Settings")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(12)
                }
                .disabled(automationService.status == .running)
                
                Spacer()
                
                // Instructions
                VStack(alignment: .leading, spacing: 8) {
                    Text("Instructions:")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• Run this app AFTER restarting your device")
                        Text("• This will reset all network settings")
                        Text("• Device will restart automatically after completion")
                        Text("• Run App 2 after device restarts")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
            }
            .padding()
            .navigationBarHidden(true)
        }
        .alert("Error", isPresented: $showingAlert) {
            Button("OK") { }
        } message: {
            Text(alertMessage)
        }
        .onChange(of: automationService.status) { status in
            if case .failed(let error) = status {
                alertMessage = error
                showingAlert = true
            }
        }
        .sheet(isPresented: $showingSystemInfo) {
            SystemInfoView()
        }
    }
}

// MARK: - Supporting Views

struct StatusBadge: View {
    let status: AutomationStatus
    
    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(statusColor)
                .frame(width: 8, height: 8)
            
            Text(statusText)
                .font(.caption)
                .fontWeight(.medium)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(statusColor.opacity(0.2))
        .cornerRadius(8)
    }
    
    private var statusColor: Color {
        switch status {
        case .idle:
            return .gray
        case .running:
            return .blue
        case .completed:
            return .green
        case .failed:
            return .red
        }
    }
    
    private var statusText: String {
        switch status {
        case .idle:
            return "Ready"
        case .running:
            return "Running"
        case .completed:
            return "Completed"
        case .failed:
            return "Failed"
        }
    }
}
