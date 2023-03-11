//
//  ChangeNameViewController.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/03/07.
//

import UIKit

class ChangeNameViewController: CREAViewController {
    let dbManager = DatabaseManager()

    @IBOutlet weak var userNameTxf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userNameTxf.delegate = self
        self.dbManager.delegate = self
        self.dbManager.readUserDataName()
    }
    
    @IBAction func tapChangeNameBtn(_ sender: UIButton) {
        guard let name = self.userNameTxf.text else { return }
        self.dbManager.updateUserDataName(name: name)
        var actionArray: [UIAlertAction] = []
        let notiAction = UIAlertAction(title: "확인",
                                       style: .default,
                                       handler: { _ in
            self.dismiss(animated: true, completion: nil)
        })
        actionArray.append(notiAction)
        SimpleAlert().makeAlert(vc: self,
                                title: "변경 완료",
                                message: "변경이 이루어졌습니다.",
                                actionArray: actionArray)
        
        
    }
    
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension ChangeNameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}


extension ChangeNameViewController: DatabaseCallDelegate {
    func successReadUserName(result: Bool, data: String) {
        if result {
            self.userNameTxf.text = data
        } else {
            self.userNameTxf.text = ""
        }
    }
//    func successUpdateUsername(_ result: Bool) {
//        if result {
//
//        }
//    }
}
