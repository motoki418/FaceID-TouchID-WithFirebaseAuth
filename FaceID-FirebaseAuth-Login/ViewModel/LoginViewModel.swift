//
//  LoginViewModel.swift
//  FaceID-FirebaseAuth-Login
//
//  Created by nakamura motoki on 2022/02/20.
//

import SwiftUI
import Firebase
import LocalAuthentication

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
    func loginUser(useFaceID: Bool, email: String = "", password: String = "")async throws {
        
        let _ = try await Auth.auth().signIn(withEmail: email != "" ? email : self.email, password: password != "" ? password : self.password)
        
        DispatchQueue.main.async { [self] in
            //If user is toggled to save the data for future login then saving data with userdefaults otherwise simply setting log status to true
            if useFaceID{
                self.useFaceID = useFaceID
                // MARK: Storing for future face ID Login
                self.faceIDEmail = email
                self.FaceIDpassword = password
            }
            self.logStatus = true
        }
    }// loginUserメソッド
    
    // MARK: FaceID Usage
    // For some reasons users may have disabled Biometric Access or the iPhone might not have Face ID or Touch ID
    // In that scenario this method will be useful to know that the App is allowed to use Biometric Options, based on that show the FaceID toggle to the user
    func getBioMetricStatus() -> Bool{
        //LAContextクラスのインスタンス生成
        let scanner = LAContext()
        
        return scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none)
    }
    
    // MARK: FaceID Login
    //Now lets write the code that will verify the user with Biometric Options
    func authenticateUser()async throws{
        
        let status = try await LAContext().evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To Login Into App")
        
        if status{
            try await loginUser(useFaceID: useFaceID, email: self.faceIDEmail, password: self.FaceIDpassword)
        }
    }
}
