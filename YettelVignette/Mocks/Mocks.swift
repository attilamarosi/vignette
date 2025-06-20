// Copyright © 2025 Attila Marosi. All rights reserved.

import Foundation

struct Mocks {
    
    static var vehicle: Vehicle {
        Vehicle(country: Country(hu: "Magyarország",
                                 en: "Hungary"),
                name: "Michael Scott",
                plateNumber: "ABC-123",
                registrationCode: "H",
                type: .car,
                vignetteType: "D1")
    }
}
