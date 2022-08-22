//
//  2.swift
//  Air Info
//
//  Created by Jason Koehn on 8/20/22.
//

import Foundation

// Data Arrays
var airliness: [Airline] = []
var aircraft: [Aircraft] = []
var countries: [String] = []
var letterss: [String] = []


func loadFleetData() {
    // Get Urls
    let manager = FileManager.default
    guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
    let airlinesUrl = url.appendingPathComponent("airlines.plist")
    let aircraftUrl = url.appendingPathComponent("aircraft.plist")
    let countriesUrl = url.appendingPathComponent("countries.plist")
    let lettersUrl = url.appendingPathComponent("letters.plist")
    let decoder = PropertyListDecoder()
    
    // Get and decode data
    /// Airlines
    if let data = try? Data(contentsOf: airlinesUrl) {
        if let response = try? decoder.decode([Airline].self, from: data) {
            airliness = response
            airliness.sort { $0.name < $1.name }
        } else {
            Task {
                await importFleetData()
                loadFleetData()
            }
        }
    } else {
        Task {
            await importFleetData()
            loadFleetData()
        }
    }
    /// Aircraft
    if let data = try? Data(contentsOf: aircraftUrl) {
        if let response = try? decoder.decode([Aircraft].self, from: data) {
            aircraft = response
            aircraft.sort { $0.registration < $1.registration }
        } else {
            Task {
                await importFleetData()
                loadFleetData()
            }
        }
    } else {
        Task {
            await importFleetData()
            loadFleetData()
        }
    }
    /// Countries
    if let data = try? Data(contentsOf: countriesUrl) {
        if let response = try? decoder.decode([String].self, from: data) {
            countries = response
        } else {
            Task {
                await importFleetData()
                loadFleetData()
            }
        }
    } else {
        Task {
            await importFleetData()
            loadFleetData()
        }
    }
    /// Letters
    if let data = try? Data(contentsOf: lettersUrl) {
        if let response = try? decoder.decode([String].self, from: data) {
            letterss = response
        } else {
            Task {
                await importFleetData()
                loadFleetData()
            }
        }
    } else {
        Task {
            await importFleetData()
            loadFleetData()
        }
    }
}
