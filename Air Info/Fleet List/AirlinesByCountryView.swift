//
//  AirlinesByCountryView.swift
//  Air Info
//
//  Created by Jason Koehn on 8/22/22.
//

import SwiftUI

struct AirlinesByCountryView: View {
    var country: String
    @State var airlines: [Airline] = []
    @State private var searchText = ""
    var body: some View {
        List {
            ForEach(searchResults, id: \.name) { airline in
                if airline.country == country {
                    NavigationLink(destination: AirlineView()) {
                        HStack {
                            Image(airline.name)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50)
                            Text(airline.name)
                                .font(.system(size: 23))
                        }
                    }
                }
            }
        }
        .searchable(text: $searchText)
        .listStyle(PlainListStyle())
        .task {
            loadAirlines()
        }
        .refreshable {
            Task {
                await importFleetData()
                loadAirlines()
            }
        }
    }
    var searchResults: [Airline] {
        if searchText.isEmpty {
            return airlines
        } else {
            return airlines.filter { $0.name.contains(searchText) }
        }
    }
    func loadAirlines() {
        let manager = FileManager.default
        let decoder = PropertyListDecoder()
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let airlinesUrl = url.appendingPathComponent("airlines.plist")
        if let data = try? Data(contentsOf: airlinesUrl) {
            if let response = try? decoder.decode([Airline].self, from: data) {
                airlines = response
                airlines.sort { $0.name < $1.name }
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
}
