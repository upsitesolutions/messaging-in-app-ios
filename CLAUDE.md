# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is the **Salesforce Messaging for In-App iOS SDK** repository. It provides iOS applications with customer support chat capabilities through the Salesforce Messaging platform. The repository contains example applications demonstrating SDK integration, not the SDK itself (which is distributed via Swift Package Manager).

## Technologies

- **Language**: Swift
- **UI Framework**: SwiftUI
- **Primary SDKs**:
  - `SMIClientUI` - High-level UI SDK with built-in chat interface
  - `SMIClientCore` - Lower-level Core SDK for custom UI implementations
- **Dependency Management**: Swift Package Manager (SPM)
- **Key Dependencies**:
  - `Swift-Package-InAppMessaging` (1.10.1) - Main SDK package
  - `SalesforceMobileSDK-iOS-SPM` (13.1.0) - Salesforce Mobile SDK
  - `SQLCipher.swift` (4.10.0) - Encrypted database support

## Building and Running

1. Open `MessagingExample.xcworkspace` (NOT the .xcodeproj file)
2. Select the `MessagingUIExample` scheme
3. Select a simulator or connected device
4. Run with Cmd+R
5. SPM dependencies will resolve automatically on first build

## Architecture

### SDK Layer Structure

The SDK has two primary layers:

1. **UI SDK (`SMIClientUI`)**: Provides out-of-the-box chat UI via the `Interface` view
2. **Core SDK (`SMIClientCore`)**: Provides lower-level access for custom UI implementations

### Example Application Structure

- **`examples/MessagingUIExample/`**: Main example using the UI SDK
  - **`Views/ContentView.swift`**: Entry point containing hardcoded `AppConfiguration` (serviceAPI, organizationId, developerName)
  - **`MessagingUIExampleApp.swift`**: SwiftUI app entry point

- **`examples/Shared/`**: Shared components used across examples
  - **`Delegates/CoreDelegate/GlobalCoreDelegateHandler.swift`**: Singleton delegate manager that coordinates all SDK callbacks
  - **`Delegates/CoreDelegate/GlobalCoreDelegateHandler+*.swift`**: Protocol extensions implementing specific SDK delegates:
    - `+ConversationClient.swift`: Handles participant updates and dynamic navigation titles
    - `+UserVerification.swift`: Handles authentication (JWT or Salesforce passthrough)
    - `+HiddenPreChat.swift`: Provides pre-chat field values
    - `+TemplatedURL.swift`: Handles URL templating
  - **`Delegates/Providers/`**: View and data providers for SDK customization:
    - `TestEntryViewBuilder.swift`: Chat feed view customization
    - `TestNavBarBuilder.swift`: Navigation bar customization
    - `TestPrePopulatedPreChatProvider.swift`: Pre-chat field population

### Delegate Pattern

The SDK uses a centralized delegate pattern through `GlobalCoreDelegateHandler`:

1. The singleton is initialized with various builder/provider instances
2. Delegates are registered on `CoreClient` or `ConversationClient` instances
3. The handler manages state through nested store classes (`NavBarReplacementStore`, `DelegateManagementStore`, `ConfigStore`, `UserVerificationStore`)
4. Protocol conformance is split across extension files for organization

### Configuration Flow

1. Create `Configuration` from `SMIClientCore` with service endpoint and org details
2. Create `UIConfiguration` from `SMIClientUI` with conversation ID
3. Optionally configure features (attachments, transcript downloads, end chat)
4. Pass builders/providers to `Interface` view initialization
5. Register delegates on `CoreFactory.create().conversationClient()`

### Key Concepts

- **Conversation ID**: UUID-based identifier for each chat session
- **Pre-chat**: Form fields collected before chat starts
- **Hidden pre-chat**: Values provided programmatically without user input
- **User Verification**: Authentication via JWT token or Salesforce passthrough
- **Templated URLs**: Dynamic URL substitution for embedded links

## Customization

Customization is done through:

1. **`Localizable.strings`**: String overrides (e.g., chat title)
2. **Asset Catalog**: Color/image overrides (e.g., `SMI.Error.colorset` for error message color)
3. **Builders/Providers**: Custom views and data sources passed to `Interface` view
4. **Delegates**: Implement SDK protocols for event handling and data provision

## Common Modifications

### Changing Service Configuration

Edit hardcoded values in `examples/MessagingUIExample/Views/ContentView.swift`:
```swift
struct AppConfiguration {
    static let serviceAPI = URL(string: "https://...")!
    static let organizationId = "..."
    static let developerName = "..."
}
```

### Adding Delegate Functionality

1. Add protocol conformance as extension in `examples/Shared/Delegates/CoreDelegate/`
2. Register in `GlobalCoreDelegateHandler.registerDelegates()`
3. Access state via appropriate store property on handler

### Customizing UI

- For string changes: Add entries to `examples/MessagingUIExample/Localizable.strings`
- For color changes: Add color sets to `examples/MessagingUIExample/Assets.xcassets/`
- For view changes: Modify builders in `examples/Shared/Delegates/Providers/`

## Navigation Compatibility

The `examples/Shared/VersionWrapping/` directory contains wrapped versions of SwiftUI components for backwards compatibility across iOS versions:
- `WrappedNavigationStack.swift`: NavigationStack/NavigationView wrapper
- `WrappedNavigationBarItems.swift`: Navigation bar item wrapper
- `WrappedKeyboardDismiss.swift`: Keyboard dismiss wrapper
