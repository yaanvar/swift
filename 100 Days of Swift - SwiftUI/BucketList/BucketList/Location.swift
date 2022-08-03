//
//  Location.swift
//  BucketList
//
//  Created by Anvar Rahimov on 03.08.2022.
//

import Foundation
import CoreLocation

struct Location: Identifiable, Decodable, Equatable {
    var id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longtitude: Double
}

extension Location {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
    }
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
    static let example = Location(id: UUID(), name: "Buckingham Palace", description: "Where Queen Elizabeth lives with her dorgis.", latitude: 51.501, longtitude: -0.141)
}
