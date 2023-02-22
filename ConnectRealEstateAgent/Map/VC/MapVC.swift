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
    
    @IBOutlet weak var mainMapView: MapView!
    
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
        
        let storyBoard = UIStoryboard.init(name: "ItemPage", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "AddItemVC")
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
    @IBAction func tapHomeBtn(_ sender: UIButton) {
    }
    
    @IBAction func tapItemListBtn(_ sender: UIButton) {
    }
    
    @IBAction func tapChatListBtn(_ sender: UIButton) {
    }
    
}
