//
//  SimpleLoginVC.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/06.
//

import UIKit

class SimpleLoginVC: UIViewController {
    private lazy var backBarbtn = UIBarButtonItem()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction func tapBackBtn(_ sender: UIBarButtonItem) {
        print("asd")
    }
    
    
    @IBAction func tapBackBarBtn(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
}

//MARK: - LOGIN BUTTON TAPPED
extension SimpleLoginVC {
    
    @IBAction func tapAppleLoginBtn(_ sender: UIButton) {
    }
    
    @IBAction func tapGoogleLoginBtn(_ sender: UIButton) {
    }
    
    @IBAction func tapNaverLoginBtn(_ sender: UIButton) {
    }
    
    @IBAction func tapKakaoLoginBtn(_ sender: UIButton) {
        let kakaoLogin = KakaoLogin()
        kakaoLogin.loginKakaoAccount()
    }
    
    @IBAction func tapEmailLoginBtn(_ sender: UIButton) {

        let storyBoard = UIStoryboard.init(name: "LoginPage", bundle: nil)
        let loginVC =  storyBoard.instantiateViewController(withIdentifier: "EmailLoginVC")
        loginVC.modalPresentationStyle = .fullScreen
//        loginVC.modalTransitionStyle = .coverVertical
        self.present(loginVC, animated: true, completion: nil)
    }
    
    
}
