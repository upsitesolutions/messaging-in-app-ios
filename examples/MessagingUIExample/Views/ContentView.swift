//
//  ContentView.swift
//

import SwiftUI
import SMIClientUI
import SMIClientCore

struct ContentView: View {
    @State private var conversationIDString = UUID().uuidString

    var body: some View {
        WrappedNavigationStack {
            VStack {
                TextField("Enter Conversation UUID", text: $conversationIDString)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                
                NavigationLink("Start Chat") {
                    if let uuid = UUID(uuidString: conversationIDString) {
                        MIAW(conversationID: uuid)
                    }
                }
                .disabled(UUID(uuidString: conversationIDString) == nil)
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
    let conversationID: UUID
    
    var body: some View {
        let coreConfig = Configuration(serviceAPI: serviceAPI,
                                       organizationId: organizationId,
                                       developerName: developerName,
                                       userVerificationRequired: false)
        
        let config = UIConfiguration(configuration: coreConfig,
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
