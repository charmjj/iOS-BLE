//
//  iOS_BLEApp.swift
//  iOS BLE
//
//  Created by Charmaine Lim on 7/10/21.
//

import SwiftUI

@main
struct iOS_BLEApp: App {
    
    @StateObject var bleManager = BLEManager()
    
    var body: some Scene {
        WindowGroup("TAKE MY MONEY") {
            ContentView().environmentObject(bleManager)
        }
    }
}
