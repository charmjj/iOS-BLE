//
//  BLEService.swift
//  iOS BLE
//
//  Created by Charmaine Lim on 9/10/21.
//

import Foundation

protocol BLESerivce {
    func startAdvertising(address: String) -> Bool
    func stopAdvertising()
    func startScanning() -> Bool
    func stopScanning()
    func onPayeeFound(completion: @escaping (String) -> Void)
}
