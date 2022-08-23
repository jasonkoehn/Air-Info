//
//  TogetherView.swift
//  Air Info
//
//  Created by Jason Koehn on 8/22/22.
//

import SwiftUI

struct TogetherView: View {
    @State var viewState = 0
    var body: some View {
        ZStack {
            if viewState == 0 {
                AirlineListView()
            } else if viewState == 1 {
                CountriesListView()
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    if viewState == 0 {
                        Button(action: {
                            viewState = 1
                        }) {
                            ButtonView(text: "By Country", image: "flag.fill")
                        }
                    } else if viewState == 1 {
                        Button(action: {
                            viewState = 0
                        }) {
                            ButtonView(text: "Airlines", image: "airplane")
                        }
                    }
                }
                .padding(.horizontal, 15)
            }
            .padding(.vertical, 25)
        }
    }
}

struct ButtonView: View {
    var text: String
    var image: String
    var body: some View {
        HStack {
            Image(systemName: image)
                .font(.system(size: 25))
                .foregroundColor(Color(.systemBlue))
            Text(text)
                .font(.system(size: 25))
                .foregroundColor(Color(.systemBlue))
        }
        .padding(8)
        .background(Color(.systemGray5))
        .cornerRadius(15)
    }
}
