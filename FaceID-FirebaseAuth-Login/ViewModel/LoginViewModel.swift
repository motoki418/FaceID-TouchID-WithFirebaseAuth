//
//  LoginViewModel.swift
//  FaceID-FirebaseAuth-Login
//
//  Created by nakamura motoki on 2022/02/20.
//

import SwiftUI
import Firebase

class LoginViewModel: ObservableObject{
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    // These properties allows us to store the login credntial safely on the iPhone
    // MARK: FaceID Properties
    @AppStorage("use_face_id") var useFaceID: Bool = false
    @AppStorage("use_face_email") var faceIDEmail: String = ""
    @AppStorage("use_face_password") var FaceIDpassword: String = ""
    
    //　MARK: FIrebase Login
    // ユーザーのログインの有無を管理する
    @AppStorage("log_status") var logStatus: Bool = false
    
    // MARK: Error
    // Instead of printing error messages in cosore we can show as a alert to user
    @Published var showError: Bool = false
    @Published var errorMsg: String = ""
    
    // MARK: Firebase Login
    // Now lets write the code that will verify the user credential with firebase
    // credential= 信用証明書
    // From Xcode 13.2 async/await which is made  backward compabity(iOS 13)
    // Async/Awaitit makes code more simple and easy to read
    func loginUser(useFaceID: Bool)async throws {
        
        let _ = try await Auth.auth().signIn(withEmail: email, password: password)
        
        //If user is toggled to save the data for future login then saving data with userdefaults otherwise simply setting log status to true
        if useFaceID{
            self.useFaceID = useFaceID
            // MARK: Storing for future face ID Login
            faceIDEmail = email
            FaceIDpassword = password
        }
        logStatus = true
    }
}
