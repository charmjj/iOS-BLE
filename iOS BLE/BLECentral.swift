//
//  BLECentral.swift
//  iOS BLE
//
//  Created by Charmaine Lim on 8/10/21.
//

import Foundation
import CoreBluetooth

class BLECentral: NSObject, CBCentralManagerDelegate {
    
    var manager: CBCentralManager!
    var discoveredPeripherals = [CBPeripheral]()
    var onDiscovered: (()->Void)?
        
    override init() {
        super.init()
        manager = CBCentralManager(delegate: self, queue: nil)
        
    }
    
    func scanForPeripherals() {
        manager.scanForPeripherals(withServices: nil, options: nil) // TODO: APP ID
    }
    
    // MARK: - CBCentralManagerDelegate
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            scanForPeripherals()
            print("central is powered on")
        } else {
            print("central is unavailable: \(central.state.rawValue)")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        discoveredPeripherals.append(peripheral)
        onDiscovered?()
    }
    
    
    
}
