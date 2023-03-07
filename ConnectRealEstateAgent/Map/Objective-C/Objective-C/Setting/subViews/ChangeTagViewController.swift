//
//  ChangeTagViewController.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/03/07.
//

import UIKit

class ChangeTagViewController: CREAViewController {
    let dbManager = DatabaseManager()
    
    @IBOutlet weak var businessNameTxf: UITextField!
    @IBOutlet weak var businessAddrTxf: UITextField!
    
    @IBOutlet weak var realNameLbl: UILabel!
    @IBOutlet weak var businessNumLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dbManager.delegate = self
        self.businessAddrTxf.delegate = self
        self.businessNameTxf.delegate = self
        self.dbManager.readUserData()

    }
    
    @IBAction func tapChangeTagBtn(_ sender: UIButton) {
        if self.businessNameTxf.text == "" || self.businessAddrTxf.text == "" {
            
            var actionArray: [UIAlertAction] = []
            let notiAction = UIAlertAction(title: "확인",
                                           style: .default,
                                           handler: {_ in
                return
            })
            actionArray.append(notiAction)
            SimpleAlert().makeAlert(vc: self,
                                    title:  "에러",
                                    message: "비어있는 칸이 존재합니다.",
                                    actionArray: actionArray)
        } else {
            guard let addr = self.businessAddrTxf.text else {return}
            guard let name = self.businessNameTxf.text else {return}
            self.dbManager.updateUserDataTag(addr: addr, name: name)
            var actionArray: [UIAlertAction] = []
            let notiAction = UIAlertAction(title: "확인",
                                           style: .default,
                                           handler: { _ in
                self.dismiss(animated: true, completion: nil)
            })
            actionArray.append(notiAction)
            SimpleAlert().makeAlert(vc: self,
                                    title: "완료",
                                    message: "변경이 이루어졌습니다.",
                                    actionArray: actionArray)
        }
        
    }
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension ChangeTagViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}

extension ChangeTagViewController: DatabaseCallDelegate {
    func successReadUser(result: Bool, data: [AnyHashable : Any]) {
        if result {
            guard let realName = data["realName"] as? String else { return print("real") }
            guard let businessNum = data["businessNum"] as? String else { return print("buNum")}
            self.realNameLbl.text = realName
            self.businessNumLbl.text = businessNum
            
            if let businessAddr = data["businessAddr"] as? String {
                self.businessAddrTxf.text = businessAddr
            }
            if let businessName = data["businessName"] as? String {
                self.businessNameTxf.text = businessName
            }
        }
    }
}
