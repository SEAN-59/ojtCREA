//
//  SimpleLoginVC.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/06.
//

import UIKit

import FirebaseAuth
import FirebaseCore

class SimpleLoginVC: CREAViewController {
    private let dbManager = DatabaseManager()
    
    @IBOutlet weak var backPageView: UIView!
    @IBOutlet weak var loginIndicator: UIActivityIndicatorView!
    @IBOutlet weak var naverLoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dbManager.delegate = self
    }
    
    @IBOutlet weak var testLbl: UILabel!
    
    @IBAction func fromYoutoSimple(_ segue: UIStoryboardSegue) {}
    
    @IBAction func logout(_ sender: UIButton) {
        try? Auth.auth().signOut()
    }
    
    private func toggleIndicator() {
        self.backPageView.isHidden.toggle()
        self.loginIndicator.isHidden.toggle()
        if loginIndicator.isHidden == true {
            self.loginIndicator.stopAnimating()
        } else {
            self.loginIndicator.startAnimating()
        }
    }
}

//MARK: - LOGIN BUTTON TAPPED
extension SimpleLoginVC {
    
    @IBAction func tapAppleLoginBtn(_ sender: UIButton) {
        let appleLogin = AppleLogin()
        appleLogin.presentingVC = self
//        appleLogin.delegate = self
//        self.startIndicator()
        appleLogin.startSignInWithAppleFlow()
    }
    
    @IBAction func tapGoogleLoginBtn(_ sender: UIButton) {
        let googleLogin = GoogleLogin()
        googleLogin.delegate = self
        googleLogin.googleSignIn(withFirebase: self)
    }
    
    
    @IBAction func tapNaverLoginBtn(_ sender: UIButton) {
        let naverLogin = NaverLogin()
        naverLogin.delegate = self
        naverLogin.naverSignIn()
//        self.startIndicator()
        
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

extension SimpleLoginVC: SendLoginResultDelegate, DatabaseCallDelegate {
    func sendSignInResult(result: Bool) {
        if result {
            guard let user = Auth.auth().currentUser else {return}
            print("UserId: \(user.uid)")
            self.dbManager.readUserDataUserType(uid: user.uid)
        } else {
            /// ????????? ???????????? ????????? ????????? ??????
            var actionArray: [UIAlertAction] = []
            let errorAction = UIAlertAction(title: "??????",
                                            style: .default,
                                            handler: {_ in
                self.toggleIndicator()
            })
            actionArray.append(errorAction)
            
            SimpleAlert().makeAlert(vc: self,
                                    title: "????????? ??????",
                                    message: "????????? ??? ????????? ?????????????????????.",
                                    actionArray: actionArray)
        }
        
    }
    
    
    func successReadUserType(result: Bool) {
        self.toggleIndicator()
        
        let storyBoard = UIStoryboard.init(name: "MapPage", bundle: nil)
        guard let nextVC =  storyBoard.instantiateViewController(withIdentifier: "MapVC") as? MapVC else { return }
        nextVC.modalPresentationStyle = .fullScreen
        guard let presentVC = self.presentingViewController else { return }
        
        self.dismiss(animated: false, completion: {
            nextVC.userType = result
            presentVC.present(nextVC, animated: true, completion: nil)
        })
    }
        
    
    
}
