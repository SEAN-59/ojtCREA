//
//  KakaoLogin.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/06.
//

import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class KakaoLogin : NSObject{
    var delegate: SendLoginResultDelegate?
    
//    func canOpenKakaoLogin() { // 카카오 톡으로 로그인
//        if (UserApi.isKakaoTalkLoginAvailable()) {
//            UserApi.shared.loginwithkakaotalk
//        }
//
//    }
    
    func loginKakaoAccount() {
        UserApi.shared.loginWithKakaoAccount{(oauthToken, error) in
            if let error = error {
                print("\(error)")
            } else {
                self.signInFirebase()
            }
        }
    }
    
    func readKakaoUser() -> (String) {
        var result: String = ""
        UserApi.shared.me { user, error in
            if error == nil {
                guard let user = user else { return }
                result = String(describing: user.id)
            }
        }
        
        return result
    }
    
    /// Login 시
    /// ID      : {user.id}@crea.kakao
    /// PW    : {user.id}creakakao
    ///
    func signInFirebase() {
        let id = readKakaoUser()
        let tempEmail = "\(id)@crea.kako"
        let tempPassword = "\(id)creakakao"
        /// 로그인 전에 이메일이 있는지 없는지 확인을 하는 구간이 필요로 할 것 같음
        /// 아니면 로그인을 먼저 해보고 로그인 실패시에 해당 오류를 가지고 가입부터 진행을 하는 방식으로 새로 짜도 될것 같음
        
    }

    
    
}

extension KakaoLogin: SendLoginResultDelegate {
}
