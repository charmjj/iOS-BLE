//
//  BLECentral.swift
//  iOS BLE
//
//  Created by Charmaine Lim on 8/10/21.
//

import Foundation
import CoreBluetooth

class BLECentral: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate, ObservableObject {
    
    private var manager: CBCentralManager! // scans for, discovers, connects to, and manages peripherals
    @Published private(set) var discoveredPeripherals = [DiscoveredPeripheral]() // each time centralManager discovers a peripheral, it'll be added here
    private var connectedPeripheral: CBPeripheral?
    var onDiscovered: (()->Void)?
    var onDeviceFound: ((String) -> Void)?
        
    override init() {
        super.init()
        manager = CBCentralManager(delegate: self, queue: nil)
        
    }
    
    // 2.
    func scanForPeripherals() {
        let options: [String: Any] = [CBCentralManagerScanOptionAllowDuplicatesKey:false]
        manager.scanForPeripherals(withServices: [CBUUID(string: BLEIdentifiers.serviceIdentifier)], options: options)
    }
    
    // 4.
    func connect(at index: Int) {
        guard index >= 0, index < discoveredPeripherals.count else { return }
        manager.stopScan()
        manager.connect(discoveredPeripherals[index].peripheral, options: nil) // async
    }
    
    func stopScan() {
        manager.stopScan()
    }
    
    // MARK: - CBCentralManagerDelegate
    
    // 1.
    func centralManagerDidUpdateState(_ central: CBCentralManager) { // is central device's bluetooth powered on?
        if central.state == .poweredOn {
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
            print("existing peripheral's properties updated in centralManager function")
        } else {
            if let name = peripheral.name {
                // TODO: CHECK IF RSSI HITS THRESHOLD ~5cm
                if Int(RSSI) > -55 {
                    discoveredPeripherals.append(DiscoveredPeripheral(peripheral: peripheral, rssi: RSSI, advertisementData: advertisementData))
//                    if let onDeviceFound = onDeviceFound {
//                        onDeviceFound(name)
//                    }
                    print("new legit peripheral discovered in centralManager function")
                    print(advertisementData)
                    connect(at: 0)
                }
//                print("new legit peripheral discovered in centralManager function")
//                print(advertisementData)
//                connect(at: 0)
            }

        }
    }
    
    // 5a.
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("central did connect")
        connectedPeripheral = peripheral
        connectedPeripheral?.delegate = self
        connectedPeripheral?.discoverServices([CBUUID(string: BLEIdentifiers.serviceIdentifier)])
        
    }
    
    // 5b.
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("central did fail to connect")
    }
    
    // MARK: - CBPeripheralDelegate
    
    // 6.
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let error = error {
            print("peripheral failed to discover services: \(error.localizedDescription)")
        } else {
            peripheral.services?.forEach({ service in
                print("service discovered: \(service)")
                peripheral.discoverCharacteristics([CBUUID(string: BLEIdentifiers.characteristicIdentifier)], for: service)
            })
        }
    }
    
    // 7.
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let error = error {
            print("Peripheral failed to discover characteristics: \(error.localizedDescription)")
        } else {
            service.characteristics?.forEach({ characteristic in
                print("characteristic discovered: \(characteristic)")
                if characteristic.properties.contains(.read) {
                    peripheral.readValue(for: characteristic)
                }
                peripheral.discoverDescriptors(for: characteristic)
            })
        }
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("peripheral failed to discover descriptor: \(error.localizedDescription)")
        } else if characteristic.uuid.uuidString == BLEIdentifiers.characteristicIdentifier {
            if let descriptor = characteristic.descriptors?.first {
                if let onDeviceFound = onDeviceFound {
                    onDeviceFound(descriptor.description)
                }
            }
            characteristic.descriptors?.forEach({ descriptor in
                print("descriptor discovered: \(descriptor)")
                peripheral.readValue(for: descriptor)
            })
              
        } else {
            
            characteristic.descriptors?.forEach({ descriptor in
                print("descriptor discovered: \(descriptor)")
                peripheral.readValue(for: descriptor)
            })
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("peripheral error updating value for characteristic: \(error.localizedDescription)")
        } else {
            print("characteristic value updated: \(characteristic)")
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
        if let error = error {
            print("peripheral error updating value for descriptor: \(error.localizedDescription)")
//        } else {
//            print("descriptor value updated: \(descriptor)")
//        }
        }
        else {
                if let onDeviceFound = onDeviceFound {
                    onDeviceFound(descriptor.value as! String)
                }
              
        }
    }
    
    
    
    
    
}
