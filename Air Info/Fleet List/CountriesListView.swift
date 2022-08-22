//
//  CountriesListView.swift
//  Air Info
//
//  Created by Jason Koehn on 8/22/22.
//

import SwiftUI

struct CountriesListView: View {
    @State var countries: [String] = []
    @State private var searchText = ""
    var body: some View {
        List {
            ForEach(searchResults, id: \.self) { country in
                NavigationLink(destination: AirlinesByCountryView(country: country)) {
                    HStack {
                        Image(country)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40)
                        Text(country)
                            .font(.system(size: 20))
                    }
                }
            }
        }
        .searchable(text: $searchText)
        .listStyle(PlainListStyle())
        .navigationBarTitle("Countries")
        .task {
            loadCountries()
        }
        .refreshable {
            await importFleetData()
            loadCountries()
        }
    }
    var searchResults: [String] {
        if searchText.isEmpty {
            return countries
        } else {
            return countries.filter { $0.contains(searchText) }
        }
    }
    func loadCountries() {
        let manager = FileManager.default
        let decoder = PropertyListDecoder()
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let countriesUrl = url.appendingPathComponent("countries.plist")
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
    }
}

