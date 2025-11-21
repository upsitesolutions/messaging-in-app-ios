//
//  TestEntryViewBuilder.swift
//  MessagingUIExample
//
//  Created by Jeremy Wright on 2024-09-17.
//  Copyright © 2024 Salesforce.com. All rights reserved.
//

import SwiftUI
import SMIClientCore
import SMIClientUI

struct TestEntryViewBuilder: ChatFeedViewBuilder {

    var renderMode: RenderModeClosure? {
        return { model in
            return .existing
        }
    }

    var completeView: CompleteViewClosure? {
        return { model, client in
            // No custom view replacement
            AnyView(EmptyView())
        }
    }
}
