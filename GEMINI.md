# Project Context: Salesforce Messaging for In-App (iOS SDK)

## Overview
This project contains the iOS SDK and example applications for **Salesforce Messaging for In-App**. It enables developers to integrate customer support chat capabilities directly into iOS applications.

## Key Technologies
*   **Language:** Swift
*   **UI Framework:** SwiftUI
*   **SDKs:** `SMIClientUI`, `SMIClientCore`
*   **Dependency Management:** Swift Package Manager (SPM)

## Project Structure

*   **`examples/`**: Contains sample applications demonstrating SDK usage.
    *   **`MessagingUIExample/`**: A complete example using the `SMIClientUI` for a standard chat interface.
        *   **`Views/ContentView.swift`**: The main view containing the `AppConfiguration` struct and the `MIAW` (Messaging In-App Web) view initialization.
        *   **`MessagingUIExampleApp.swift`**: The app entry point.
    *   **`Shared/`**: Contains shared delegates and providers used across examples (e.g., `GlobalCoreDelegateHandler.swift`).
*   **`MessagingExample.xcworkspace`**: The Xcode workspace to open for development.

## Configuration
The application configuration is currently hardcoded in `examples/MessagingUIExample/Views/ContentView.swift` within the `AppConfiguration` struct:
*   `serviceAPI`: The Salesforce Service API URL.
*   `organizationId`: The Salesforce Organization ID.
*   `developerName`: The Developer Name for the messaging channel.

## Building and Running
1.  Open `MessagingExample.xcworkspace` in Xcode.
2.  Select the `MessagingUIExample` scheme.
3.  Ensure a valid iOS Simulator or device is selected.
4.  Run the application (Cmd+R).
5.  Dependencies (like `Swift-Package-InAppMessaging`) should be resolved automatically via SPM.

## Development Notes
*   **Delegates:** The project uses a `GlobalCoreDelegateHandler` singleton (in `examples/Shared/Delegates/CoreDelegate/`) to handle various SDK events and providing data to the SDK.
*   **Customization:** UI customization is demonstrated via `Localizable.strings` and asset catalogs in the `MessagingUIExample` directory.
