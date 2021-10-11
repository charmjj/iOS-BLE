//
//  BLEManager.swift
//  iOS BLE
//
//  Created by Charmaine Lim on 11/10/21.
//

import Foundation
import CoreBluetooth

class BLEManager: BLEService, ObservableObject {
    public var bleCentral: BLECentral
    public var blePeripheral: BLEPeripheral
    
    init() {
        self.bleCentral = BLECentral()
        self.blePeripheral = BLEPeripheral()
    }
    
    func startAdvertising(address: String) -> Bool {
        blePeripheral.addService(address: address)
    }
    
    func stopAdvertising() {
        blePeripheral.removeService()
    }
    
    func startScanning() -> Bool {
        bleCentral.scanForPeripherals()
        return true
    }
    
    func stopScanning() {
        bleCentral.stopScan()
    }
    
    func onPayeeFound(completion: @escaping (String) -> Void) {
        bleCentral.onDeviceFound = completion
    }
    
    
}
