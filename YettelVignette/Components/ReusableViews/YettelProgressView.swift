// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct YettelProgressView: View {

    @State private var pulsing: Bool = false

    var body: some View {
        VStack {
            ZStack {
                
                Color.colorNavy
                    .edgesIgnoringSafeArea(.all)
                
                Circle()
                    .fill(.colorLime)
                    .frame(width: .width48, height: .height48)
                    .opacity(0.5)
                    .scaleEffect(pulsing ? 1 : 0.5)
                    .opacity(pulsing ? 1 : 0)
                    .animation(.easeInOut(duration: 0.75).repeatForever(autoreverses: true),
                               value: pulsing)
                Circle()
                    .fill(.colorNavy)
                    .frame(width: .width36, height: .height36)
                    .opacity(0.75)
                    .scaleEffect(pulsing ? 1 : 0.25)
                    .opacity(pulsing ? 1 : 0)
                    .clipped()
                    .animation(.easeInOut(duration: 0.75).repeatForever(autoreverses: true).delay(0.2),
                               value: pulsing)
                
                Circle()
                    .fill(.colorLime)
                    .frame(width: .width24, height: .height24)
                    .opacity(0.75)
                    .scaleEffect(pulsing ? 1 : 0.12)
                    .opacity(pulsing ? 1 : 0)
                    .clipped()
                    .animation(.easeInOut(duration: 0.75).repeatForever(autoreverses: true).delay(0.4),
                               value: pulsing)
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.colorGrey)
            .edgesIgnoringSafeArea(.all)
            .task { @MainActor in
                pulsing = true
            }
        }
    }
}


// MARK: - Previews
#Preview {
    YettelProgressView()
}
