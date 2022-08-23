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
                TogetherView()
            }
            .tabItem {
                Image(systemName: "airplane")
                Text("Airlines")
            }
        }
        .accentColor(Color(.systemBlue))
    }
}
