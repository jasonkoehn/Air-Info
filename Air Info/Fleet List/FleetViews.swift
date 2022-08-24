//
//  FleetView.swift
//  Air Info
//
//  Created by Jason Koehn on 8/23/22.
//

import SwiftUI

struct AllFleetView: View {
    @State var aircraft: [Aircraft] = []
    var name: String
    var types: [Types] = []
    @State private var searchText = ""
    var body: some View {
        List {
            ForEach(types, id: \.type) { types in
                Section(types.model) {
                    ForEach(searchResults, id: \.hex) { aircraft in
                        if aircraft.airline == name && aircraft.type == types.type {
                            FleetRow(name: name, country: aircraft.country, type: aircraft.type, model: aircraft.model, registration: aircraft.registration, delivery: aircraft.delivery, hex: aircraft.hex, msn: aircraft.msn, ln: aircraft.ln, fn: aircraft.fn, firstflight: aircraft.firstflight, productionSite: aircraft.site, config: aircraft.config, remarks: aircraft.remarks)
                                
                        }
                    }
                }
            }
        }
        .searchable(text: $searchText)
        .listStyle(PlainListStyle())
        .navigationBarTitle("Aircraft", displayMode: .inline)
        .task {
            loadAircraft()
        }
        .refreshable {
            Task {
                await importFleetData()
                loadAircraft()
            }
        }
    }
    var searchResults: [Aircraft] {
        if searchText.isEmpty {
            return aircraft
        } else {
            return aircraft.filter { $0.registration.contains(searchText) }
        }
    }
    func loadAircraft() {
        let manager = FileManager.default
        let decoder = PropertyListDecoder()
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let aircraftUrl = url.appendingPathComponent("aircraft.plist")
        if let data = try? Data(contentsOf: aircraftUrl) {
            if let response = try? decoder.decode([Aircraft].self, from: data) {
                aircraft = response
                aircraft.sort { $0.registration < $1.registration }
            } else {
                Task {
                    await importFleetData()
                    loadAircraft()
                }
            }
        } else {
            Task {
                await importFleetData()
                loadAircraft()
            }
        }
    }
    struct FleetRow: View {
        var name: String
        var country: String
        var type: String
        var model: String
        var registration: String
        var delivery: String
        var hex: String
        var msn: String
        var ln: String
        var fn: String
        var firstflight: String
        var productionSite: String
        var config: String
        var remarks: String
        var body: some View {
            NavigationLink(destination: AircraftView(name: name, country: country, type: type, model: model, registration: registration, delivery: delivery, hex: hex, msn: msn, ln: ln, fn: fn, firstflight: firstflight, productionSite: productionSite, config: config, remarks: remarks)) {
                HStack {
                    Image(name)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50)
                    HStack {
                        Text(registration)
                            .font(.system(size: 23))
                        Spacer()
                    }.frame(width: 120)
                    Text(type)
                        .font(.system(size: 15))
                }
            }
        }
    }
}

struct TypeFleetView: View {
    @State var aircraft: [Aircraft] = []
    var name: String
    var type: String
    var model: String
    @State private var searchText = ""
    var body: some View {
        List {
            ForEach(searchResults, id: \.hex) { aircraft in
                if aircraft.airline == name && aircraft.type == type {
                    NavigationLink(destination: AircraftView(name: name, country: aircraft.country, type: aircraft.type, model: aircraft.model, registration: aircraft.registration, delivery: aircraft.delivery, hex: aircraft.hex, msn: aircraft.msn, ln: aircraft.ln, fn: aircraft.fn, firstflight: aircraft.firstflight, productionSite: aircraft.site, config: aircraft.config, remarks: aircraft.remarks)) {
                        HStack {
                            Image(name)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50)
                            HStack {
                                Text(aircraft.registration)
                                    .font(.system(size: 23))
                                Spacer()
                            }.frame(width: 120)
                            Text(aircraft.type)
                                .font(.system(size: 15))
                        }
                    }
                }
            }
        }
        .searchable(text: $searchText)
        .listStyle(PlainListStyle())
        .navigationBarTitle(model, displayMode: .inline)
        .task {
            loadAircraft()
        }
        .refreshable {
            Task {
                await importFleetData()
                loadAircraft()
            }
        }
    }
    var searchResults: [Aircraft] {
        if searchText.isEmpty {
            return aircraft
        } else {
            return aircraft.filter { $0.registration.contains(searchText) }
        }
    }
    func loadAircraft() {
        let manager = FileManager.default
        let decoder = PropertyListDecoder()
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let aircraftUrl = url.appendingPathComponent("aircraft.plist")
        if let data = try? Data(contentsOf: aircraftUrl) {
            if let response = try? decoder.decode([Aircraft].self, from: data) {
                aircraft = response
                aircraft.sort { $0.registration < $1.registration }
            } else {
                Task {
                    await importFleetData()
                    loadAircraft()
                }
            }
        } else {
            Task {
                await importFleetData()
                loadAircraft()
            }
        }
    }
}
