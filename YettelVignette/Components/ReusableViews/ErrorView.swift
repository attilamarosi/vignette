// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct ErrorView: View {
    
    let model: ErrorModel
    
    @State private var isPresented: Bool = false
    @State private var offset: CGFloat = 1000
    @State private var opacity: Double = 0
    
    var body: some View {
        VStack {
            Spacer()
            
            // Image
            HStack {
                Image("robot")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: .height200)
                Spacer()
            }
            
            // Error code or title
            HStack {
                Text(String(localized: "error_main_title"))
                    .font(.headingExtraLarge)
                Spacer()
            }
            
            // Information
            HStack {
                Text(model.error.errorDescription ?? "")
                    .font(.paragraphMain)
                Spacer()
            }
            
            Spacer()
            
            // Button
            CTAButton(style: .primary,
                      title: String(localized: "common_ok")) {
                withAnimation(.easeInOut) {
                    offset = 1000
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        model.dismissAction?()
                    }
                }
            }
           
        }
        .padding(.height48)
        .background(.colorLime)
        .offset(y: offset)
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeOut(duration: 0.4)) {
                offset = 0
                opacity = 1
            }
        }
    }
}

// MARK: - Previews
#Preview {
    ErrorView(model: ErrorModel(error: .badRequest))
}

