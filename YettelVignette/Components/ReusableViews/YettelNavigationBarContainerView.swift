// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct YettelNavigationBarContainerView<Content: View>: View {
    
    @Binding var path: NavigationPath
    let content: Content
    
    init(path: Binding<NavigationPath>,
        @ViewBuilder content: () -> Content) {
        _path = path
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    YettelNavigationView(topInset: geometry.safeAreaInsets.top)
                    
                    content
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .edgesIgnoringSafeArea(.top)
            }
            
            .navigationBarHidden(true)
        }
        
    }
}

// MARK: - Preview
#Preview {
    YettelNavigationBarContainerView(path: .constant(NavigationPath())) {
        Text("Test")
    }
}
