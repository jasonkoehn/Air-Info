//
//  File.swift
//  Air Info
//
//  Created by Jason Koehn on 8/20/22.
//

import Foundation

// Structs for API decode
struct AirlineAPI: Codable {
    var name: String
    var country: String
    var website: String
    var iata: String
    var icao: String
    var callsign: String
    var fleetsize: String
    var types: String
    var summary: String
}
struct AircraftAPI: Codable {
    var airline: String
    var type: String
    var registration: String
    var country: String
    var firstflight: String
    var delivery: String
    var hex: String
    var config: String
    var msn: String
    var ln: String
    var fn: String
    var site: String
    var remarks: String
}

// Structs for local encode and decode
struct Airline: Codable {
    var name: String
    var country: String
    var website: String
    var iata: String
    var icao: String
    var callsign: String
    var summary: String
    var fleetsize: String
    var types: [Types]
}
struct Types: Codable {
    var type: String
    var model: String
}
struct Aircraft: Codable {
    var airline: String
    var type: String
    var model: String
    var registration: String
    var country: String
    var firstflight: String
    var delivery: String
    var hex: String
    var config: String
    var msn: String
    var ln: String
    var fn: String
    var site: String
    var remarks: String
}
