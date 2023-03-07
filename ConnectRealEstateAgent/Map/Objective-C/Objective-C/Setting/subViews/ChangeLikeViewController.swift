//
//  ChangeLikeViewController.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/03/07.
//

import UIKit
import AVFoundation

class ChangeLikeViewController: CREAViewController {
    let dbmanager = DatabaseManager()
    
    @IBOutlet weak var sellTxf: UITextField!
    @IBOutlet weak var incomeTxf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sellTxf.delegate = self
        self.incomeTxf.delegate = self
        self.dbmanager.delegate = self
        self.dbmanager.readUserData()
    }
    
    


    @IBAction func tapChangeLikeBtn(_ sender: UIButton) {
        guard let income = self.incomeTxf.text else { return }
        guard let sell = self.sellTxf.text else { return }
        self.dbmanager.updateUserDataLike(income: income, sell: sell)
        
        var actionArray: [UIAlertAction] = []
        let notiAction = UIAlertAction(title: "변경",
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
    
}

extension ChangeLikeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}

extension ChangeLikeViewController: DatabaseCallDelegate {
    func successReadUser(result: Bool, data: [AnyHashable : Any]) {
        if result {
            guard let like = data["Like"] as? Dictionary<String, Any> else { return print("Return")}
            
            if like["income"] == nil {
                self.incomeTxf.text = ""
            } else {
                self.incomeTxf.text = (like["income"] as! String)
                
            }
            
            if like["sell"] == nil {
                self.sellTxf.text = ""
            } else { self.sellTxf.text = (like["sell"] as! String)
                
            }
        }
    }
}

