//
//  ContentView.swift
//  iOS BLE
//
//  Created by Charmaine Lim on 7/10/21.
//

import SwiftUI
// CENTRAL
struct DiscoveredPeripheralsView: View {
//    @StateObject public var central: BLECentral
    @EnvironmentObject var bleManager: BLEManager
    @State var deviceFound: Bool = false
    @State var address: String = ""
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            Text("Take My Money!")
            Text("No. of discovered peripherals: \(bleManager.bleCentral.discoveredPeripherals.count)")
            
            if deviceFound {
//                List(bleManager.bleCentral.discoveredPeripherals, id: \.peripheral) { peripheral in
//                    if peripheral.peripheral.name != nil {
//                       DiscoveredPeripheralView(peripheral: peripheral)
//                    }
//                }
                Text(address)
            } else {
                Text("No peripherals found")
            }
            
        }.onAppear(perform: {
            bleManager.startScanning()
            bleManager.onPayeeFound { address in
                print("on payee found: \(address)")
                deviceFound = true
                self.address = address
                
            }
        })
        
            
    }
}

struct DiscoveredPeripheralsView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoveredPeripheralsView()
    }
}
