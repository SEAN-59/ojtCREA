//
//  CREAViewController.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/23.
//

import UIKit

class CREAViewController: UIViewController {
    
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
