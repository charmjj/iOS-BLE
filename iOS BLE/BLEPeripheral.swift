//
//  BLEPeripheral.swift
//  iOS BLE
//
//  Created by Charmaine Lim on 8/10/21.
//

import Foundation
import CoreBluetooth

// SOME USEFUL BACKGROUND INFO:
// Service: encapsulates the way part of the device behaves. For example, one service of a heart rate monitor may be to expose heart rate data from a sensor. Service contains characteristics
// Characteristic: represents a piece of info/data the server (peripheral) want to expose to the client (central)
// A characteristic contains other attributes that help define the value it holds:
    // Properties: Define how a characteristic's value can be used (read, write, notify, write w/o response...)
    // Descriptors: Contain related info about the characteristic value (e.g. user description, enabling notifs, presentation format...)

class BLEPeripheral: NSObject, CBPeripheralManagerDelegate { // TOOD: vs CBPeripheralDelegate ???
    private var manager: CBPeripheralManager!
    private var characteristic: CBMutableCharacteristic! // provide write access to the properties in this parent class
    
    override init() {
        super.init()
        manager = CBPeripheralManager(delegate: self, queue: nil) // default: peripheral events default occur on main queue
    }
    
    // 2.
    func setup() { // characteristic aka state
        let characteristicUUID = CBUUID(string: BLEIdentifiers.characteristicIdentifier)
        characteristic = CBMutableCharacteristic(type: characteristicUUID, properties: [.read], value: nil, permissions: [.readable])
        // descriptor: provide additional info about the characteristic, or allow its behavior to be controlled
        let descriptor = CBMutableDescriptor(type: CBUUID(string: CBUUIDCharacteristicUserDescriptionString), value: "BLESensor prototype")
        characteristic.descriptors = [descriptor]
        
        let serviceUUID = CBUUID(string: BLEIdentifiers.serviceIdentifier)
        let service = CBMutableService(type: serviceUUID, primary: true)
        
        service.characteristics = [characteristic]
        
        manager.add(service)// here, service is cached, and we cannot make anymore changes
    }
    
    // MARK: CBPeripheralManagerDelegate
    
    // 1.
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            print("peripheral is powered on")
        } else {
            print("peripheral not avail: \(peripheral.state.rawValue)")
        }
    }
    
    // 3.
    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        if let error = error {
            print("Could not add service: \(error.localizedDescription)")
        } else {
            print("Peripheral added service. Begin advertising")
            let advertisementData: [String: Any] = [
                CBAdvertisementDataServiceUUIDsKey: [CBUUID(string: BLEIdentifiers.serviceIdentifier)],
                CBAdvertisementDataLocalNameKey: "BLE Sensor"
            ]
            manager.startAdvertising(advertisementData)
        }
    }
    
    // 4.
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        if let error = error {
            print("Could not start advertising: \(error.localizedDescription)")
        } else {
            print("Peripheral started advertising")
        }
    }
    
}
