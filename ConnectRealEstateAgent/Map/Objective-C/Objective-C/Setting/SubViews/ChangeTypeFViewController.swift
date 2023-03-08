//
//  ChangeTypeFViewController.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/03/06.
//

import UIKit

class ChangeTypeFViewController: CREAViewController {
    let dbManager = DatabaseManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapChangeTypeFBtn(_ sender: UIButton) {
        // 여기는 무조건 TRUE > FALSE
        self.dbManager.updateUserDataType(type: "고객")
        guard let presentingVC = self.presentingViewController else { return }
        guard let p_presentingVC = presentingVC.presentingViewController as? MapVC else { return }
        
        p_presentingVC.userType = false
        p_presentingVC.layout()
        self.dismiss(animated: true, completion: {
            presentingVC.dismiss(animated: true, completion: nil)
        })
        
        
        
    }

}

