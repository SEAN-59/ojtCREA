//
//  SimpleAlert.swift
//  ConnectRealEstateAgent
//
//  Created by Sean Kim on 2023/02/12.
//

import UIKit


class SimpleAlert {
    func makeAlert (vc: UIViewController, title: String, message: String, actionArray: [UIAlertAction]) {
        var alert = UIAlertController()
        alert = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .alert)
        actionArray.forEach{
            alert.addAction($0)
        }
        vc.present(alert, animated: true)
        
    }
    
}
