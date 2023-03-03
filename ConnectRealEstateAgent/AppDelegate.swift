//
//  AppDelegate.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/06.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

import GoogleSignIn

import KakaoSDKCommon
import KakaoSDKAuth

import NMapsMap
import NaverThirdPartyLogin

 
//let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
//    let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        KakaoSDK.initSDK(appKey: KAKAO_KEY)
        NMFAuthManager.shared().clientId = NAVER_ID

        
        let instance = NaverThirdPartyLoginConnection.getSharedInstance()
        instance?.isNaverAppOauthEnable = true
        instance?.isInAppOauthEnable = true
        instance?.setOnlyPortraitSupportInIphone(true)
        
        
        // 네이버 아이디로 로그인하기 설정
        
        instance?.serviceUrlScheme = kServiceAppUrlScheme
        instance?.consumerKey = kConsumerKey
        instance?.consumerSecret = kConsumerSecret
        instance?.appName = kServiceAppName

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        var returnValue = false
        var kakaoReturn = false
        var googleReturn = false
        var naverReturn = false
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            kakaoReturn = AuthController.handleOpenUrl(url: url)
        }
        googleReturn = GIDSignIn.sharedInstance.handle(url)
        naverReturn = NaverThirdPartyLoginConnection.getSharedInstance().application(app, open: url, options: options)
        
        returnValue = kakaoReturn && googleReturn && naverReturn
        return returnValue
    }


}
