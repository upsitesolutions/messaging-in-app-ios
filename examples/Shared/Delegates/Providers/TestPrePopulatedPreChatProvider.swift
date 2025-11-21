//
//  TestPrePopulatedPreChatProvider.swift
//  MessagingUIExample
//
//  Created by Jeremy Wright on 2024-09-25.
//  Copyright © 2024 Salesforce.com. All rights reserved.
//

import Foundation
import SMIClientUI

struct TestPrePopulatedPreChatProvider {

    var closure: Interface.PreChatFieldValueClosure {
        return { preChatFields in
            // No pre-population logic
            return preChatFields
        }
    }
}
