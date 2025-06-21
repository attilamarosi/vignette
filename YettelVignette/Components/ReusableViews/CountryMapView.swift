// Copyright © 2025 Attila Marosi. All rights reserved.

import SwiftUI

struct CountryItemView {
    let id: String
    let imageName: String
    let offset: (x: CGFloat, y: CGFloat)
    let name: String
    var isSelected: Bool
}

struct CountryMapView: View {
    
    @Binding var selectedIds: Set<String>
    
    @State private var items: [CountryItemView] = [
        CountryItemView(id: "YEAR_11", imageName: "Vector-1", offset: (0, 28), name: "Bacs-Kiskun", isSelected: false),
        CountryItemView(id: "YEAR_14", imageName: "Vector-2", offset: (75, -75), name: "Borsod-Abauj-Zemplen", isSelected: false),
        CountryItemView(id: "YEAR_25", imageName: "Vector-3", offset: (117, -69), name: "Szabolcs-Szatmar-Bereg", isSelected: false),
        CountryItemView(id: "YEAR_18", imageName: "Vector-4", offset: (94, -31), name: "Hajdu-Bihar", isSelected: false),
        CountryItemView(id: "YEAR_19", imageName: "Vector-5", offset: (34, -52), name: "Heves", isSelected: false),
        CountryItemView(id: "YEAR_22", imageName: "Vector-6", offset: (5, -60), name: "Nograd", isSelected: false),
        CountryItemView(id: "OutOfScope", imageName: "Vector-7", offset: (-13, -28), name: "Budapest", isSelected: false),
        CountryItemView(id: "YEAR_13", imageName: "Vector-8", offset: (75, 14), name: "Bekes", isSelected: false),
        CountryItemView(id: "YEAR_15", imageName: "Vector-9", offset: (36, 32), name: "Csongrad", isSelected: false),
        CountryItemView(id: "YEAR_21", imageName: "Vector-10", offset: (-47, -40), name: "Komarom-Esztergom", isSelected: false),
        CountryItemView(id: "YEAR_17", imageName: "Vector-11", offset: (-101, -45), name: "Gyor-Moson-Sopron", isSelected: false),
        CountryItemView(id: "YEAR_29", imageName: "Vector-12", offset: (-118, 16), name: "Zala", isSelected: false),
        CountryItemView(id: "YEAR_12", imageName: "Vector-13", offset: (-56, 58), name: "Baranya", isSelected: false),
        CountryItemView(id: "YEAR_26", imageName: "Vector-14", offset: (-44, 31), name: "Tolna", isSelected: false),
        CountryItemView(id: "YEAR_23", imageName: "Vector-15", offset: (-1, -36), name: "Pest", isSelected: false),
        CountryItemView(id: "YEAR_28", imageName: "Vector-16", offset: (-81, -12), name: "Veszprem", isSelected: false),
        CountryItemView(id: "YEAR_27", imageName: "Vector-17", offset: (-125, -12), name: "Vas", isSelected: false),
        CountryItemView(id: "YEAR_24", imageName: "Vector-18", offset: (-88, 35), name: "Somogy", isSelected: false),
        CountryItemView(id: "YEAR_20", imageName: "Vector-19", offset: (42, -18), name: "Jasz-Nagykun-Szolnok", isSelected: false),
        CountryItemView(id: "YEAR_16", imageName: "Vector-20", offset: (-43, -12), name: "Fejer", isSelected: false),
    ]

    var body: some View {
        ZStack {
            ForEach($items, id: \.id) { $item in
                Image(item.imageName)
                    .foregroundStyle(selectedIds.contains(item.id) ? .colorLime : .colorNavy)
                    .opacity(item.id == "OutOfScope" ? 0 : 1) // we hide Budapest here
                    .offset(x: item.offset.x, y: item.offset.y)
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            item.isSelected.toggle()
                        }
                    }
            }
        }
        .frame(width: .width300, height: .height150)
    }
}

// MARK: - Previews
#Preview {
    CountryMapView(selectedIds: .constant(["YEAR_22", "YEAR_24"]))
}
