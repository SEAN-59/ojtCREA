//
//  SimpleLoginVC.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/06.
//

import UIKit

//import FirebaseAuth
//import FirebaseCore

class SimpleLoginVC: UIViewController {
    
    @IBOutlet weak var backPageView: UIView!
    @IBOutlet weak var loginIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var naverLoginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var testLbl: UILabel!
    
    @IBAction func fromYoutoSimple(_ segue: UIStoryboardSegue) {}
    
    @IBAction func logout(_ sender: UIButton) {
        try? Auth.auth().signOut()
    }
    
    private func startIndicator() {
        self.backPageView.isHidden = false
        self.loginIndicator.startAnimating()
        self.loginIndicator.isHidden = false
    }
}

//MARK: - LOGIN BUTTON TAPPED
extension SimpleLoginVC {
    
    @IBAction func tapAppleLoginBtn(_ sender: UIButton) {
        let appleLogin = AppleLogin()
        appleLogin.delegate = self
        self.startIndicator()
        appleLogin.startSignInWithAppleFlow()
    }
    
    @IBAction func tapGoogleLoginBtn(_ sender: UIButton) {
        let googleLogin = GoogleLogin()
        googleLogin.delegate = self
        self.startIndicator()
        googleLogin.googleSignIn(withFirebase: self)
    }
    
    
    @IBAction func tapNaverLoginBtn(_ sender: UIButton) {
//        let naverLogin = NaverLogin()
//        naverLogin.delegate = self
//        self.startIndicator()
        
        let dbManager = DatabaseManager()
    }
    
    @IBAction func tapKakaoLoginBtn(_ sender: UIButton) {
        let kakaoLogin = KakaoLogin()
        kakaoLogin.delegate = self
        kakaoLogin.loginKakaoAccount()
    }
    
    @IBAction func tapEmailLoginBtn(_ sender: UIButton) {

        let storyBoard = UIStoryboard.init(name: "LoginPage", bundle: nil)
        let loginVC =  storyBoard.instantiateViewController(withIdentifier: "EmailLoginVC")
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
    }
    
    
}


extension SimpleLoginVC: SendAPIDataDelegate {
    func getAPIData(json data: [AnyHashable : Any]) {
        print("Load End")
    }
}

extension SimpleLoginVC: SendSocialLoginResult {
    func sendSignInResult(result: Bool) {
        if result {
            self.backPageView.isHidden = true
            self.loginIndicator.stopAnimating()
            self.loginIndicator.isHidden = true
            
            let storyBoard = UIStoryboard.init(name: "MapPage", bundle: nil)
            guard let nextVC =  storyBoard.instantiateViewController(withIdentifier: "MapVC") as? MapVC else { return }
            nextVC.modalPresentationStyle = .fullScreen
            guard let presentVC = self.presentingViewController else { return }
            
            self.dismiss(animated: false, completion: {
                presentVC.present(nextVC, animated: false, completion: nil)
            })
            

        }
    }
}
