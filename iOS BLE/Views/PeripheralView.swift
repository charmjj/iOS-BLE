//
//  PeripheralView.swift
//  iOS BLE
//
//  Created by Charmaine Lim on 10/10/21.
//

import SwiftUI

struct PeripheralView: View {
    public var peripheral: DiscoveredPeripheral
    
    var body: some View {
        HStack {
            Text(peripheral.peripheral.name ?? "no name")
            Text("\(peripheral.rssi)")
        }
    }
}

//struct PeripheralView_Previews: PreviewProvider {
//    static var previews: some View {
//        PeripheralView()
//    }
//}
