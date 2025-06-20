// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct CountryMapView: View {
    
    @State private var isSelected = false
    
    private let imageNames: [String] = (1...20).map { "Vector-\($0)" }
    
    private let offsets: [(x: CGFloat, y: CGFloat)] = [
        (25, 28),   // Vector-1 Bacs-Kiskun            - YEAR_11
        (100, -75), // Vector-2 Borsod-Abauj-Zemplen   - YEAR_14
        (142, -69), // Vector-3 Szabolcs-Szatmar-Bereg - YEAR_25
        (119, -31), // Vector-4 Hajdu-Bihar            - YEAR_18
        (59, -52),  // Vector-5 Heves                  - YEAR_19
        (30, -60),  // Vector-6 Nograd                 - YEAR_22
        (12, -28),  // Vector-7 Budapest
        (100, 14),  // Vector-8 Bekes                  - YEAR_13
        (62, 32),   // Vector-9 Csongrad               - YEAR_15
        (-19, -40), // Vector-10 Komarom-Esztergom     - YEAR_21
        (-74, -45), // Vector-11 Gyor-Moson-Sopron     - YEAR_17
        (-94, 16),  // Vector-12 Zala                  - YEAR_29
        (-32, 58),  // Vector-13 Baranya               - YEAR_12
        (-20, 31),  // Vector-14 Tolna                 - YEAR_26
        (25, -29),  // Vector-15 Pest                  - YEAR_23
        (-56, -12), // Vector-16 Veszprem              - YEAR_28
        (-101, -12),// Vector-17 Vas                   - YEAR_27
        (-64, 35),  // Vector-18 Somogy                - YEAR_24
        (69, -18),  // Vector-19 Jasz-Nagykun-Szolnok  - YEAR_20
        (-18, -12)   // Vector-20 Fejer                - YEAR_16
    ]
    
    var body: some View {
        
            ZStack {
                ForEach(imageNames.indices, id: \.self) { index in
                    Image(imageNames[index])
                        .opacity(index == 6 ? 0 : 1) // Budapest
                        .foregroundStyle(index % 2 != 0 ? .red : .colorNavy)
                        .offset(x: offsets[index].x, y: offsets[index].y)
                }
            }
        .frame(width: .width300, height: .height150)
    }
}

#Preview {
    CountryMapView()
}
