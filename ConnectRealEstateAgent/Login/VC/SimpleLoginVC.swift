//
//  SimpleLoginVC.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/06.
//

import UIKit
//import GoogleLogin

class SimpleLoginVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func dismissVC(_ segue: UIStoryboardSegue) {}

}

//MARK: - LOGIN BUTTON TAPPED
extension SimpleLoginVC {
    
    @IBAction func tapAppleLoginBtn(_ sender: UIButton) {
        let appleLogin = AppleLogin()
        appleLogin.startSignInWithAppleFlow()
    }
    
    @IBAction func tapGoogleLoginBtn(_ sender: UIButton) {
        let googleLogin = GoogleLogin()
        googleLogin.googleSignIn(withFirebase: self)

        
    }
    
    @IBAction func tapNaverLoginBtn(_ sender: UIButton) {
        let naverLogin = NaverLogin()
    }
    
    @IBAction func tapKakaoLoginBtn(_ sender: UIButton) {
        let kakaoLogin = KakaoLogin()
        kakaoLogin.loginKakaoAccount()
    }
    
    @IBAction func tapEmailLoginBtn(_ sender: UIButton) {

        let storyBoard = UIStoryboard.init(name: "LoginPage", bundle: nil)
        let loginVC =  storyBoard.instantiateViewController(withIdentifier: "EmailLoginVC")
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
    }
    
    
}
