//
//  TabsView.swift
//  Air Info
//
//  Created by Jason Koehn on 8/21/22.
//

import SwiftUI

struct TabsView: View {
    @State private var selectedTabIndex = 0
    var body: some View {
        TabView {
            Text("Home")
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            VStack {
                SlidingTabView(selection: $selectedTabIndex, tabs: ["Airlines", "By Country"], activeAccentColor: .green, inactiveAccentColor: .gray, selectionBarColor: .green)
                    .background(Color(.systemGray5))
                switch selectedTabIndex {
                case 0:
                    NavigationView {
                        AirlineListView()
                            .onSwiped(.left) {
                                        selectedTabIndex = 1
                                    }
                    }
                case 1:
                    NavigationView {
                        CountriesListView()
                            .onSwiped(.right) {
                                        selectedTabIndex = 0
                                    }
                    }
                default:
                    Text("")
                }
                Spacer()
            }
            .tabItem {
                Image(systemName: "airplane")
                Text("Airlines")
            }
            Text("Airport Codes")
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
                    Text("Airport Codes")
                }
            Text("Facts")
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Facts")
                }
            Text("Settings")
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}

