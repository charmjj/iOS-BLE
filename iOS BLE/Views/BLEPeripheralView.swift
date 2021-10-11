//
//  BLEPeripheralView.swift
//  iOS BLE
//
//  Created by Charmaine Lim on 10/10/21.
//

import SwiftUI

struct BLEPeripheralView: View {
    @EnvironmentObject var bleManager: BLEManager
    var body: some View {
        Text("Advertising...").onAppear(perform: {
            bleManager.startAdvertising(address: "TAKEMYMONEY")
        })
    }
}

struct BLEPeripheralView_Previews: PreviewProvider {
    static var previews: some View {
        BLEPeripheralView()
    }
}
