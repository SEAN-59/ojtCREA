//
//  EmailLoginVC.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/06.
//

import UIKit

class EmailLoginVC: UIViewController {
    
    @IBOutlet weak var emailTxf: UITextField!
    @IBOutlet weak var passwordTxf: UITextField!
    
    @IBOutlet weak var showBtn: UIButton!
    @IBOutlet weak var autoLoginBtn: UIButton!
    private let emailLoginObjc = EmailLogin()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTxf.delegate = self
        self.passwordTxf.delegate = self
    }
    
    @IBAction func tapShowBtn(_ sender: UIButton) {
//        if self.showBtn.titleLabel!.text == "Show" {
//            self.showBtn.titleLabel!.text = "Hide"
//        } else if self.showBtn.titleLabel!.text == "Hide" {
//            self.showBtn.titleLabel!.text = "Show"
//        }
    }
    
    @IBAction func tapAutoLoginBtn(_ sender: UIButton) {
    }
    
    @IBAction func tapSignInBtn(_ sender: UIButton) {
        guard let emailText = self.emailTxf.text else { return }
        let emailCorrect = self.emailLoginObjc.checkEmailTxf(emailText)
        if emailCorrect {
            guard let passwordText = self.passwordTxf.text else { return }
            let pwCorrect = self.emailLoginObjc.checkPasswordTxf(passwordText)
            if pwCorrect {
                self.emailLoginObjc.sign(inEmail: emailText, password: passwordText)
                
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
    
    @IBAction func tapFindPasswordBtn(_ sender: UIButton) {
    }
    
    @IBAction func tapCreateAccountBtn(_ sender: UIButton) {
    }
    
}

extension EmailLoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
}
