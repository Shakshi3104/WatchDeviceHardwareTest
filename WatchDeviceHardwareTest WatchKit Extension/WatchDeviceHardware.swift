//
//  WatchDeviceHardware.swift
//  WatchDeviceHardwareTest WatchKit Extension
//
//  Created by MacBook Pro on 2021/10/09.
//

import Foundation

class WatchDeviceHardware {
    public static let deviceHardware = WatchDeviceHardware()
    
    /// model name, such as Apple Watch Series 5
    public var modelName: String {
        let modelName_ = getModelName() ?? "Unknown"
        return modelName_
    }
    /// processor name, such as Apple S5
    public var processorName: String {
        let processorName_ = getProcessorName() ?? "Unknown"
        return processorName_
    }
    /// CPU information, such as 2-core
    public var cpu: String {
        let cpu_ = getCpu() ?? "Unknown"
        return cpu_
    }
    /// GPU Information
    public var gpu: String {
        let gpu_ = getGpu() ?? "Unknown"
        return gpu_
    }
    /// Neural Engine
    public var neuralEngine: String = "None"
    
    /// Model Identifier, such as Watch4,4
    public var modelIdentifier: String {
        let modelId = getModelIdentifier() ?? "Unknown"
        return modelId
    }
    /// number of processor
    public var processorCount: Int {
        return ProcessInfo.processInfo.processorCount
    }
    /// physical memory size [B]
    public var ram: Int {
        return getRAM()
    }
    /// physical memory size, such as 2GB
    public var ramString: String {
        return getRAMString()
    }
    
    // MARK: -
    func getModelIdentifier() -> String? {
        var size: Int = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: Int(size))
        if sysctlbyname("hw.machine", &machine, &size, nil, 0) != 0 {
            return nil
        }
        let code: String = String(cString:machine)
        
