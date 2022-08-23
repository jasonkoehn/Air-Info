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
                            Text("By Country")
                                .font(.system(size: 27))
                                .padding(10)
                                .background(Color(.systemGray5))
                                .cornerRadius(20)
                                .foregroundColor(.red)
                                .bold()
                        }
                    } else if viewState == 1 {
                        Button(action: {
                            viewState = 0
                        }) {
                            Text("Airlines")
                                .font(.system(size: 27))
                                .padding(10)
                                .background(Color(.systemGray5))
                                .cornerRadius(20)
                                .foregroundColor(.red)
                                .bold()
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.vertical, 40)
        }
    }
}

