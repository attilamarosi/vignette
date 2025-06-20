// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct VehicleItemView: View {
    
    var vehicle: Vehicle
    
    var body: some View {
        HStack(spacing: .padding16) {
            
            // Vehicle icon
            Image("icon-car")
                .padding(.leading, .padding16)
            
            // Vehicle owner and platenumber
            VStack(alignment: .leading) {
                Text(vehicle.plateNumber)
                    .font(.headingMain)
                Text(vehicle.name)
                    .font(.paragraphSmall)
            }
            
            Spacer()
        }
        .frame(height: .height72)
        .background(Color.colorWhite)
        .cornerRadius(.cornerRadius8)
    }
}

// MARK: - Previews
#Preview {
    VehicleItemView(vehicle: Mocks.vehicle)
}
