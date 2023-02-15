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
//        let naverLogin = NaverLogin()
        
        let searchAddress = SearchAddress()
        searchAddress.delegate = self
        searchAddress.choiceRoad("충청남도 천안시 서북구 성정동 835-1번지")
//        searchAddress.choiceRoad()
//        searchAddress.choiceBuildSggCd("44133", bjdCd: "10200", bun: "0835", ji: "0001")
        
//        var bjdKorea: Korea = .init(selectCityNm: "", selectSggNm: "", selectEmdNm: "")
//
//        guard let result = bjdKorea.cityNm.firstIndex(of: "강원도") else { return }
//        
//        print(result)
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
    func getAPIData(json data: Any) {
        print("Load End")
    }
}
