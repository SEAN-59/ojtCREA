//
//  SettingViewController.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/03/06.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
import KakaoSDKAuth

class SettingViewController: CREAViewController {
    private var userType: Bool = false
    
    @IBOutlet weak var changeTypeBtn: UIButton!
    @IBOutlet weak var changeSomethingBtn: UIButton!
    @IBOutlet weak var changeNameBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initVC()
    }
    func getUserType(type: Bool) { self.userType = type }
    
    func initVC() {
        if self.userType {
            self.changeSomethingBtn.setTitle("명함 관리", for: .application)
            self.changeSomethingBtn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        } else {
            self.changeSomethingBtn.setTitle("조건 변경", for: .application)
            self.changeSomethingBtn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        }
        
    }
}

extension SettingViewController {
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapChangeTypeBtn(_ sender: UIButton) {
        
        
        
        
        if self.userType {
            // 비즈니스 -> 일반
            let nextVC = ChangeTypeFViewController()
            if let sheet = nextVC.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.delegate = self
            }
            self.present(nextVC, animated: true, completion: nil)
        } else {
            // 일반 -> 비즈니스
            let nextVC = ChangeTypeTViewController()
            if let sheet = nextVC.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.delegate = self
            }
            self.present(nextVC, animated: true, completion: nil)
        }
        
        
        
        
    }
    
    @IBAction func tapSomethingBtn(_ sender: UIButton) {
    }
    
    @IBAction func tapChangeNameBtn(_ sender: UIButton) {
    }
    
    @IBAction func tapSignOutBtn(_ sender: UIButton) {
        if let signOut = try? Auth.auth().signOut() {
            if signOut == () {
                guard let presentingVC = self.presentingViewController else {return}
                self.dismiss(animated: true, completion: {
                    presentingVC.dismiss(animated: true, completion: nil)
                })
            }
        }
    }
    
    @IBAction func tapDeleteUserBtn(_ sender: UIButton) {
    }
}

extension SettingViewController: UISheetPresentationControllerDelegate {
    
}
