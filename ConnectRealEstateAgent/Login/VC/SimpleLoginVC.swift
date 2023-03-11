//
//  SimpleLoginVC.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/06.
//

import UIKit

import FirebaseAuth
import FirebaseCore

import AuthenticationServices
import CryptoKit

class SimpleLoginVC: CREAViewController {
    fileprivate var currentNonce: String?
    ///////////////////////////
    
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
        self.startSignInWithAppleFlow()
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
            /// 로그인 실패하게 되었을 경우에 작업
            var actionArray: [UIAlertAction] = []
            let errorAction = UIAlertAction(title: "확인",
                                            style: .default,
                                            handler: {_ in
                self.toggleIndicator()
            })
            actionArray.append(errorAction)
            
            SimpleAlert().makeAlert(vc: self,
                                    title: "로그인 오류",
                                    message: "로그인 중 오류가 발생하였습니다.",
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
        
    func toggleIndiCator() {
        self.toggleIndicator()
    }
    
}


// MARK: - APPLE LOGIN




extension SimpleLoginVC {
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError(
                        "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                    )
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    func startSignInWithAppleFlow() {
        self.toggleIndicator()
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension SimpleLoginVC: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        print("In here?")
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            // Initialize a Firebase credential.
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            // Sign in with Firebase.
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if (error != nil) {
                    print(error!.localizedDescription)
                    self.toggleIndicator()
                    return
                } else  {
                    if let authResult = authResult {
                        self.dbManager.createData(type: .user, data: authResult.user.uid)
                        self.sendSignInResult(result: true)
                        self.toggleIndicator()
                    }
                }
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("Sign in with Apple errored: \(error)")
    }
}

extension SimpleLoginVC: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
