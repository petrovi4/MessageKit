//
//  ChatView.swift
//  ChatExample
//
//  Created by Kino Roy on 2020-07-18.
//  Copyright © 2020 MessageKit. All rights reserved.
//

#if canImport(SwiftUI)
import SwiftUI
#endif
import MessageKit

@available(iOS 13.0, *)
struct SwiftUIExampleView: View {
    
    @State var messages: [MessageType] = SampleData.shared.getMessages(count: 20)
    
    var body: some View {
        MessagesView(messages: $messages).onAppear {
            self.connectToMessageSocket()
        }.onDisappear {
            self.cleanupSocket()
        }
        .navigationBarTitle("SwiftUI Example", displayMode: .inline)
    }
    
    private func getInitialMessages() {
        SampleData.shared.getMessages(count: 20) { messages in
            DispatchQueue.main.async {
                self.messages.append(contentsOf: messages)
            }
        }
    }
    
    private func connectToMessageSocket() {
        MockSocket.shared.connect(with: [SampleData.shared.nathan, SampleData.shared.wu]).onNewMessage { message in
            self.messages.append(message)
        }
    }
    
    private func cleanupSocket() {
        MockSocket.shared.disconnect()
    }
    
}

@available(iOS 13.0.0, *)
struct SwiftUIExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIExampleView()
    }
}
