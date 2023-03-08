//
//  ItemDetailViewController.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/03/08.
//

import UIKit
import NMapsMap

class ItemDetailViewController: CREAViewController {
    
    private let mapView = MapView()
    private let searchAPI = SearchAddress()
    
    
    @IBOutlet weak var informationView: InformationView!
    @IBOutlet weak var investInfoView: InvestInfoView!
    
    var dataDict = Dictionary<String, Any>()
    
    
    
    @IBOutlet weak var includeMapView: NMFMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initDetailVC()
        
    }
}

extension ItemDetailViewController {
    private func initDetailVC() {
        guard let information = dataDict["Information"] as? Dictionary<String, Any> else { return print("initDetailVC_Information") }

        guard let invest = dataDict["Invest"] as? Dictionary<String, Any> else { return print("initDetailVC_Invest") }
        
        self.searchAPI.delegate = self
        self.searchAPI.checkGeocode(information["oldAddress"] as! String, addrCd: "00")
        
        self.enterTheLabel(info: information, invest: invest)
    }
    
    private func createMap(lat:Double, lng:Double) {
        self.mapView.moveMap(map: self.includeMapView, lat: lat, lon: lng)
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: lat, lng: lng)
        marker.mapView = self.includeMapView
    }
    
    private func enterTheLabel(info: Dictionary<String, Any>, invest: Dictionary<String, Any>) {
        self.informationView.addressLbl.text = info["oldAddress"] as! String
//        self.informationView.platAreaLbl.text = info["platArea"] as! String
//        self.informationView.archAreaLbl.text = info["archArea"] as! String
//        self.informationView.totAreaLbl.text = info["totArea"] as! String
//        self.informationView.vlRatLbl.text = info["vlRat"] as! String
//        self.informationView.grndFlrLbl.text = info["grndFlrCnt"] as! String
//        self.informationView.ugrndFlrLbl.text = info["ugrndFlrCnt"] as! String
//        self.informationView.useAprLbl.text = info["useAprDay"] as! String
//        self.informationView.mainPurpsLbl.text = info["purpsNm"] as! String
        
    }
}

extension ItemDetailViewController {
    
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapChangeBtn(_ sender: UIButton) {
        
    }
    
}

extension ItemDetailViewController: SendAPIDataDelegate {
    func getGeocodingAPI(geo data: [AnyHashable : Any], addrcd addrCd: String, address: String) {
        guard let lat = data["lat"] as? String else { return print("Convert Error lat") }
        guard let lng = data["lon"] as? String else { return print("Convert Error lon")}
        self.createMap(lat: Double(lat)!, lng: Double(lng)!)
    }
}
