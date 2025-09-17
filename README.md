# BoxAutomation App 1 - Reset Network Settings

A SwiftUI-based iOS application designed for jailbroken devices to automatically reset network settings.

## Features

- **Reset Network Settings**: Automatically navigates to Settings → General → Reset → Reset Network Settings → Confirm
- **Jailbreak Detection**: Detects if the device is jailbroken and shows system information
- **Progress Tracking**: Real-time progress display during automation
- **Error Handling**: Comprehensive error handling and logging

## Requirements

- **iOS 14.0+**
- **Jailbroken iPhone/iPad**
- **Xcode 12.0+** (for building)

## Installation

### Building from Source

1. Clone this repository:
```bash
git clone <repository-url>
cd auto-ios-app
```

2. Open the project in Xcode:
```bash
open project.yml
```

3. Build and run on your device or simulator

### Building IPA File

To create an IPA file for distribution:

1. Open the project in Xcode
2. Select your target device
3. Go to Product → Archive
4. Export the archive as an IPA file

## Usage

1. **Launch the app** on your jailbroken device
2. **Check system info** by tapping the info button in the top-right corner
3. **Tap "Reset Network Settings"** to start the automation
4. **Follow the prompts** as the app navigates through Settings
5. **Device will restart** automatically after completion

## Automation Flow

### Reset Network Settings
1. Opens Settings → General
2. Navigates to Reset section
3. Selects Reset Network Settings
4. Confirms the reset action
5. Device restarts automatically

**Important**: Run this app AFTER restarting your device. After completion, run App 2 for the next automation steps.

## Technical Details

### Architecture
- **SwiftUI** for the user interface
- **Combine** for reactive programming
- **Async/Await** for asynchronous operations
- **Modular design** with separate services and utilities

### Key Components
- `ResetNetworkService`: Core automation logic for network reset
- `JailbreakDetection`: Device jailbreak status detection
- `AutomationLogger`: Logging and debugging
- `SystemInfoView`: Device information display

### Permissions
The app requires the following permissions:
- Access to Settings app (via URL schemes)
- File system access (for jailbreak detection)
- Network access (for potential future features)

## Security Notes

⚠️ **Important**: This app is designed specifically for jailbroken devices and will not work on non-jailbroken devices. The automation features require system-level access that is only available on jailbroken iOS devices.

## Troubleshooting

### Common Issues

1. **App won't open Settings**
   - Ensure the device is jailbroken
   - Check that the app has necessary permissions

2. **Automation scripts fail**
   - Verify jailbreak status in System Info
   - Make sure the device is unlocked during automation
   - Check that Settings app is accessible

3. **Build errors**
   - Ensure you're using Xcode 12.0 or later
   - Check that iOS 14.0+ deployment target is set
   - Verify all dependencies are properly linked

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test on a jailbroken device
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Disclaimer

This tool is for educational and personal use only. Users are responsible for ensuring compliance with their device's terms of service and local laws. The developers are not responsible for any damage to devices or data loss.