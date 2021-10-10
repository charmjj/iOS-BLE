//
//  ContentView.swift
//  iOS BLE
//
//  Created by Charmaine Lim on 11/10/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 30) {
                NavigationLink(destination: DiscoveredPeripheralsView()) {
                    Text("Pay Money")
                }

                NavigationLink(destination: BLEPeripheralView() ) {
                    Text("Receive Money")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
