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
            NavigationView {
                FleetListView()
            }
            .tabItem {
                Image(systemName: "airplane")
                Text("Airlines")
            }
            Text("Home")
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            Text("Settings")
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .accentColor(Color(.systemBlue))
    }
}
