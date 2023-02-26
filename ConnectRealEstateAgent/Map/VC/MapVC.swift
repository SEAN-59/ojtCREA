//
//  MapVC.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/13.
//

import UIKit
import NMapsMap

class MapVC: CREAViewController {
    /// 일반
    var userType: Bool = false
    
    private let mapView = MapView()
    private let dbManager = DatabaseManager()
    private let searchAPI = SearchAddress()
    
    
    @IBOutlet weak var addItemBtn: UIButton!
    @IBOutlet weak var ItemListBtn: UIButton!
    
    @IBOutlet weak var mainMapView: NMFMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layout()
        self.dbManager.delegate = self
        self.searchAPI.delegate = self
        self.mapView.userType = self.userType
        self.mapView.moveToNowLocation(map: self.mainMapView)
        
    }
    
    private func layout() {
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
//        [self.mapView moveTest(self.mainMapView)]
//        self.mapView.moveTest(self.mainMapView)
        if self.userType {
            self.dbManager.readUserItemKeyData()
        } else {
            self.dbManager.readAreaData()
        }
        
    }
    
    @IBAction func tapItemListBtn(_ sender: UIButton) {
    }
    
    @IBAction func tapChatListBtn(_ sender: UIButton) {
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
}
