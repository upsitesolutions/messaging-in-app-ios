//
//  ContentView.swift
//

import SwiftUI
import SMIClientUI
import SMIClientCore

struct ContentView: View {
    var body: some View {
        WrappedNavigationStack {
            VStack {
                NavigationLink("Start Chat") {
                    MIAW()
                }
                // .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Messaging")
        }
    }
}

struct MIAW: View {
    // Hardcoded Configuration - Replace with your actual values
    private let serviceAPI = URL(string: "https://bnh--miaw.sandbox.my.salesforce-scrt.com")!
    private let organizationId = "00DD30000001Vmq"
    private let developerName = "MIAW"
    private let conversationID = UUID()
    
    var body: some View {
        let coreConfig = Configuration(serviceAPI: serviceAPI,
                                       organizationId: organizationId,
                                       developerName: developerName,
                                       userVerificationRequired: false)
        
        var config = UIConfiguration(configuration: coreConfig,
                                     conversationId: conversationID)
        
        // Optional configurations
        // config.urlDisplayMode = .inlineBrowser
        config.conversationOptionsConfiguration = ConversationOptionsConfiguration(allowEndChat: true)
        config.transcriptConfiguration = TranscriptConfiguration(allowTranscriptDownload: true)
        config.attachmentConfiguration = AttachmentConfiguration(endUserToAgent: true)

        return Interface(config,
                         preChatFieldValueProvider: GlobalCoreDelegateHandler.shared.prePopulatedPreChatProvider.closure,
                         chatFeedViewBuilder: GlobalCoreDelegateHandler.shared.viewBuilder,
                         navigationBarBuilder: GlobalCoreDelegateHandler.shared.navBarBuilder)
        .onAppear(perform: {
            let client = CoreFactory.create(withConfig: config).conversationClient(with: conversationID)
            GlobalCoreDelegateHandler.shared.registerDelegates(client)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
