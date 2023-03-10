//
//  AccountAgreeVC.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/13.
//

import UIKit

class AccountAgreeVC: CREAViewController {
    let dbManager = DatabaseManager()
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
            let errorAction = UIAlertAction(title: "??????",
                                            style: .default,
                                            handler: nil)
            actionArray.append(errorAction)
            SimpleAlert().makeAlert(vc: self,
                                    title: "?????? ??????",
                                    message: "?????? ????????? ???????????? ???????????????.",
                                    actionArray: actionArray)

        }
    }
}

extension AccountAgreeVC {
    private func dismissCreateAccount() {
        guard let presentingVC = self.presentingViewController else { return }
        self.dismiss(animated: true, completion:{
            presentingVC.dismiss(animated: false, completion: nil)
        })
    }
}

extension AccountAgreeVC: SendLoginResultDelegate{
    func sendCreateResult(_ result: Bool) {
        self.backPageView.isHidden = true
        self.createIndicator.isHidden = true
        self.createIndicator.stopAnimating()
        
        if result {
            self.dismissCreateAccount()
        } else {
            var actionArray: [UIAlertAction] = []
            let errorAction = UIAlertAction(title: "??????",
                                            style: .default,
                                            handler: nil)
            actionArray.append(errorAction)
            SimpleAlert().makeAlert(vc: self,
                                    title: "?????? ?????? ??????",
                                    message: "????????? ?????? ?????????\n??????????????? ?????????????????????.",
                                    actionArray: actionArray)
            
        }
    }
}
