//
//  AccountAgreeVC.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/13.
//

import UIKit

class AccountAgreeVC: UIViewController {
    var checkBoxArray: [Bool] = [false, false, false, false]
    var email: String = ""
    var password: String = ""
    
    @IBOutlet weak var firstCheckBox: UIButton!
    @IBOutlet weak var secondCheckBox: UIButton!
    @IBOutlet weak var thirdCheckBox: UIButton!
    @IBOutlet weak var fourthCheckBox: UIButton!
    
    
    @IBOutlet weak var createIndicator: UIActivityIndicatorView!
    @IBOutlet weak var backPageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension AccountAgreeVC{
    @IBAction func tapAllCheckBtn(_ sender: UIButton) {
        let falseCheck = self.checkBoxArray.filter({
            $0 == false
        })
        
        if falseCheck.count == 0 {
            self.checkBoxArray = [false, false, false, false]
            self.firstCheckBox.setImage(UIImage(systemName: "square"), for: .normal)
            self.secondCheckBox.setImage(UIImage(systemName: "square"), for: .normal)
            self.thirdCheckBox.setImage(UIImage(systemName: "square"), for: .normal)
            self.fourthCheckBox.setImage(UIImage(systemName: "square"), for: .normal)
        } else {
            self.checkBoxArray = [true, true, true, true]
            self.firstCheckBox.setImage(UIImage(systemName: "square.fill"), for: .normal)
            self.secondCheckBox.setImage(UIImage(systemName: "square.fill"), for: .normal)
            self.thirdCheckBox.setImage(UIImage(systemName: "square.fill"), for: .normal)
            self.fourthCheckBox.setImage(UIImage(systemName: "square.fill"), for: .normal)
        }
    }
    
    @IBAction func tapFirstCheckBox(_ sender: UIButton) {
        if self.checkBoxArray[0] {
            self.firstCheckBox.setImage(UIImage(systemName: "square"), for: .normal)
            self.checkBoxArray[0] = false
        } else {
            self.firstCheckBox.setImage(UIImage(systemName: "square.fill"), for: .normal)
            self.checkBoxArray[0] = true
        }
    }
    
    @IBAction func tapSecondCheckBox(_ sender: UIButton) {
        if self.checkBoxArray[1] {
            self.secondCheckBox.setImage(UIImage(systemName: "square"), for: .normal)
            self.checkBoxArray[1] = false
        } else {
            self.secondCheckBox.setImage(UIImage(systemName: "square.fill"), for: .normal)
            self.checkBoxArray[1] = true
        }
        
    }
    
    @IBAction func tapThirdCheckBox(_ sender: UIButton) {
        if self.checkBoxArray[2] {
            self.thirdCheckBox.setImage(UIImage(systemName: "square"), for: .normal)
            self.checkBoxArray[2] = false
        } else {
            self.thirdCheckBox.setImage(UIImage(systemName: "square.fill"), for: .normal)
            self.checkBoxArray[2] = true
        }
    }
    
    @IBAction func tapFourthCheckBox(_ sender: UIButton) {
        if self.checkBoxArray[3] {
            self.fourthCheckBox.setImage(UIImage(systemName: "square"), for: .normal)
            self.checkBoxArray[3] = false
        } else {
            self.fourthCheckBox.setImage(UIImage(systemName: "square.fill"), for: .normal)
            self.checkBoxArray[3] = true
        }
    }
    
    @IBAction func tapCreateAccountBtn(_ sender: UIButton) {
        
//            guard let presentingVC = self.presentingViewController else { return }
//            print(presentingVC.title)
////            presentingVC.dismiss(animated: true, completion: nil)
//            self.dismiss(animated: true, completion: {
//                self.dismiss(animated: true, completion: nil)
//            })
//
//        if false {
//
            
        let falseCheck = self.checkBoxArray.filter({
            
            $0 == false
        })

        if falseCheck.count == 0 {
            let emailLogin = EmailLogin()
            emailLogin.delegate = self
            self.backPageView.isHidden = false
            self.createIndicator.isHidden = false
            self.createIndicator.startAnimating()
            emailLogin.createEmail(self.email, password: self.password)

        } else {
            var actionArray: [UIAlertAction] = []
            let errorAction = UIAlertAction(title: "확인",
                                            style: .default,
                                            handler: nil)
            actionArray.append(errorAction)
            SimpleAlert().makeAlert(vc: self,
                                    title: "약관 동의",
                                    message: "필수 항목이 동의되지 않았습니다.",
                                    actionArray: actionArray)

        }

//    }
        
    }
    
}

extension AccountAgreeVC: sendEmailLoginResult{
    func sendCreateResult(_ result: Bool) {
        self.backPageView.isHidden = true
        self.createIndicator.isHidden = true
        self.createIndicator.stopAnimating()
        
        if result {
            guard let presentingVC = self.presentingViewController else { return }
            print(presentingVC.title)
            presentingVC.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
            
        } else {
            var actionArray: [UIAlertAction] = []
            let errorAction = UIAlertAction(title: "확인",
                                            style: .default,
                                            handler: nil)
            actionArray.append(errorAction)
            SimpleAlert().makeAlert(vc: self,
                                    title: "회원 가입 오류",
                                    message: "예기치 못한 오류로\n회원가입에 실패하였습니다.",
                                    actionArray: actionArray)
            
        }
    }
}
