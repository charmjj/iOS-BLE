//
//  ContentView.swift
//  iOS BLE
//
//  Created by Charmaine Lim on 7/10/21.
//

import SwiftUI

struct DiscoveredPeripheralsView: View {
    @StateObject public var central = BLECentral()
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            Text("Take My Money!")
            Text("No. of discovered peripherals: \(central.discoveredPeripherals.count)")
            
            if central.discoveredPeripherals.count > 0 {
                List(central.discoveredPeripherals, id: \.peripheral) { peripheral in
                    if peripheral.peripheral.name != nil {
                        DiscoveredPeripheralView(peripheral: peripheral)
                    }
                }
            } else {
                Text("No peripherals found")
            }
            
        }
        
            
    }
}

struct DiscoveredPeripheralsView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoveredPeripheralsView()
    }
}
