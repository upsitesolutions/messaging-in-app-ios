# Salesforce Messaging for In-App (iOS SDK)

## Project Overview
This repository contains example applications for the Salesforce Messaging for In-App iOS SDK. It demonstrates how to integrate Salesforce messaging capabilities into iOS applications using two distinct approaches:
1.  **MessagingUIExample:** Uses the high-level **UI SDK** (`SMIClientUI`) which provides a ready-to-use user interface for messaging.
2.  **MessagingCoreExample:** Uses the low-level **Core SDK** (`SMIClientCore`) which allows for building a completely custom user interface while leveraging the underlying messaging logic.

**Key Technologies:**
*   **Languages:** Swift
*   **Frameworks:** SwiftUI, UIKit
*   **Salesforce SDKs:** SMIClientCore, SMIClientUI

## Directory Structure
*   `examples/MessagingUIExample/`: A complete example using the out-of-the-box UI.
*   `examples/MessagingCoreExample/`: An example demonstrating custom UI implementation using the Core SDK.
*   `examples/Shared/`: Shared resources and helper code used by the examples.

## Building and Running

### Prerequisites
*   Xcode (latest stable version recommended)
*   CocoaPods (if dependencies are managed via Pods, though this project seems to use Swift Package Manager or direct xcframework integration - verify in project settings). *Note: The file list suggests a standard `.xcodeproj` and `.xcworkspace` setup.*

### Steps
1.  **Open the Project:**
    *   Navigate to `examples/` and open `MessagingExample.xcworkspace`.
    *   Alternatively, open individual project files (`.xcodeproj`) if you only want to work on one example, but the workspace is preferred for shared context.

2.  **MessagingUIExample Setup:**
    *   Build and run the `MessagingUIExample` scheme.
    *   On launch, navigate to the app's **Settings** screen.
    *   Enter your **Connection Environment** details (Organization ID, Deployment ID, etc.) obtained from your Salesforce Embedded Service deployment.

3.  **MessagingCoreExample Setup:**
    *   Locate the `configFile.json` file in `examples/MessagingCoreExample/`.
    *   **Action Required:** You must replace this file with the `configFile.json` downloaded from your Salesforce Org (Setup > Embedded Service Deployments).
    *   The file is loaded in `MessagingViewModel.swift` via `Bundle.main.path(forResource: "configFile", ofType: "json")`.

## Development Conventions

*   **Architecture:** The Core example follows an **MVVM (Model-View-ViewModel)** pattern.
    *   **ViewModels:** Handle business logic and SDK interaction (e.g., `MessagingViewModel.swift`).
    *   **Views:** SwiftUI views for the UI (e.g., `ContentView.swift`).
*   **Delegates:** The SDK relies heavily on the delegate pattern for handling asynchronous events and optional features:
    *   `HiddenPreChatDelegate`: For handling pre-chat fields without user interaction.
    *   `UserVerificationDelegate`: For authenticating users.
    *   `TemplatedUrlDelegate`: For handling auto-responses and links.
*   **Configuration:**
    *   **Core SDK:** Configured via `Configuration` object created from a JSON file URL.
    *   **UI SDK:** Configured via `ConnectionConfig` objects passed to the UI controller.
*   **Logging:** Debug logging is enabled via `Logging.level = .debug` in debug builds.

## Important Files
*   `examples/MessagingCoreExample/Models/MessagingViewModel.swift`: Core logic for initializing the client, sending messages, and handling delegates.
*   `examples/Shared/Delegates/CoreDelegate/GlobalCoreDelegateHandler.swift`: Centralized handler for core SDK events.
*   `examples/MessagingUIExample/MessagingUIExampleApp.swift`: Entry point for the UI-based example.
