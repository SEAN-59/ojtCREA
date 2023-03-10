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
extension EmailLoginVC {
    
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
        
        /// email ?????? ?????? ??????
        let emailCorrect = self.emailLogin.checkEmailTxf(emailText)
        if emailCorrect {
            guard let passwordText = self.passwordTxf.text else { return }
            
            /// ???????????? ?????? ?????? ??????
            let pwCorrect = self.emailLogin.checkPasswordTxf(passwordText)
            if pwCorrect {
                // ?????? ?????? ?????? ????????? ????????? ???????????? ?????????
                self.toggleIndicator()
                self.emailLogin.signInEmail(email: emailText, password: passwordText)
                
            } else {
                var actionArray: [UIAlertAction] = []
                let errorAction = UIAlertAction(title: "??????",
                                                style: .default,
                                                handler: {_ in
                    self.passwordTxf.text = ""
                    self.toggleIndicator()
                })
                actionArray.append(errorAction)
                SimpleAlert().makeAlert(vc: self,
                                        title: "???????????? ??????",
                                        message: "???????????? ????????? ???????????? ????????????.",
                                        actionArray: actionArray)
            }
        } else {
            var actionArray: [UIAlertAction] = []
            let errorAction = UIAlertAction(title: "??????",
                                            style: .default,
                                            handler: {_ in
                self.emailTxf.text = ""
                self.toggleIndicator()
            })
            actionArray.append(errorAction)
            SimpleAlert().makeAlert(vc: self,
                                    title: "????????? ??????",
                                    message: "????????? ????????? ???????????? ????????????.",
                                    actionArray: actionArray)
        }
    }
    
    /// ???????????? ??????
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
        let storyBoard = UIStoryboard.init(name: "MapPage", bundle: nil)
        guard let nextVC =  storyBoard.instantiateViewController(withIdentifier: "MapVC") as? MapVC else { return }
        nextVC.modalPresentationStyle = .fullScreen
        guard let presentVC = self.presentingViewController else { return }
        
        self.dismiss(animated: false, completion: {
            self.toggleIndicator()
            nextVC.userType = result
            presentVC.present(nextVC, animated: true, completion: nil)
        })
    }
        
}
