//
//  AirlineView.swift
//  Air Info
//
//  Created by Jason Koehn on 8/21/22.
//

import SwiftUI

struct AirlineView: View {
    var name: String
    var country: String
    var website: String
    var iata: String
    var icao: String
    var callsign: String
    var fleetsize: String
    var types: [Types] = []
    var body: some View {
        VStack {
            Text(name)
                .font(.system(size: 38))
                .italic()
                .bold()
                .padding(1)
                .padding(.top, 20)
            Image(name)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 80)
                .padding(.horizontal, 10)
                .padding(.vertical, 1)
            HStack {
                Spacer()
                Text("IATA")
                    .italic()
                    .font(.subheadline)
                Text(iata)
                Spacer()
                Text("ICOA")
                    .italic()
                    .font(.subheadline)
                Text(icao)
                Spacer()
                Text("Callsign")
                    .italic()
                    .font(.subheadline)
                Text(callsign)
                Spacer()
            }
            InfoRow(website: website, fleetsize: fleetsize, country: country)
            List {
                NavigationLink(destination: AllFleetView(name: name, types: types)) {
                    Text("All Aircraft")
                        .font(.system(size: 20))
                        .bold()
                        .italic()
                }
                ForEach(types, id: \.type) { types in
                    NavigationLink(destination: TypeFleetView(name: name, type: types.type, model: types.model)) {
                        Text(types.model)
                            .font(.system(size: 17))
                            .italic()
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .textSelection(.enabled)
        .navigationBarTitle("", displayMode: .inline)
    }
    struct InfoRow: View {
        var website: String
        var fleetsize: String
        var country: String
        var body: some View {
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Text("Website")
                        .italic()
                        .font(.headline)
                    Spacer()
                    Link(website, destination: URL(string: "https://www." + website)!)
                        .font(.system(size: 20))
                    Spacer()
                }
                Spacer()
                VStack {
                    Spacer()
                    Text("Fleet Size")
                        .italic()
                        .font(.headline)
                    Spacer()
                    Text(fleetsize)
                        .font(.system(size: 20))
                    Spacer()
                }
                Spacer()
                VStack {
                    Spacer()
                    Text("Country")
                        .italic()
                        .font(.headline)
                    Spacer()
                    Image(country)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50)
                    Spacer()
                }
                Spacer()
            }.frame(height: 70)
        }
    }
}
