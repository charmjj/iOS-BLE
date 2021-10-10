//
//  BLECentral.swift
//  iOS BLE
//
//  Created by Charmaine Lim on 8/10/21.
//

import Foundation
import CoreBluetooth

class BLECentral: NSObject, CBCentralManagerDelegate {
    
    var manager: CBCentralManager! // scans for, discovers, connects to, and manages peripherals
    var discoveredPeripherals = [DiscoveredPeripheral]() // each time centralManager discovers a peripheral, it'll be added here
    var onDiscovered: (()->Void)?
        
    override init() {
        super.init()
        manager = CBCentralManager(delegate: self, queue: nil)
        
    }
    
    // 2.
    func scanForPeripherals() {
        let options: [String: Any] = [CBCentralManagerScanOptionAllowDuplicatesKey:false]
        manager.scanForPeripherals(withServices: nil, options: options) // TODO: APP ID put inside withServices
    }
    
    // MARK: - CBCentralManagerDelegate
    
    // 1.
    // REQUIRED function: Tells the delegate the central manager’s state updated. You should issue commands to the central manager only when the central manager’s state indicates it’s powered on!!!
    func centralManagerDidUpdateState(_ central: CBCentralManager) { // is central device's bluetooth powered on?
        if central.state == .poweredOn {
            scanForPeripherals()
            print("central is powered on")
        } else {
            print("central is unavailable: \(central.state.rawValue)")
        }
    }
    
    // 3.
    // callback method: invoked while scanning, upon the discovery of peripheral by central. Tells the delegate that the central manager discovered a peripheral while scanning for devices.
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if let existingPeripheral = discoveredPeripherals.first(where: {$0.peripheral == peripheral}) {
            // update properties on existing element
            existingPeripheral.advertisementData = advertisementData
            existingPeripheral.rssi = RSSI
        } else {
            discoveredPeripherals.append(DiscoveredPeripheral(peripheral: peripheral, rssi: RSSI, advertisementData: advertisementData))
        }
        onDiscovered?()
    }
    
    
    
}
