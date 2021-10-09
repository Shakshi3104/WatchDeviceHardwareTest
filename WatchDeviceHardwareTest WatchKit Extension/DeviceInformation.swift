//
//  DeviceInformation.swift
//  WatchDeviceHardwareTest WatchKit Extension
//
//  Created by MacBook Pro on 2021/10/09.
//

import Foundation
import WatchKit

class DeviceInfo {
    public static let shared = DeviceInfo()
    
    /// - Tag:  system information
    let device: String
    let os: String
    let processor: String
    let cpu: String
    let gpu: String
    
    let cpuCount: Int
    let ram: Int
    let ramString: String
    
    let modelIdentifier: String
    
    init() {
        device = WatchDeviceHardware.deviceHardware.modelName
        os = WKInterfaceDevice.current().systemName + " " + WKInterfaceDevice.current().systemVersion
        processor = WatchDeviceHardware.deviceHardware.processorName
        cpu = WatchDeviceHardware.deviceHardware.cpu
        gpu = WatchDeviceHardware.deviceHardware.gpu
        
        cpuCount = WatchDeviceHardware.deviceHardware.processorCount
        ram = WatchDeviceHardware.deviceHardware.ram
        ramString = WatchDeviceHardware.deviceHardware.ramString
        modelIdentifier = WatchDeviceHardware.deviceHardware.modelIdentifier
    }
}
