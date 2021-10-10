//
//  DiscoveredPeripheral.swift
//  iOS BLE
//
//  Created by Charmaine Lim on 8/10/21.
//

import Foundation
import CoreBluetooth

class DiscoveredPeripheral {
    var peripheral: CBPeripheral
    var rssi: NSNumber // signal strength
    var advertisementData: [String: Any]
    
    init(peripheral: CBPeripheral, rssi: NSNumber, advertisementData: [String: Any]) {
        self.peripheral = peripheral
        self.rssi = rssi
        self.advertisementData = advertisementData
    }
        
    
    
}
