//
//  FaceID_FirebaseAuth_LoginApp.swift
//  FaceID-FirebaseAuth-Login
//
//  Created by nakamura motoki on 2022/02/20.
//

import SwiftUI
import Firebase

@main
struct FaceID_FirebaseAuth_LoginApp: App {
    // MARK: Initialize Firebase
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
