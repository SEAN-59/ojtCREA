//
//  EmailLoginVC.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/06.
//

import UIKit

class EmailLoginVC: CREAViewController {
    private let emailLogin = EmailLogin()
    private let dbManager = DatabaseManager()
    
    @IBOutlet weak var emailTxf: UITextField!
    @IBOutlet weak var passwordTxf: UITextField!
    
    @IBOutlet weak var showBtn: UIButton!
    @IBOutlet weak var autoLoginBtn: UIButton!
    
    @IBOutlet weak var loginIndicator: UIActivityIndicatorView!
    @IBOutlet weak var backPageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        self.emailTxf.delegate = self
        self.passwordTxf.delegate = self
        self.emailLogin.delegate = self
        self.dbManager.delegate = self
    }
    
    @IBAction func fromYoutoLogin(_ segue: UIStoryboardSegue) {}
    
    @IBAction func tapShowBtn(_ sender: UIButton) {
        
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10.0)]
        
        if self.passwordTxf.isSecureTextEntry {
            self.passwordTxf.isSecureTextEntry = false
            let title = NSAttributedString(string: "Hide", attributes: attribute)
            self.showBtn.setAttributedTitle(title, for: .normal)
            
        } else {
            self.passwordTxf.isSecureTextEntry = true
            let title = NSAttributedString(string: "Show", attributes: attribute)
            self.showBtn.setAttributedTitle(title, for: .normal)
        }
    }
    
    @IBAction func tapAutoLoginBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func tapSignInBtn(_ sender: UIButton) {
        guard let emailText = self.emailTxf.text else { return }
        
        /// email 입력 형식 확인
        let emailCorrect = self.emailLogin.checkEmailTxf(emailText)
        if emailCorrect {
            guard let passwordText = self.passwordTxf.text else { return }
            
            /// 비밀번호 입력 형식 확인
            let pwCorrect = self.emailLogin.checkPasswordTxf(passwordText)
            if pwCorrect {
                self.backPageView.isHidden = false
                self.loginIndicator.isHidden = false
                self.loginIndicator.startAnimating()
                self.emailLogin.signInEmail(email: emailText, password: passwordText)
                
            } else {
                var actionArray: [UIAlertAction] = []
                let errorAction = UIAlertAction(title: "확인",
                                                style: .default,
                                                handler: {_ in
                    self.passwordTxf.text = ""
                })
                actionArray.append(errorAction)
                SimpleAlert().makeAlert(vc: self,
                                        title: "비밀번호 오류",
                                        message: "비밀번호 형식이 올바르지 않습니다.",
                                        actionArray: actionArray)
            }
        } else {
            var actionArray: [UIAlertAction] = []
            let errorAction = UIAlertAction(title: "확인",
                                            style: .default,
                                            handler: {_ in
                self.emailTxf.text = ""
            })
            actionArray.append(errorAction)
            SimpleAlert().makeAlert(vc: self,
                                    title: "이메일 오류",
                                    message: "이메일 형식이 올바르지 않습니다.",
                                    actionArray: actionArray)
        }
    }
    
    /// 비밀번호 찾기
    @IBAction func tapFindPasswordBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func tapCreateAccountBtn(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "LoginPage", bundle: nil)
        let nextVC =  storyBoard.instantiateViewController(withIdentifier: "CreateAccountVC")
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
}

extension EmailLoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}

extension EmailLoginVC: SendLoginResultDelegate, DatabaseCallDelegate {
    func sendSignInResult(result: Bool) {
        
        if result {
            guard let user = Auth.auth().currentUser else {return}
            self.dbManager.readUserData(uid: user.uid)
        } else {
            /// 로그인 실패하게 되었을 경우에 작업
            var actionArray: [UIAlertAction] = []
            let errorAction = UIAlertAction(title: "확인",
                                            style: .default,
                                            handler: nil)
            actionArray.append(errorAction)
            SimpleAlert().makeAlert(vc: self,
                                    title: "로그인 오류",
                                    message: "로그인 중 오류가 발생하였습니다.",
                                    actionArray: actionArray)
        }
        
    }
    
    
    func successReadUser(result: Bool) {
        self.backPageView.isHidden = true
        self.loginIndicator.stopAnimating()
        self.loginIndicator.isHidden = true
        
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