        return code
    }
    
    private func getModelName() -> String? {
        guard let id = getModelIdentifier() else {
            return nil
        }
        
        guard let modelId = ModelIdentifier(rawValue: id) else {
            return nil
        }
        
        return modelId.modelName()
    }
    
    private func getProcessorName() -> String? {
        guard let id = getModelIdentifier() else {
            return nil
        }
        
        guard let modelId = ModelIdentifier(rawValue: id) else {
            return nil
        }
        
        return modelId.processorName()
    }
    
    private func getCpu() -> String? {
        return "\(ProcessInfo.processInfo.processorCount)-core"
    }
    
    private func getGpu() -> String? {
        guard let id = getModelIdentifier() else {
            return nil
        }
        
        guard let modelId = ModelIdentifier(rawValue: id) else {
            return nil
        }
        
        return modelId.gpu()
    }
    
    // MARK: -
    enum ModelIdentifier: String {
        // MARK: Simulator
        case i386
        case x86_64
        case arm64
        // MARK: Apple Watch
        /// Apple Watch 38mm
        case Watch1_1 = "Watch1,1"
        /// Apple Watch 42mm
        case Watch1_2 = "Watch1,2"
        /// Apple Watch Series 2 38mm
        case Watch2_3 = "Watch2,3"
        /// Apple Watch Series 2 42mm
        case Watch2_4 = "Watch2,4"
        /// Apple Watch Series 1 38mm
        case Watch2_6 = "Wacth2,6"
        /// Apple Watch Series 1 42mm
        case Watch2_7 = "Watch2,7"
        /// Apple Watch Series 3 38mm (GPS+Cellular)
        case Watch3_1 = "Watch3,1"
        /// Apple Watch Series 3 42mm (GPS+Cellular)
        case Watch3_2 = "Watch3,2"
        /// Apple Watch Series 3 38mm (GPS)
        case Watch3_3 = "Watch3,3"
        /// Apple Watch Series 4 42mm (GPS)
        case Watch3_4 = "Watch3,4"
        /// Apple Watch Series 4 40mm (GPS)
        case Watch4_1 = "Watch4,1"
        /// Apple Watch Series 4 44mm (GPS)
        case Watch4_2 = "Watch4,2"
        /// Apple Watch Series 4 40mm (GPS+Cellular)
        case Watch4_3 = "Watch4,3"
        /// Apple Watch Series 4 44mm (GPS+Cellular)
        case Watch4_4 = "Watch4,4"
        /// Apple Watch Series 5 40mm (GPS)
        case Watch5_1 = "Watch5,1"
        /// Apple Watch Series 5 44mm (GPS)
        case Watch5_2 = "Watch5,2"
        /// Apple Watch Series 5 40mm (GPS+Cellular)
        case Watch5_3 = "Watch5,3"
        /// Apple Watch Series 5 44mm (GPS+Cellular)
        case Watch5_4 = "Watch5,4"
        /// Apple Watch Series 6 40mm (GPS)
        case Watch6_1 = "Watch6,1"
        /// Apple Watch Series 6 44mm (GPS)
        case Watch6_2 = "Watch6,2"
        /// Apple Watch Series 6 40mm (GPS+Cellular)
        case Watch6_3 = "Watch6,3"
        /// Apple Watch Series 6 44mm (GPS+Cellular)
        case Watch6_4 = "Watch6,4"
        /// Apple Watch SE 40mm (GPS)
        case Watch5_9 = "Watch5,9"
        /// Apple Watch SE 44mm (GPS)
        case Watch5_10 = "Watch5,10"
        /// Apple Watch SE 40mm (GPS+Cellular)
        case Watch5_11 = "Watch5,11"
        /// Apple Watch SE 44mm (GPS+Cellular)
        case Watch5_12 = "Watch5,12"
        /// Apple Watch Series 7 41mm (GPS)
        case Watch6_6 = "Watch6,6"
        /// Apple Watch Series 7 45mm (GPS)
        case Watch6_7 = "Watch6,7"
        /// Apple Watch Series 7 41mm (GPS+Cellular)
        case Watch6_8 = "Watch6,8"
        /// Apple Watch Series 7 45mm (GPS+Cellular)
        case Watch6_9 = "Watch6,9"
        
        // model name
        func modelName() -> String {
            switch self {
            case .i386, .x86_64, .arm64:
                return "Simulator"
            case .Watch1_1, .Watch1_2:
                return "Apple Watch (1st generation)"
            case .Watch2_6, .Watch2_7:
                return "Apple Watch Series 1"
            case .Watch2_3, .Watch2_4:
                return "Apple Watch Series 2"
            case .Watch3_1, .Watch3_2, .Watch3_3, .Watch3_4:
                return "Apple Watch Series 3"
            case .Watch4_1, .Watch4_2, .Watch4_3, .Watch4_4:
                return "Apple Watch Series 4"
            case .Watch5_1, .Watch5_2, .Watch5_3, .Watch5_4:
                return "Apple Watch Series 5"
            case .Watch6_1, .Watch6_2, .Watch6_3, .Watch6_4:
                return "Apple Watch Series 6"
            case .Watch5_9, .Watch5_10, .Watch5_11, .Watch5_12:
                return "Apple Watch SE"
            case .Watch6_6, .Watch6_7, .Watch6_8, .Watch6_9:
                return "Apple Watch Series 7"
            }
        }
        
        // Processor (SoC) Name
        func processorName() -> String {
            switch self {
            case .i386, .x86_64, .arm64:
                return "N/A"
            case .Watch1_1, .Watch1_2:
                return "Apple S1"
            case .Watch2_6, .Watch2_7:
                return "Apple S1P"
            case .Watch2_3, .Watch2_4:
                return "Apple S2"
            case .Watch3_1, .Watch3_2, .Watch3_3, .Watch3_4:
                return "Apple S3"
            case .Watch4_1, .Watch4_2, .Watch4_3, .Watch4_4:
                return "Apple S4"
            case .Watch5_1, .Watch5_2, .Watch5_3, .Watch5_4, .Watch5_9, .Watch5_10, .Watch5_11, .Watch5_12:
                return "Apple S5"
            case .Watch6_1, .Watch6_2, .Watch6_3, .Watch6_4:
                return "Apple S6"
            case .Watch6_6, .Watch6_7, .Watch6_8, .Watch6_9:
                return "Apple S7"
            }
        }
        
        func gpu() -> String {
            switch self {
            case .i386, .x86_64, .arm64:
                return "N/A"
            case .Watch1_1, .Watch1_2:
                return "PowerVR Series 5"
            case .Watch2_6, .Watch2_7, .Watch2_3, .Watch2_4:
                return "PowerVR Series 6"
            case .Watch3_1, .Watch3_2, .Watch3_3, .Watch3_4:
                return "PowerVR"
            case .Watch4_1, .Watch4_2, .Watch4_3, .Watch4_4, .Watch5_1, .Watch5_2, .Watch5_3, .Watch5_4, .Watch5_9, .Watch5_10, .Watch5_11, .Watch5_12:
                return "Apple G11M"
            case .Watch6_1, .Watch6_2, .Watch6_3, .Watch6_4, .Watch6_6, .Watch6_7, .Watch6_8, .Watch6_9:
                return "?"
            }
        }
    }
}

// MARK: - Test for DeviceHardware
extension WatchDeviceHardware {
    func getHwMachine() -> String? {
        return self.getModelIdentifier()
    }
    
    func getHwModel() -> String? {
        var size: Int = 0
        sysctlbyname("hw.model", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: Int(size))
        if sysctlbyname("hw.model", &machine, &size, nil, 0) != 0 {
            return nil
        }
        let code: String = String(cString:machine)
        
        return code
    }
}

// MARK: - DeviceHardware Protocol
extension WatchDeviceHardware {
    func getRAM() -> Int {
        return Int(ProcessInfo.processInfo.physicalMemory)
    }
    
    func getRAMString() -> String {
        let bytes = getRAM()
        let formatter = ByteCountFormatter()
        formatter.countStyle = .memory
        return formatter.string(fromByteCount: Int64(bytes)).replacingOccurrences(of: " ", with: "")
    }
}
