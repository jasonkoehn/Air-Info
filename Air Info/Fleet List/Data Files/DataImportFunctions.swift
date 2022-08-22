//
//  1.swift
//  Air Info
//
//  Created by Jason Koehn on 8/20/22.
//

import Foundation

func importFleetData() async {
    // Importing URLs
    guard let Airlinesurl = URL(string: "https://jasonkoehn.github.io/FleetList/Airlines.json") else {
        print("Invalid URL")
        return
    }
    guard let Aircrafturl = URL(string: "https://jasonkoehn.github.io/FleetList/Aircraft.json") else {
        print("Invalid URL")
        return
    }
    let manager = FileManager.default
    guard let managerUrl = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
    let encoder = PropertyListEncoder()
    let airlineUrl = managerUrl.appendingPathComponent("airlines.plist")
    let aircraftUrl = managerUrl.appendingPathComponent("aircraft.plist")
    let countriesUrl = managerUrl.appendingPathComponent("countries.plist")
    let lettersUrl = managerUrl.appendingPathComponent("letters.plist")
    
    // Decoding Airline List
    do {
        let (data, _) = try await URLSession.shared.data(from: Airlinesurl)
        if let decodedResponse = try? JSONDecoder().decode([AirlineAPI].self, from: data) {
            var airlines: [Airline] = []
            var countries: [String] = []
            var letters: [String] = []
            for airline in decodedResponse {
                let types = airline.types.components(separatedBy: ",")
                var airlineTypes: [Types] = []
                for type in types {
                    let model = switchAircraftTypes(type: type)
                    airlineTypes.append(Types(type: type, model: model))
                }
                airlines.append(Airline(name: airline.name, country: airline.country, website: airline.website, iata: airline.iata, icao: airline.icao, callsign: airline.callsign, summary: airline.summary, fleetsize: airline.fleetsize, types: airlineTypes))
                countries.append(airline.country)
                letters.append(airline.name.first!.uppercased())
            }
            
            // Sorting Countries & Letters
            var sortedCountries = Array(Set(countries))
            sortedCountries.sort {
                $0.self < $1.self
            }
            var sortedLetters = Array(Set(letters))
            sortedLetters.sort {
                $0.self < $1.self
            }
            
            // Saving to FileManager
            manager.createFile(atPath: airlineUrl.path, contents: nil, attributes: nil)
            let encodedData = try! encoder.encode(airlines)
            try! encodedData.write(to: airlineUrl)
            
            manager.createFile(atPath: countriesUrl.path, contents: nil, attributes: nil)
            let encodedCountries = try! encoder.encode(sortedCountries)
            try! encodedCountries.write(to: countriesUrl)
            
            manager.createFile(atPath: lettersUrl.path, contents: nil, attributes: nil)
            let encodedLetters = try! encoder.encode(sortedLetters)
            try! encodedLetters.write(to: lettersUrl)
        }
    } catch {
        print("Invalid data")
        
    }
    
    // Decoding Aircraft List
    do {
        let (data, _) = try await URLSession.shared.data(from: Aircrafturl)
        if let decodedResponse = try? JSONDecoder().decode([AircraftAPI].self, from: data) {
            var aircrafts: [Aircraft] = []
            for aircraft in decodedResponse {
                let model = switchAircraftTypes(type: aircraft.type)
                aircrafts.append(Aircraft(airline: aircraft.airline, type: aircraft.type, model: model, registration: aircraft.registration, country: aircraft.country, firstflight: aircraft.firstflight, delivery: aircraft.delivery, hex: aircraft.hex, config: aircraft.config, msn: aircraft.msn, ln: aircraft.msn, fn: aircraft.fn, site: aircraft.site, remarks: aircraft.remarks))
            }
            // Saving to FileManager
            manager.createFile(atPath: aircraftUrl.path, contents: nil, attributes: nil)
            let encodedData = try! encoder.encode(aircrafts)
            try! encodedData.write(to: aircraftUrl)
        }
    } catch {
        print("Invalid data")
        
    }
}

// Adding the model to the arrays
func switchAircraftTypes(type: String) -> String {
    var model = ""
    switch type {
    case "A20N":
        model = "Airbus A320neo"
    case "A21N":
        model = "Airbus A321neo"
    case "A318":
        model = "Airbus A318"
    case "A319":
        model = "Airbus A319"
    case "A320":
        model = "Airbus A320"
    case "A332":
        model = "Airbus A330-200"
    case "A333":
        model = "Airbus A330-300"
    case "A338":
        model = "Airbus A330-800"
    case "A339":
        model = "Airbus A330-900"
    case "A343":
        model = "Airbus A340-300"
    case "A346":
        model = "Airbus A340-600"
    case "A359":
        model = "Airbus A350-900"
    case "A35K":
        model = "Airbus A350-1000"
    case "A388":
        model = "Airbus A380-800"
    case "B736":
        model = "Boeing 737-600"
    case "B737":
        model = "Boeing 737-700"
    case "B738":
        model = "Boeing 737-800"
    case "B739":
        model = "Boeing 737-900"
    case "B37M":
        model = "Boeing 737 MAX 8"
    case "B38M":
        model = "Boeing 737 MAX 8"
    case "B39M":
        model = "Boeing 737 MAX 9"
    case "B744":
        model = "Boeing 747-400"
    case "B748":
        model = "Boeing 747-8"
    case "B752":
        model = "Boeing 757-200"
    case "B753":
        model = "Boeing 757-300"
    case "B762":
        model = "Boeing 767-200"
    case "B763":
        model = "Boeing 767-300"
    case "B764":
        model = "Boeing 767-400"
    case "B772":
        model = "Boeing 777-200"
    case "B773":
        model = "Boeing 777-300"
    case "B77L":
        model = "Boeing 777-200LR"
    case "B77W":
        model = "Boeing 777-300ER"
    case "B788":
        model = "Boeing 787-8 Dreamliner"
    case "B789":
        model = "Boeing 787-9 Dreamliner"
    case "B78X":
        model = "Boeing 787-10 Dreamliner"
    case "BCS1":
        model = "Airbus A220-100"
    case "BCS3":
        model = "Airbus A220-300"
    case "CRJ2":
        model = "Bombardier CRJ-200"
    case "CRJ7":
        model = "Bombardier CRJ-700"
    case "CRJ9":
        model = "Bombardier CRJ-900"
    case "E135":
        model = "Embraer ERJ135"
    case "E145":
        model = "Embraer ERJ145"
    case "E170":
        model = "Embraer E170"
    case "E175":
        model = "Embraer E175"
    case "E190":
        model = "Embraer E190"
    case "E195":
        model = "Embraer E195"
    case "E275":
        model = "Embraer E175-E2"
    case "E290":
        model = "Embraer E190-E2"
    case "E295":
        model = "Embraer E195-E2"
    default:
        model = ""
    }
    return model
}
