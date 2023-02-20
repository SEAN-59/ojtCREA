//
//  KakaoLogin.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/06.
//

import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class KakaoLogin {
    let
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
                print("loginWithKakaoAccount() success Token: \(oauthToken).")
                
                _ = oauthToken
            }
        }
    }
    
    
}

extension KakaoLogin: SendSocialLoginResult {
    
    
}
