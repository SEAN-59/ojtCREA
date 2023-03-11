//
//  MapVC.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/13.
//

import UIKit
import NMapsMap
//import GoogleSignInSwift

class MapVC: CREAViewController {
    /// 일반
    var userType: Bool = false
    
    private let mapView = MapView()
    private let dbManager = DatabaseManager()
    private let searchAPI = SearchAddress()

    @IBOutlet weak var addItemBtn: UIButton!
    @IBOutlet weak var ItemListBtn: UIButton!
    
    @IBOutlet weak var mainMapView: NMFMapView!
    @IBOutlet weak var backView: UIButton!
    @IBOutlet weak var addrSearchView: AddrSearchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dbManager.delegate = self
        self.searchAPI.delegate = self
        self.addrSearchView.delegate = self
        self.layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadMap()
    }
    
    private func loadMap() {
        if self.userType {
            self.dbManager.readUserItemKeyData()
        } else {
            self.dbManager.readAreaData()
        }
    }
    
    func layout() {
        self.addrSearchView.layer.borderColor = UIColor.init(named: "DeepBlue")?.cgColor
        self.addrSearchView.layer.borderWidth = 1.0
        self.addrSearchView.layer.cornerRadius = 5.0
        
        self.mainMapView.layer.borderColor = UIColor.init(named: "DeepBlue")?.cgColor
        self.mainMapView.layer.borderWidth = 1.0
        self.mainMapView.layer.cornerRadius = 5.0
        
        if self.userType {
            /// add 버튼 색상 입힘
            self.addItemBtn.backgroundColor = UIColor.init(named: "DeepBlue")?.withAlphaComponent(0.4)
            self.addItemBtn.layer.borderWidth = 1.5
            self.addItemBtn.layer.borderColor = UIColor.init(named: "DeepBlue")?.cgColor
            self.addItemBtn.layer.cornerRadius = self.addItemBtn.frame.width/2
            
            /// 요소 보이게 하기
            self.ItemListBtn.isHidden = false
            self.addItemBtn.isHidden = false
        } else {
            /// 요소 감추기
            self.ItemListBtn.isHidden = true
            self.addItemBtn.isHidden = true
            
        }
        
        self.mapView.userType = self.userType
        self.mapView.moveToNowLocation(map: self.mainMapView)
        
        
    }
}
private extension MapVC {

    @IBAction func tapSearchAddressBtn(_ sender: UIButton) {
        self.addrSearchView.isHidden = false
        self.backView.isHidden = false
    }
    @IBAction func tapBackViewBtn(_ sender: UIButton) {
        self.addrSearchView.isHidden = true
        self.backView.isHidden = true
    }
    
    @IBAction func tapNotiBtn(_ sender: UIButton) {
    }
    
    @IBAction func tapSettingBtn(_ sender: UIButton) {
        let settingVC = SettingViewController.init(nibName: "SettingViewController",
                                                   bundle: nil)
        settingVC.modalPresentationStyle = UIModalPresentationStyle.automatic
        settingVC.userType = self.userType
        self.present(settingVC, animated: true, completion: {
            
        })

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
        let listVC = ItemListViewController.init(nibName: "ItemListViewController", bundle: nil)
        guard let presentVC = self.presentingViewController else { return }
        
        listVC.modalPresentationStyle = .fullScreen
        self.dismiss(animated: false, completion: {
            listVC.userType = self.userType
            presentVC.present(listVC, animated: false, completion: nil)
        })
    }
    
    @IBAction func tapChatListBtn(_ sender: UIButton) {
        guard let presentVC = self.presentingViewController else { return }
        print(presentVC)
        presentVC.dismiss(animated: false, completion: nil)
//
//        detailVC.modalPresentationStyle = .fullScreen
//        self.present(detailVC, animated: true, completion: nil)
        
//        self.dismiss(animated: false, completion: {
//
//            presentVC.present(listVC, animated: false, completion: nil)
//        })
        
    }
    
}


extension MapVC: SendAPIDataDelegate {
    func getGeocodingAPI(geo data: [AnyHashable : Any], addrcd addrCd: String, address: String) {
        guard let lat = data["lat"] as? String else { return print("Convert Error lat") }
        guard let lon = data["lon"] as? String else { return print("Convert Error lon")}
        self.mapView.makeMarker(view: self ,map: self.mainMapView, lat: Double(lat)!, lon: Double(lon)!, addrCd:addrCd, address: address)
        
        
    }
}
extension MapVC: DatabaseCallDelegate {
    func successReadUserItem(result: Bool, data: [Any]) {
        if result {
            self.businessTypeMarker(data: data)
        }
    }
    func successReadArea(result: Bool, data: [Any]) {
        if result {
            self.personalTypeMarker(data: data)
        }
    }
    
    private func personalTypeMarker(data: [Any]) {
        for i in 0..<data.count {
            let areaNum: String = data[i] as! String
            
            var korea = Korea.init(selectCityNm: "", selectSggNm: "", selectEmdNm: "")
            korea.selectCityNm = korea.cityNm[Int(areaNum.prefix(2))!]
            korea.selectSggNm = korea.selectSgg()[Int(areaNum.prefix(4).suffix(2))!]
            korea.selectEmdNm = korea.selectEmd()[Int(areaNum.suffix(2))!]
            /// 여기서 Gecode 호출 하면 되는것
            self.searchAPI.checkGeocode("\(korea.selectCityNm) \(korea.selectSggNm) \(korea.selectEmdNm)",addrCd: areaNum)
        }
    }
    
    private func businessTypeMarker(data: [Any]) {
        for i in 0..<data.count {
            let areaNum: String = data[i] as! String
            
            var korea = Korea.init(selectCityNm: "", selectSggNm: "", selectEmdNm: "")
            korea.selectCityNm = korea.cityNm[Int(areaNum.prefix(2))!]
            korea.selectSggNm = korea.selectSgg()[Int(areaNum.prefix(4).suffix(2))!]
            korea.selectEmdNm = korea.selectEmd()[Int(areaNum.suffix(2))!]
            /// 여기서 Gecode 호출 하면 되는것
            self.searchAPI.checkGeocode("\(korea.selectCityNm) \(korea.selectSggNm) \(korea.selectEmdNm)", addrCd: areaNum)
        }
        
    }
    
    func successUpdateUserType(_ result: Bool) {
        self.userType = result
        self.layout()
    }
}
extension MapVC: MoveMapDelegate {
    func getSearchGeo(lat: Double, lon: Double) {
        self.backView.isHidden = true
        self.addrSearchView.isHidden = true
        self.mapView.moveMap(map: mainMapView, lat: lat, lon: lon)
    }

}
