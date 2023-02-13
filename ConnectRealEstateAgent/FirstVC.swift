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
        
        let storyBoard = UIStoryboard.init(name: "LoginPage", bundle: nil)
        
        guard let nextVC =  storyBoard.instantiateViewController(withIdentifier: "SimpleLoginVC") as? SimpleLoginVC else { return }
        
        
        nextVC.modalPresentationStyle = .fullScreen
        
        
        self.present(nextVC, animated: true, completion: {
            guard let presentVC = self.presentingViewController else { return }
            presentVC.dismiss(animated: false, completion: nil)
        })
        
    }
}
