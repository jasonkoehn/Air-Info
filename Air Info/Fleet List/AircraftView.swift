//
//  AircraftView.swift
//  Air Info
//
//  Created by Jason Koehn on 8/21/22.
//



// Needs Rewite

import SwiftUI

struct AircraftView: View {
    var name: String
    var country: String
    var type: String
    var model: String
    var registration: String
    var delivery: String
    var hex: String
    var msn: String
    var ln: String
    var fn: String
    var firstflight: String
    var productionSite: String
    var config: String
    var remarks: String
    @State var productionAirport = ""
    @State var productionCountry = ""
    @State var years: Int = 0
    @State var yearsFraction: Double = 0.0
    @State var isYearFraction: Bool = true
    var body: some View {
        VStack {
            Text(registration)
                .font(.system(size: 60))
                .padding(1)
                .padding(.top, 40)
            Image(name)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(4)
                .frame(height: 60)
                .padding(.bottom, 5)
            HStack {
                Spacer()
                Text(model)
                    .font(.system(size: 26))
                Text("("+type+")")
                    .font(.system(size: 17))
                    .italic()
                Spacer()
            }.padding(.bottom, 5)
            VStack {
                Divider()
                VStack {
                    Spacer()
                    HStack {
                        Text("Hex:")
                            .font(.system(size: 22))
                            .italic()
                        Text(hex)
                            .font(.system(size: 24))
                    }
                    Spacer()
                    HStack {
                        Text("Country Of Reg:")
                            .font(.system(size: 19))
                            .italic()
                        Image(country)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 22)
                    }
                    Spacer()
                }.frame(height: 60)
                Divider()
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        Text("First Flight:")
                            .font(.system(size: 19))
                            .italic()
                        Spacer()
                        Text(firstflight)
                            .font(.system(size: 19))
                        Spacer()
                    }
                    Spacer()
                    VStack {
                        Spacer()
                        Text("Delivery:")
                            .font(.system(size: 19))
                            .italic()
                        Spacer()
                        Text(delivery)
                            .font(.system(size: 19))
                        Spacer()
                    }
                    Spacer()
                }.frame(height: 60)
                Divider()
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        Text("MSN")
                            .font(.system(size: 19))
                            .italic()
                        Spacer()
                        Text(msn)
                            .font(.system(size: 19))
                        Spacer()
                    }
                    if ln != "0" {
                        Spacer()
                        VStack {
                            Spacer()
                            Text("LN")
                                .font(.system(size: 19))
                                .italic()
                            Spacer()
                            Text(ln)
                                .font(.system(size: 19))
                            Spacer()
                        }
                    }
                    if fn != "0" {
                        Spacer()
                        VStack {
                            Spacer()
                            Text("FN")
                                .font(.system(size: 19))
                                .italic()
                            Spacer()
                            Text(fn)
                                .font(.system(size: 19))
                            Spacer()
                        }
                    }
                    Spacer()
                }.frame(height: 60)
            }
            VStack {
                Divider()
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        HStack {
                            Text("Config:")
                                .font(.system(size: 19))
                                .italic()
                            Text(config)
                                .font(.system(size: 19))
                        }
                        Spacer()
                        HStack {
                            Text("Age:")
                                .font(.system(size: 19))
                                .italic()
                            if isYearFraction == false {
                                switch years {
                                case 0:
                                    Text("Brand New")
                                        .font(.system(size: 19))
                                case 1:
                                    HStack(spacing: 2) {
                                        Text("\(years)")
                                            .font(.system(size: 19))
                                        Text("year")
                                            .font(.system(size: 16))
                                            .italic()
                                    }
                                default:
                                    HStack(spacing:2) {
                                        Text("\(years)")
                                            .font(.system(size: 19))
                                        Text("years")
                                            .font(.system(size: 16))
                                            .italic()
                                    }
                                }
                            } else {
                                switch yearsFraction {
                                case 0.0 ... 0.9:
                                    Text("Brand New")
                                        .font(.system(size: 19))
                                case 1.0:
                                    HStack(spacing: 2) {
                                        Text("\(yearsFraction, specifier: "%.1f")")
                                            .font(.system(size: 19))
                                        Text("year")
                                            .font(.system(size: 16))
                                            .italic()
                                    }
                                default:
                                    HStack(spacing: 2) {
                                        Text("\(yearsFraction, specifier: "%.1f")")
                                            .font(.system(size: 19))
                                        Text("years")
                                            .font(.system(size: 16))
                                            .italic()
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Image(productionCountry)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 22)
                        Text(productionAirport+"("+productionSite+")")
                            .font(.system(size: 19))
                    }
                    Spacer()
                }.frame(height: 60)
                Divider()
                if remarks != "" {
                    HStack {
                        Text("Remarks:")
                            .font(.system(size: 19))
                            .italic()
                        Text(remarks)
                            .font(.system(size: 17))
                    }
                }
            }
            Spacer()
        }
        .textSelection(.enabled)
        .task {
            productionList()
            convertToTime()
        }
    }
    func productionList() {
        switch productionSite {
        case "RNT":
            productionAirport = "Renton"
            productionCountry = "United States"
            
        case "BFM":
            productionAirport = "Mobile"
            productionCountry = "United States"
            
        case "SJK":
            productionAirport = "Sao Jose Dos Campos"
            productionCountry = "Brazil"
            
        case "CHS":
            productionAirport = "Charleston"
            productionCountry = "United States"
            
        default:
            productionAirport = ""
            productionCountry = ""
        }
    }
    func convertToTime() {
        let fmt = DateFormatter()
        fmt.locale = Locale(identifier: "en_US_POSIX")
        if firstflight.count == 4 {
            fmt.dateFormat = "yyyy"
            let dt = fmt.date(from: firstflight)!
            let tdt = Date()
            let diffs = Calendar.current.dateComponents([.year], from: dt, to: tdt)
            isYearFraction = false
            years = diffs.year!
        } else if firstflight.count == 8 {
            fmt.dateFormat = "MMM yyyy"
            let dt = fmt.date(from: firstflight)!
            let tdt = Date()
            let diffs = Calendar.current.dateComponents([.year, .month], from: dt, to: tdt)
            yearsFraction = Double(diffs.year!) + (Double(diffs.month!) / 12)
        } else {
            fmt.dateFormat = "MMM d, yyyy"
            let dt = fmt.date(from: firstflight)!
            let tdt = Date()
            let diffs = Calendar.current.dateComponents([.year, .month], from: dt, to: tdt)
            yearsFraction = Double(diffs.year!) + (Double(diffs.month!) / 12)
        }
    }
}
