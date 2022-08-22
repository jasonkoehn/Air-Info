//
//  AirlineListView.swift
//  Air Info
//
//  Created by Jason Koehn on 8/21/22.
//

import SwiftUI

struct AirlineListView: View {
    @State var airlines: [Airline] = []
    @State var letters: [String] = []
    @State private var searchText = ""
    @State private var searching = false
    var body: some View {
        List {
            if searchText.isEmpty {
                ForEach(letters, id: \.self) { letter in
                    Section(letter) {
                        ForEach(airlines, id: \.name) { airline in
                            if airline.name.first?.uppercased() == letter {
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
                }
            } else {
                ForEach(searchResults, id: \.name) { airline in
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
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .task {
            loadAirlinesLetters()
        }
        .refreshable {
            await importFleetData()
            loadAirlinesLetters()
        }
    }
    var searchResults: [Airline] {
        return airlines.filter { $0.name.contains(searchText) }
    }
    func loadAirlinesLetters() {
        let manager = FileManager.default
        let decoder = PropertyListDecoder()
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let airlinesUrl = url.appendingPathComponent("airlines.plist")
        let lettersUrl = url.appendingPathComponent("letters.plist")
        // Get and decode Airlines
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
        // Get and decode Letters
        if let data = try? Data(contentsOf: lettersUrl) {
            if let response = try? decoder.decode([String].self, from: data) {
                letters = response
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
