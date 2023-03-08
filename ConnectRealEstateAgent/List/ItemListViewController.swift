//
//  ItemListViewController.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/03/07.
//

import UIKit
import SwiftUI

class ItemListViewController: CREAViewController {
    var userType: Bool = false
    
    private var cellCount: Int = 0
    private let identifier = "ItemListTableViewCell"
    
    private var dataDict = [String:Dictionary<String, Any>]()
    private var sumItemArray = [String]()
    
    private let dbManager = DatabaseManager()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addrTitleLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dbManager.delegate = self
        self.tableViewInit()
        self.layout()
        self.loadData()
    }
    
    private func layout() {
    }
    
    private func loadData() {
        self.dbManager.readUserData()
    }
    
    private func tableViewInit() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        let nib = UINib(nibName: "ItemListTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: self.identifier)
    }
    
}

extension ItemListViewController {
    
    @IBAction func tapSearchAddrBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func tapGoHomeBtn(_ sender: UIButton) {
        let storyBoard = UIStoryboard.init(name: "MapPage", bundle: nil)
        guard let nextVC =  storyBoard.instantiateViewController(withIdentifier: "MapVC") as? MapVC else { return }
        nextVC.modalPresentationStyle = .fullScreen
        guard let presentVC = self.presentingViewController else { return }
        
        self.dismiss(animated: false, completion: {
            nextVC.userType = self.userType
            presentVC.present(nextVC, animated: false, completion: nil)
        })
    }
    
    @IBAction func tapGoChatBtn(_ sender: UIButton) {
        
    }
    
}


extension ItemListViewController: DatabaseCallDelegate {
    func successReadUser(result: Bool, data: [AnyHashable : Any]) {
        if result {
            guard let item = data["Item"] as? Dictionary<String, Any> else { return print("Item") }
            
            
            
            for key in item.keys {
                guard let itemArray = item[key] as? Array<String> else { return print("Array")}
                self.sumItemArray += itemArray
            }
            
            self.cellCount = self.sumItemArray.count
            
            for value in self.sumItemArray {
                self.dbManager.readItemData(itemCd: value)
            }
        }
    }
    
    func successReadItem(result: Bool, data: [AnyHashable : Any], code: String) {
        if result {
            
            guard let data = data as? Dictionary<String, Any> else {return print("data")}
            self.dataDict[code] = data
            
            if dataDict.count == self.cellCount {
                self.tableView.reloadData()
            }
            
        }
    }
}

extension ItemListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as! ItemListTableViewCell
        
        let indexData = self.dataDict[self.sumItemArray[indexPath.item]] ?? Dictionary<String, Any>()
        
        guard let invest = indexData["Invest"] as? Dictionary<String, Double> else {
            print("Invest")
            return UITableViewCell()
        }
        
        guard let information = indexData["Information"] as? Dictionary<String, Any> else {
            print("Information")
            return UITableViewCell()
        }
        let income: Double = invest["income"]!
        let sell: Double = invest["sell"]!
        let loan: Double = invest["loan"]!
        let deposit: Double = invest["deposit"]!
        
        let rat: Double = self.calculateRat(income: income, sell: sell, loan: loan, deposit: deposit)
        
        cell.initCellLbl(information["oldAddress"] as! String,
                         sell: "\(sell)",
                         income: "\(income)",
                         rat: "\(rat)")
        
        return cell
    }
    
    private func calculateRat(income: Double, sell: Double, loan: Double, deposit: Double) -> Double {
        let temp: Int = Int(((income * 12) / (sell - deposit - loan)) * 10000)
        let result: Double = Double(temp) / 100

        return result
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVC = ItemDetailViewController.init(nibName: "ItemDetailViewController", bundle: nil)
        
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.dataDict = self.dataDict[self.sumItemArray[indexPath.item]] ?? Dictionary<String, Any>()
        self.present(detailVC, animated: true, completion: nil)
    }
    
}
