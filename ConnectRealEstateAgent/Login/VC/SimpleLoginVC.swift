//
//  SimpleLoginVC.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/06.
//

import UIKit
//import GoogleLogin

class SimpleLoginVC: UIViewController {
    
    @IBOutlet weak var naverLoginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var testLbl: UILabel!
    
    @IBAction func fromYoutoSimple(_ segue: UIStoryboardSegue) {}
    
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
        let dbManager = DatabaseManager()
        let testDict: Dictionary = [
            "test1": 1,
            "test2": 2,
            "test3": 3,
            "test4": 4,
            "test5": 5,
        ]
        dbManager.writeData(input: testDict)
//        let storyBoard = UIStoryboard.init(name: "ItemPage", bundle: nil)
//        let nextVC = storyBoard.instantiateViewController(withIdentifier: "AddItemVC")
//        nextVC.modalPresentationStyle = .fullScreen
//        self.present(nextVC, animated: true, completion: nil)
        
//        let naverLogin = NaverLogin()
        
//        let searchAddress = SearchAddress()
//        searchAddress.delegate = self
//        searchAddress.choiceRoad("충청남도 천안시 서북구 성정동 835-1번지")
        
        
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


extension SimpleLoginVC: SendAPIDataDelegate {
    func getAPIData(json data: [AnyHashable : Any]) {
        print("Load End")
    }
}
