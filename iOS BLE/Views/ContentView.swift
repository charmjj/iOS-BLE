//
//  ContentView.swift
//  iOS BLE
//
//  Created by Charmaine Lim on 7/10/21.
//

import SwiftUI

struct ContentView: View {
    public var central = BLECentral()
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            Text("Take My Money!")
            Text("No. of discovered peripherals: \(central.discoveredPeripherals.count)")
            
            if central.discoveredPeripherals.count > 0 {
                List(central.discoveredPeripherals, id: \.peripheral) { peripheral in
                    PeripheralView(peripheral: peripheral)
                }
            } else {
                Text("No peripherals found")
            }
            
        }
        
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
