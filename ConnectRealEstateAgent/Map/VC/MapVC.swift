//
//  MapVC.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/13.
//

import UIKit
import NMapsMap

class MapVC: UIViewController {

    @IBOutlet weak var addItemBtn: UIButton!
    
    @IBOutlet weak var mainMapView: NMFMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layout()
        
    }
    
    private func layout() {
        self.addItemBtn.backgroundColor = UIColor.init(named: "DeepBlue")?.withAlphaComponent(0.4)
        self.addItemBtn.layer.borderWidth = 1.5
        self.addItemBtn.layer.borderColor = UIColor.init(named: "DeepBlue")?.cgColor
        self.addItemBtn.layer.cornerRadius = self.addItemBtn.frame.width/2
    }
}
private extension MapVC {

    @IBAction func tapSearchAddressBtn(_ sender: UIButton) {
    }
    
    @IBAction func tapNotiBtn(_ sender: UIButton) {
    }
    
    @IBAction func tapSettingBtn(_ sender: UIButton) {
    }
    
    @IBAction func tapAddItemBtn(_ sender: UIButton) {
    }
    
    @IBAction func tapHomeBtn(_ sender: UIButton) {
    }
    
    @IBAction func tapItemListBtn(_ sender: UIButton) {
    }
    
    @IBAction func tapChatListBtn(_ sender: UIButton) {
    }
    
}
