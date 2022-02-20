//
//  LoginPageView.swift
//  FaceID-FirebaseAuth-Login
//
//  Created by nakamura motoki on 2022/02/20.
//

import SwiftUI

struct LoginPageView: View {
    
    @StateObject private var loginViewModel: LoginViewModel = LoginViewModel()
    
    // MARK: FaceID Properties
    @AppStorage("use_face_id") var useFaceID: Bool = false
    
    var body: some View {
        VStack{
            Circle()
                .trim(from: 0, to:0.5)
                .fill(.black)
                .frame(width: 45, height: 45)
                .rotationEffect(.init(degrees: -90))
                .hLeading()
                .offset(x: -23)
                .padding(.bottom, 30)
            
            Text("Hey, \nLogin Now")
                .font(.largeTitle.bold())
                .foregroundColor(.black)
                .hLeading()
            
            // MARK: Textfields
            TextField("Email", text: $loginViewModel.email)
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            loginViewModel.email == "" ? Color.black.opacity(0.05) : Color("Orange")
                        )
                }// .background
                .textInputAutocapitalization(.never)
                .padding(.top, 20)
            
            TextField("password", text: $loginViewModel.email)
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            loginViewModel.password == "" ? Color.black.opacity(0.05) : Color("Orange")
                            
                        )
                    
                }// .background TextFields
                .textInputAutocapitalization(.never)
                .padding(.top, 15)
            
            // MARK: User Prompt to ask to store Login using FaceID on next time
            //This will ask the user whether the app can store the login details for future login usin FaceID and allows usersto Login easily without having to type everything again
            Group{
                if useFaceID{
                    Button{
                        // MARK: Do FaceID Action
                    }label: {
                        VStack(alignment: .leading, spacing: 10){
                            Label{
                                Text("Use FaceID to login into previous account")
                            }icon: {
                                Image(systemName: "faceid")
                            }
                            .font(.caption)
                            .foregroundColor(.gray)
                            
                            Text("Note: You can turn of it in settings!")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }// VStack
                    }// Button
                    .hLeading()
                }else{
                    Toggle(isOn: $useFaceID){
                        Text("Use FaceID to Login")
                    }
                }//  if useFaceID
            }// Group
            //.verticalは上下の余白を空ける
            .padding(.vertical, 20)
            
            Button{
                
            }label: {
                Text("Login")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .hCenter()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color("Brown"))
                    )
            }// Login Button
            .padding(.vertical, 15)
            //emailもしくはpasswordが未入力の場合はボタンの操作を無効にする
            .disabled(loginViewModel.email == "" || loginViewModel.password == "")
            //emailもしくはpasswordが未入力の場合はボタンを薄くする
            .opacity(loginViewModel.email == "" || loginViewModel.password == "" ? 0.5 : 1)
            
            NavigationLink{
                // MARK: Going home without login
            }label: {
                Text("Skip Now")
                    .foregroundColor(.gray)
            }// NavigationLink
        }// VStack
        // .horizontalは左右の余白を空ける
        .padding(.horizontal, 25)
        .padding(.vertical)
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}

// MARK: Extensions for UI Designing
// Viewを左寄せ・右寄せ・中央配置にする処理をまとめたメソッド
extension View{
    //Viewを左寄せにする
    func hLeading() -> some View{
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    //Viewを右寄せにする
    func hTrailing() -> some View{
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
    //Viewを中央配置にする
    func hCenter() -> some View{
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }
}
