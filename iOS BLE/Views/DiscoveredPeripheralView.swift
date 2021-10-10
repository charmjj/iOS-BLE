//
//  PeripheralView.swift
//  iOS BLE
//
//  Created by Charmaine Lim on 10/10/21.
//

import SwiftUI

struct DiscoveredPeripheralView: View {
    public var peripheral: DiscoveredPeripheral
    
    var body: some View {
        HStack {
            Text(peripheral.peripheral.name ?? "nameless")
            Text("\(peripheral.peripheral.identifier.uuidString)")
            Text("\(peripheral.rssi)")
            Text("\(peripheral.advertisementData.debugDescription)")
            
        }
    }
}

//struct PeripheralView_Previews: PreviewProvider {
//    static var previews: some View {
//        PeripheralView()
//    }
//}
