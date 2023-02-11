//
//  FirstVC.swift
//  ConnectRealEstateAgent
//
//  Created by Sean Kim on 2023/02/11.
//

import UIKit

class FirstVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func tappedLoginBtn(_ sender: UIButton) {
        let loginStoryboard = UIStoryboard.init(name: "LoginPage", bundle: nil)
        let simpleLoginVC = loginStoryboard.instantiateViewController(withIdentifier: "SimpleLoginVC")
        simpleLoginVC.modalPresentationStyle = .fullScreen
        self.present(simpleLoginVC, animated: true, completion: nil)
    }
}
