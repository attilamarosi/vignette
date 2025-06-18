// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct PopupView: View {
    
    @Binding var dismiss: Bool
    let model: PopupModel
    
    @State private var offset: CGFloat = 1000
    @State private var opacity: CGFloat = 0
    
    private let cornerSize: CGFloat = .height48
    
    var body: some View {
        ZStack {
            // Fading color
            Color.colorNavy.opacity(opacity)
                .edgesIgnoringSafeArea(.all)
            
            
            // Popup Content
            VStack {
                Spacer()
                
                Rectangle()
                    .frame(height: .height300)
                    .foregroundStyle(.colorLime)
                    .clipShape(RoundedCornerShape(corners: [.topLeft, .topRight],
                                                  radius: cornerSize))
                    .overlay(content: {
                        VStack {
                           
                            Spacer()
                            
                            // Title
                            Text(model.title)
                                .foregroundStyle(.colorNavy)
                                .font(.headingLarge)
                                .padding(.bottom, .padding8)
                                .multilineTextAlignment(.center)
                            
                            
                            // Description or custom message
                            if let description = model.description {
                                Text(description)
                                    .font(.paragraphMain)
                                    .lineLimit(3)
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom, .padding8)
                            } else if let customMessage = model.customMessage {
                                Text(customMessage)
                                    .font(.paragraphMain)
                                    .lineLimit(3)
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom, .padding8)
                            }

                            Spacer()
                            
                            // Button(s)
                            HStack {
                                ForEach(model.buttons, id: \.id) { button in
                                    CTAButton(style: button.style,
                                              title: button.title) {
                                        button.action()  // Execute the original button action
                                    }
                                }
                            }
                        }
                        .padding(.padding16)
                    })
                .offset(y: offset)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            openPopup()
        }
    }
    
    // MARK: - Private Methods
    private func openPopup() {
        withAnimation(.easeInOut(duration: 0.6)) {
            offset = 0
            opacity = 0.75
        }
    }
    
    private func dismissPopup() {
        withAnimation(.easeInOut) {
            offset = 1000
            opacity = 0
            dismiss = true
        }
    }
}

// MARK: - Previews
#Preview {
    PopupView(dismiss: .constant(false),
              model: PopupModel(style: .warning,
                                title: "Figyelem",
                                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In congue non libero vel lacinia. Nam porta ultricies luctus. Aenean vel consequat mi. Donec a nulla ac arcu euismod varius ut quis.",
                                buttons: [
                                    CTAButton(style: .primary,
                                              title: String(localized: "common_ok"),
                                              action: {}),
                                    CTAButton(style: .secondary,
                                              title: String(localized: "common_cancel"),
                                              action: {})
                                ]))
}
