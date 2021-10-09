//
//  DeviceInfoView.swift
//  WatchDeviceHardwareTest WatchKit Extension
//
//  Created by MacBook Pro on 2021/10/09.
//

import SwiftUI

struct DeviceInfoView: View {
    private let deviceInfo = DeviceInfo.shared
    var body: some View {
        NavigationView {
            List {
                Section {
                    ListRow(key: "Device", value: deviceInfo.device)
                    ListRow(key: "Model Identifier", value: deviceInfo.modelIdentifier)
                    ListRow(key: "OS", value: deviceInfo.os)
                    ListRow(key: "CPU", value: deviceInfo.cpu)
                    ListRow(key: "GPU", value: deviceInfo.gpu)
                    ListRow(key: "RAM", value: deviceInfo.ramString)
                }
            }
            // like workout app list style
            .listStyle(EllipticalListStyle())
        }
        .navigationTitle(deviceInfo.device)
        .onAppear(perform: {
            // print "hw.machine" and "hw.model"
            let deviceHardware = WatchDeviceHardware.deviceHardware
            print(deviceHardware.getHwMachine() ?? "nil")
            print(deviceHardware.getHwModel() ?? "nil")
        })
    }
}

struct ListRow: View {
    var key: String
    var value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(key)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
        }
    }
}

struct DeviceHardwareView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceInfoView()
    }
}
