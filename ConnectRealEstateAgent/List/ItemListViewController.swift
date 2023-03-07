//
//  ItemListViewController.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/03/07.
//

import UIKit

class ItemListViewController: UIViewController {

    @IBOutlet weak var includeTableView: UIView!
    @IBOutlet weak var addrTitleLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layout()
    }
    
    private func layout() {
//        let tableView = UIView.init(nibName: "It", bundle: nil)
        
//        self.includeTableView.addSubview(tableView)
    }
}

extension ItemListViewController {
    
    @IBAction func tapSearchAddrBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func tapGoHomeBtn(_ sender: UIButton) {
        let mapVC = MapVC.init(nibName: "MapVC", bundle: nil)
        guard let presentVC = self.presentingViewController else { return }
        mapVC.modalPresentationStyle = .fullScreen
        self.present(mapVC, animated: true, completion: {
            presentVC.dismiss(animated: false, completion: nil)
        })
    }
    
    @IBAction func tapGoChatBtn(_ sender: UIButton) {
        
    }
    
}
