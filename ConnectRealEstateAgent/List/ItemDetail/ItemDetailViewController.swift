//
//  ItemDetailViewController.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/03/08.
//

import UIKit
import NMapsMap

class ItemDetailViewController: CREAViewController {
    var dataDict = Dictionary<String, Any>()
    var dataCd: String = ""
    
    private let mapView = MapView()
    private let searchAPI = SearchAddress()
    
    
    @IBOutlet weak var informationView: InformationView!
    @IBOutlet weak var investInfoView: InvestInfoView!
    @IBOutlet weak var includeMapView: NMFMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initDetailVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.drawView()
    }
}

extension ItemDetailViewController {
    private func initDetailVC() {
        [
            self.informationView.layer,
            self.investInfoView.layer,
            self.includeMapView.layer
        ].forEach({
            $0.borderWidth = 1
            $0.borderColor = UIColor.deepBlueColor!.withAlphaComponent(0.4).cgColor
            $0.cornerRadius = 5
        })
    }
    private func drawView(){
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
        self.informationView.addressLbl.text = "\(String(describing: info["oldAddress"]!))"
        self.informationView.platAreaLbl.text = "\(String(describing:info["platArea"]!)) ㎡"
        
        self.informationView.archAreaLbl.text = "\(String(describing: info["archArea"]!)) ㎡"
        self.informationView.totAreaLbl.text =  "\(String(describing: info["totArea"]!)) ㎡"
        self.informationView.vlRatLbl.text =  "\(String(describing: info["vlRat"]!)) %"
        self.informationView.grndFlrLbl.text =  "\(String(describing: info["grndFlrCnt"]!)) 층"
        self.informationView.ugrndFlrLbl.text =  "\(String(describing: info["ugrndFlrCnt"]!)) 층"
        self.informationView.mainPurpsLbl.text =  "\(String(describing: info["purpsNm"]!))"
        
        let useApr = self.dayChangeToString(day: String(describing: info["useAprDay"]!))
        
        if useApr != "" {
            self.informationView.useAprLbl.text = "\(useApr)"
        } else {
            self.informationView.useAprLbl.text = "확인 되지 않음"
        }
        
        self.investInfoView.sellLbl.text = "\(String(describing: invest["sell"]!))"
        self.investInfoView.depositLbl.text = "\(String(describing: invest["deposit"]!))"
        self.investInfoView.loanLbl.text = "\(String(describing: invest["loan"]!))"
        
        let monthInterest: Int = { () -> Int in
            let loan = invest["loan"] as! Double
            let loanRat = invest["loanRat"] as! Double
            let doubleResult = (loan * (loanRat/100)) / 12
            return Int(ceil(doubleResult))
        }()
        self.investInfoView.interestLbl.text = "\(String(describing: monthInterest))"
        
        self.investInfoView.monthIncomeLbl.text = "\(String(describing: invest["income"]!))"
        
        let yearIncome: Int = { () -> Int in
            let income = invest["income"] as! Double
            return Int(ceil(income*12))
        }()
        self.investInfoView.yearIncomeLbl.text = "\(String(describing: yearIncome))"
        
        let realInvest: Int = { () -> Int in
            let sell = invest["sell"] as! Double
            let deposit = invest["deposit"] as! Double
            let loan = invest["loan"] as! Double
            return Int(ceil(sell - deposit - loan))
        }()
        self.investInfoView.realInvestLbl.text = "\(String(describing: realInvest))"
        
        let investRat: Double = { () -> Double in
            let investRat = Int((Double(yearIncome) / Double(realInvest)) * 1000)
            print(investRat)
            return Double(investRat) / 10
        }()
        self.investInfoView.investRatLbl.text = "\(String(describing: investRat))"
    }
    
    private func dayChangeToString(day: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        
        formatter.dateFormat = "yyyyMMdd"
        guard let stringToDate = formatter.date(from: day) else { return "" }
        
        formatter.dateFormat = "yyyy년 MM월 dd일"
        let dateToString = formatter.string(from: stringToDate)
        
        return dateToString
    }
}

extension ItemDetailViewController {
    
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapChangeBtn(_ sender: UIButton) {
        let changeVC = ItemDetailChangeViewController.init(nibName: "ItemDetailChangeViewController", bundle: nil)
        
        guard let information = dataDict["Information"] as? Dictionary<String, Any> else { return print("Information") }
        guard let areaCd = dataDict["areaCd"] as? String else { return print("areaCd") }
        
        changeVC.infoDict = information
        changeVC.areaCd = areaCd
        changeVC.itemCd = self.dataCd
    
        self.present(changeVC, animated: true, completion: nil)
        
//        guard let presentVC = self.presentingViewController else { return }
//
//        self.dismiss(animated: false, completion: {
//            presentVC.present(changeVC, animated: true, completion: nil)
//        })
    }
    
}

extension ItemDetailViewController: SendAPIDataDelegate {
    func getGeocodingAPI(geo data: [AnyHashable : Any], addrcd addrCd: String, address: String) {
        guard let lat = data["lat"] as? String else { return print("Convert Error lat") }
        guard let lng = data["lon"] as? String else { return print("Convert Error lon")}
        self.createMap(lat: Double(lat)!, lng: Double(lng)!)
    }
}
