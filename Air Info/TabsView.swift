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
                if selectedTabIndex == 0 {
                    AirlineListView()
                        .navigationBarItems(trailing: Button(action: {selectedTabIndex = 1}){Text("By Country")})
                } else if selectedTabIndex == 1 {
                    CountriesListView()
                        .navigationBarItems(trailing: Button(action: {selectedTabIndex = 0}){Text("Airlines")})
                }
            }
            .tabItem {
                Image(systemName: "airplane")
                Text("Airlines")
            }
        }
    }
}
