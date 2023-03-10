//
//  CreateAccountVC.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/13.
//

import UIKit

class CreateAccountVC: CREAViewController {
    
    
    @IBOutlet weak var emailTxf: UITextField!
    @IBOutlet weak var passwordTxf: UITextField!
    @IBOutlet weak var checkPasswordTxf: UITextField!
    
    @IBOutlet weak var showPasswordBtn: UIButton!
    @IBOutlet weak var showCheckPasswordBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTxf.delegate = self
        self.passwordTxf.delegate = self
        self.checkPasswordTxf.delegate = self
    }
    
    @IBAction func fromYoutoCreate(_ segue: UIStoryboardSegue) {}
    
}

extension CreateAccountVC {
    @IBAction func tapShowPasswordBtn(_ sender: UIButton) {
        self.changeShowBtn(btn: self.showPasswordBtn, txf: self.passwordTxf)
    }
    
    @IBAction func tapShowCheckPasswordBtn(_ sender: UIButton) {
        self.changeShowBtn(btn: self.showCheckPasswordBtn, txf: self.checkPasswordTxf)
    }
    
    private func changeShowBtn(btn: UIButton, txf: UITextField) {
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10.0)]
        
        if txf.isSecureTextEntry {
            txf.isSecureTextEntry = false
            let title = NSAttributedString(string: "Hide", attributes: attribute)
            btn.setAttributedTitle(title, for: .normal)
            
        } else {
            txf.isSecureTextEntry = true
            let title = NSAttributedString(string: "Show", attributes: attribute)
            btn.setAttributedTitle(title, for: .normal)
        }
    }
    
    @IBAction func tapNextPageBtn(_ sender: UIButton) {
        guard let emailText = self.emailTxf.text else { return }
        guard let passwordText = self.passwordTxf.text else { return }
        guard let checkPasswordText = self.checkPasswordTxf.text else { return }
        
        let emailLogin = EmailLogin()
        
        if emailLogin.checkEmailTxf(emailText) {
            if passwordText == checkPasswordText {
                if emailLogin.checkPasswordTxf(checkPasswordText) {
                    self.moveToNextPage(email: emailText, password: checkPasswordText)
                } else {
                    
                    var actionArray: [UIAlertAction] = []
                    let errorAction = UIAlertAction(title: "??????",
                                                    style: .default,
                                                    handler: {_ in
                        self.passwordTxf.text = ""
                        self.checkPasswordTxf.text = ""
                    })
                    actionArray.append(errorAction)
                    SimpleAlert().makeAlert(vc: self,
                                            title: "???????????? ??????",
                                            message: "???????????? ????????? ???????????? ????????????.",
                                            actionArray: actionArray)
                }// ???????????? ?????? ??????
            } else {
                
                var actionArray: [UIAlertAction] = []
                let errorAction = UIAlertAction(title: "??????",
                                                style: .default,
                                                handler: {_ in
                    self.passwordTxf.text = ""
                    self.checkPasswordTxf.text = ""
                })
                actionArray.append(errorAction)
                SimpleAlert().makeAlert(vc: self,
                                        title: "???????????? ??????",
                                        message: "??????????????? ?????? ????????????.",
                                        actionArray: actionArray)
            }// ???????????? != ???????????? ??????
        } else {
            
            var actionArray: [UIAlertAction] = []
            let errorAction = UIAlertAction(title: "??????",
                                            style: .default,
                                            handler: {_ in
                self.emailTxf.text = ""
            })
            actionArray.append(errorAction)
            SimpleAlert().makeAlert(vc: self,
                                    title: "????????? ??????",
                                    message: "????????? ????????? ???????????? ????????????.",
                                    actionArray: actionArray)
        }// ????????? ?????? ??????
        
    }
    
    private func moveToNextPage(email: String, password: String) {
        let storyBoard = UIStoryboard.init(name: "LoginPage", bundle: nil)
        guard let nextVC = storyBoard.instantiateViewController(withIdentifier: "AccountAgreeVC") as? AccountAgreeVC else { return }
        
        nextVC.modalPresentationStyle = .fullScreen
        
        self.present(nextVC, animated: true, completion: {
            nextVC.email = email
            nextVC.password = password
        })
    }
    
}

extension CreateAccountVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}
