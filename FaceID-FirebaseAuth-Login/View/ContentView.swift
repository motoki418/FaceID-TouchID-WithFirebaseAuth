//
//  ContentView.swift
//  FaceID-FirebaseAuth-Login
//
//  Created by nakamura motoki on 2022/02/20.
//

import SwiftUI

struct ContentView: View {
    
    // Log Status
    // ユーザーのログインの有無を管理する
    @AppStorage("log_status") var logStatus: Bool = false
    
    var body: some View {
        NavigationView{
            // Now lets do a simple check in ContentView.
            // Which will evaluate if the user is already logged in then redirect them to Home Page other wise simply show the Login Screen
            if logStatus{
                HomeView()
            }else{
                LoginPageView()
                    .navigationBarHidden(true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
