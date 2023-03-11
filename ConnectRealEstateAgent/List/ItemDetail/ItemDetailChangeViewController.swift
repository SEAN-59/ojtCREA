//
//  ItemDetailChangeViewController.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/03/09.
//

import UIKit

class ItemDetailChangeViewController: CREAViewController {
    var infoDict = Dictionary<String, Any>()
    var inveDict = Dictionary<String, Any>()
    var itemCd: String = ""
    var areaCd: String = ""
    var lat: Double = 0.0
    var lng: Double = 0.0
    
    private let dbManager = DatabaseManager()
    private let mapView = MapView()
    
    @IBOutlet weak var informationView: InformationView!
    @IBOutlet weak var investInputView: InvestInputView!
    @IBOutlet weak var includeMapView: NMFMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initDetailVC()
    }
    
    private func initDetailVC() {
        [
            self.informationView.layer,
            self.investInputView.layer,
            self.includeMapView.layer
        ].forEach({
            $0.borderWidth = 1
            $0.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
            $0.cornerRadius = 5
        })
        self.dbManager.delegate = self
        self.enterLabel()
        self.createMap(lat: self.lat, lng: self.lng)
    }
    
    private func createMap(lat:Double, lng:Double) {
        self.mapView.moveMap(map: self.includeMapView, lat: lat, lon: lng)
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: lat, lng: lng)
        marker.mapView = self.includeMapView
    }
    
    private func enterLabel() {
        self.informationView.addressLbl.text = "\(String(describing: infoDict["oldAddress"]!))"
        
        self.informationView.platAreaLbl.text = "\(String(describing:infoDict["platArea"]!)) ㎡"
        
        self.informationView.archAreaLbl.text = "\(String(describing: infoDict["archArea"]!)) ㎡"
        self.informationView.totAreaLbl.text =  "\(String(describing: infoDict["totArea"]!)) ㎡"
        self.informationView.vlRatLbl.text =  "\(String(describing: infoDict["vlRat"]!)) %"
        self.informationView.grndFlrLbl.text =  "\(String(describing: infoDict["grndFlrCnt"]!)) 층"
        self.informationView.ugrndFlrLbl.text =  "\(String(describing: infoDict["ugrndFlrCnt"]!)) 층"
        self.informationView.mainPurpsLbl.text =  "\(String(describing: infoDict["purpsNm"]!))"
        
        let useApr = self.dayChangeToString(day: String(describing: infoDict["useAprDay"]!))
        
        if useApr != "" {
            self.informationView.useAprLbl.text = "\(useApr)"
        } else {
            self.informationView.useAprLbl.text = "확인 되지 않음"
        }
        [
            self.investInputView.sellValueTxf,
            self.investInputView.depositValueTxf,
            self.investInputView.loanRatTxf,
            self.investInputView.loanValueTxf,
            self.investInputView.incomeValueTxf
        ].forEach{
            $0?.delegate = self
        }
        
        hideKeyboard()
        
        self.investInputView.sellValueTxf.text = "\(String(describing: self.inveDict["sell"]!))"
        self.investInputView.depositValueTxf.text = "\(String(describing: self.inveDict["deposit"]!))"
        self.investInputView.loanValueTxf.text = "\(String(describing: self.inveDict["deposit"]!))"
        self.investInputView.loanRatTxf.text = "\(String(describing: self.inveDict["loanRat"]!))"
        self.investInputView.incomeValueTxf.text = "\(String(describing: self.inveDict["income"]!))"
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
    
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapSaveBtn(_ sender: UIButton) {
        
        var actionArray: [UIAlertAction] = []
        
        let okAction = UIAlertAction(title: "저장",
                                     style: .destructive,
                                     handler: { _ in
            self.dbManager.updateItemData(itemCd: self.itemCd, data: self.makeSaveData())
        })
        
        let cancelAction = UIAlertAction(title: "취소",
                                         style: .default,
                                         handler: { _ in
            
        })
        actionArray.append(okAction)
        actionArray.append(cancelAction)
        
        SimpleAlert().makeAlert(vc: self, title: "변경", message: "정말로 변경하시겠습니까?", actionArray: actionArray)
        
        
    }
    
    private func makeSaveData() -> Dictionary<String, String> {
        guard let sell = self.investInputView.sellValueTxf.text else { return ["":""]}
        guard let deposit = self.investInputView.depositValueTxf.text else { return ["":""]}
        guard let income = self.investInputView.incomeValueTxf.text else { return ["":""] }
        guard let loan = self.investInputView.loanValueTxf.text else { return ["":""]}
        guard let loanRat = self.investInputView.loanRatTxf.text else { return ["":""]}
        
        return ["sell":sell, "deposit": deposit, "income": income, "loan":loan, "loanRat": loanRat]
    }
    
    
    
    @IBAction func tapDeleteBtn(_ sender: UIButton) {
        var actionArray: [UIAlertAction] = []
        
        let okAction = UIAlertAction(title: "삭제",
                                     style: .destructive,
                                     handler: { _ in
            
            
            /// 아이템 삭제시
            /// UserData/{UID}/Item/{AreaCd}/ 에서 해당 dataCd 찾아서 삭제
            /// AreaData/Item/ 에서 해당 dataCD 찾아서 삭제
            /// AreaData/Business/ 는 첫번 째 동작 후 해당 {AreaCd} 가 없을 경우 삭제
//            self.dbManager.deleteUserDataItem(areaCd: self.areaCd, itemCd: self.itemCd)
            self.dbManager.readUserData()
            
        })
        
        let cancelAction = UIAlertAction(title: "취소",
                                         style: .default,
                                         handler: { _ in
            
        })
        actionArray.append(okAction)
        actionArray.append(cancelAction)
        
        SimpleAlert().makeAlert(vc: self, title: "삭제", message: "정말로 삭제하시겠습니까?", actionArray: actionArray)
        
        
    }
    
}
extension ItemDetailChangeViewController: DatabaseCallDelegate {
    func successReadUser(result: Bool, data: [AnyHashable : Any]) {
        if result {
            guard let item = data["Item"] as? Dictionary<String, Any> else { return print("Item") }
            guard let array = item["\(self.areaCd)"] as? Array<Any> else { return }
            if array.count > 1 {
                for i in 0..<array.count {
                    if array[i] as? String == self.itemCd {
                        self.dbManager.deleteUserDataItem(isDel: false,
                                                          areaCd: self.areaCd,
                                                          itemCd: self.itemCd,
                                                          itemCnt: Int32(i))
                    }
                }
            } else {
                self.dbManager.deleteUserDataItem(isDel: true,
                                                  areaCd: self.areaCd,
                                                  itemCd: self.itemCd,
                                                  itemCnt: 0)
            }
        }
    }
    
    func successReadAreaItem(result: Bool, data: [Any]) {
        if result {
            guard let item = data as? [NSString] else { return }
            for i in 0 ..< item.count {
                if item[i] as String == self.itemCd{
                    self.dbManager.deleteAreaItem(Int32(i), areaCd: self.areaCd)
                }
            }
        }
    }
    
    func successDeleteData(_ result: Bool) {
        if result {
            guard let presentVC = self.presentingViewController else { return }
            self.dismiss(animated: true, completion: {
                presentVC.dismiss(animated: true, completion: nil)
            })
        }
    }
}

extension ItemDetailChangeViewController: UITextFieldDelegate {
    
}
