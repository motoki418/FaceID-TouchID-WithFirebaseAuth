//
//  LoginViewModel.swift
//  FaceID-FirebaseAuth-Login
//
//  Created by nakamura motoki on 2022/02/20.
//

import SwiftUI

class LoginViewModel: ObservableObject{
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    // These properties allows us to store the login credntial safely on the iPhone
    // MARK: FaceID Properties
    @AppStorage("use_face_id") var useFaceID: Bool = false
    @AppStorage("use_face_email") var faceIDEmail: String = ""
    @AppStorage("use_face_password") var FaceIDpassword: String = ""
    
    // MARK: Firebase Login
    // Now lets write the code that will verify the user credential with firebase
    // credential= 信用証明書
    func loginUser() {
        
    }
}
