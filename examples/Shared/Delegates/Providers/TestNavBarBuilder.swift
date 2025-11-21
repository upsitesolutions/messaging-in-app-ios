//
//  TestNavBarBuilder.swift
//  MessagingUIExample
//
//  Created by Nigel Brown on 2025-06-19.
//  Copyright © 2025 Salesforce.com. All rights reserved.
//

import SwiftUI
import SMIClientCore
import SMIClientUI

class TestNavBarBuilder: NavigationBarBuilder {
    var client: ConversationClient?

    override init() {
        super.init()

        self.handleNavigation = { screenType, navigationItem in
            // No custom navigation handling
        }
    }
}
