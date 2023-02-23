//
//  MapVC.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/02/13.
//

import UIKit
import NMapsMap

class MapVC: CREA_UIViewController {
    var userType: Bool = false
    
    private let mapView = MapView()
    private let dbManager = DatabaseManager()
    
    @IBOutlet weak var addItemBtn: UIButton!
    @IBOutlet weak var ItemListBtn: UIButton!
    
    @IBOutlet weak var mainMapView: NMFMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layout()
        self.dbManager.delegate = self
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
        self.dbManager.readAreaData()
    }
    
    @IBAction func tapItemListBtn(_ sender: UIButton) {
    }
    
    @IBAction func tapChatListBtn(_ sender: UIButton) {
    }
    
}


extension MapVC: SendAPIDataDelegate {
    func getGeocodingAPI(json data: [AnyHashable : Any]) {
        
        ///apu 는 잘 받는거 같은데 여기 안들온다??
        print(data)
    }
}
extension MapVC: DatabaseCallDelegate {
    func successReadArea(result: Bool, data: [Any]) {
        if result {
            for i in 0..<data.count {
                let areaNum: String = data[i] as! String
                
                var korea = Korea.init(selectCityNm: "", selectSggNm: "", selectEmdNm: "")
                korea.selectCityNm = korea.cityNm[Int(areaNum.prefix(2))!]
                korea.selectSggNm = korea.selectSgg()[Int(areaNum.prefix(4).suffix(2))!]
                korea.selectEmdNm = korea.selectEmd()[Int(areaNum.suffix(2))!]
                print(korea.selectCityNm)
                print(korea.selectSggNm)
                print(korea.selectEmdNm)
                /// 여기서 Gecode 호출 하면 되는것
                SearchAddress().checkGeocode("\(korea.selectCityNm) \(korea.selectSggNm) \(korea.selectEmdNm)")
            }
            /// 있음
            /// data = NSArray
            ///
        } else {
            /// 없음
        }
    }
}
