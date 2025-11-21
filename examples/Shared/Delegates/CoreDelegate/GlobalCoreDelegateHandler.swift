//
//  GlobalCoreDelegateHandler.swift
//  MessagingUIExample
//
//  Created by Jeremy Wright on 2024-09-12.
//  Copyright © 2024 Salesforce.com. All rights reserved.
//

import Foundation
import SMIClientCore
import SalesforceSDKCore

class NavBarReplacementStore {
    var dynamicTitleReplacement = true
}

class DelegateManagementStore {
    var templatedURLValues: [String: String] = [:]
    var hiddenPreChatValues: [String: String] = [:]
}

enum AuthorizationMethod {
    case userVerified
    case passthrough
}

class ConfigStore {
    var authorizationMethod: AuthorizationMethod = .userVerified
}

class UserVerificationStore {
    var tokenJWT: String = ""
}

class AuthHelper {
    static func loginIfRequired(completion: @escaping () -> Void) {
        completion()
    }
}

@objc class GlobalCoreDelegateHandler: NSObject {
    static let shared = GlobalCoreDelegateHandler()

    let viewBuilder: TestEntryViewBuilder = TestEntryViewBuilder()
    let navBarBuilder: TestNavBarBuilder = TestNavBarBuilder()
    let prePopulatedPreChatProvider: TestPrePopulatedPreChatProvider = TestPrePopulatedPreChatProvider()
    let navBarReplacementStore = NavBarReplacementStore()
    let delegateManagementStore = DelegateManagementStore()
    let configStore = ConfigStore()
    let userVerificationStore = UserVerificationStore()
    var client: ConversationClient?

    func registerDelegates(_ core: CoreClient?) {
        core?.setPreChatDelegate(delegate: self, queue: .main)
        core?.setTemplatedUrlDelegate(delegate: self, queue: .main)
        core?.setUserVerificationDelegate(delegate: self, queue: .main)
    }

    func registerDelegates(_ client: ConversationClient) {
        registerDelegates(client.core)

        self.client = client
        navBarBuilder.client = client
        self.client?.addDelegate(delegate: self, queue: .main)
    }
}
