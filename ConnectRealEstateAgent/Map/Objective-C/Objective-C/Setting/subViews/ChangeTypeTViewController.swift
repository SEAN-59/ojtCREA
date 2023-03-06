//
//  ChangeTypeTViewController.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/03/06.
//

import UIKit

class ChangeTypeTViewController: CREAViewController {

    @IBOutlet weak var nameTxf: UITextField!
    @IBOutlet weak var numberTxf: UITextField!
    @IBOutlet weak var dateTxf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
