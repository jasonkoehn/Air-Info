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
                                .font(.system(size: 25))
                                .frame(width: 150, height: 40)
                                .background(Color.green)
                                .cornerRadius(30)
                                .foregroundColor(.black)
                                .bold()
                        }
                        .padding(20)
                    } else if viewState == 1 {
                        Button(action: {
                            viewState = 0
                        }) {
                            Text("Airlines")
                                .font(.system(size: 25))
                                .frame(width: 100, height: 40)
                                .background(Color.green)
                                .cornerRadius(30)
                                .foregroundColor(.black)
                                .bold()
                        }
                        .padding(20)
                    }
                }
            }
        }
    }
}

