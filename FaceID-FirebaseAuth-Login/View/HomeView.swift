//
//  HomeView.swift
//  FaceID-FirebaseAuth-Login
//
//  Created by nakamura motoki on 2022/02/20.
//

import SwiftUI
import Firebase
//H ome page basically show from where the user came from
// (As a Guest or Logged User)and allows user to disable Face ID & logout from the app
struct HomeView: View {
    // Log Status
    // ユーザーのログインの有無を管理する
    @AppStorage("log_status") var logStatus: Bool = false
    
    var body: some View {
        VStack(spacing: 20){
            if logStatus{
                Text("Logged in")
                Button{
                    // ユーザーをログアウトさせる
                    try? Auth.auth().signOut()
                    //
                    logStatus = false
                }label: {
                    Text("Logout")
                }// Logoutボタン
            }else{
                Text("Came as Guest")
            }
        }// VStack
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Home")
    }// body
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
