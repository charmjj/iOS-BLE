//
//  BLEPeripheralView.swift
//  iOS BLE
//
//  Created by Charmaine Lim on 10/10/21.
//

import SwiftUI

struct BLEPeripheralView: View {
    @StateObject public var peripheral = BLEPeripheral()
    var body: some View {
        Text("Advertising...")
    }
}

struct BLEPeripheralView_Previews: PreviewProvider {
    static var previews: some View {
        BLEPeripheralView()
    }
}
