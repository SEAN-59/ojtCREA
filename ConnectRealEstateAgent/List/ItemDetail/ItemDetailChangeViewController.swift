//
//  ItemDetailChangeViewController.swift
//  ConnectRealEstateAgent
//
//  Created by TAnine on 2023/03/09.
//

import UIKit

class ItemDetailChangeViewController: CREAViewController {
    var infoDict = Dictionary<String, Any>()
    var itemCd: String = ""
    var areaCd: String = ""
    
    private let dbManager = DatabaseManager()
    
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
            
            guard let sell = self.investInputView.sellValueTxf.text else { return }
            guard let deposit = self.investInputView.depositValueTxf.text else { return }
            guard let income = self.investInputView.incomeValueTxf.text else { return }
            guard let loan = self.investInputView.loanValueTxf.text else { return }
            guard let loanRat = self.investInputView.loanRatTxf.text else { return }
            
            
            
//            self.dbManager.updateItemData(itemCd: self.itemCd, data: <#T##[AnyHashable : Any]#>)
            /// 아이템 변경시
            /// 아이템 변경 시 Invest 부분만 따로 업데이트를 해주면 됨
            
        })
        
        let cancelAction = UIAlertAction(title: "취소",
                                         style: .default,
                                         handler: { _ in
            
        })
        actionArray.append(okAction)
        actionArray.append(cancelAction)
        
        SimpleAlert().makeAlert(vc: self, title: "변경", message: "정말로 변경하시겠습니까?", actionArray: actionArray)
        
        
    }
    
    @IBAction func tapDelegateBtn(_ sender: UIButton) {
        var actionArray: [UIAlertAction] = []
        
        let okAction = UIAlertAction(title: "삭제",
                                     style: .destructive,
                                     handler: { _ in
            
            /// 아이템 삭제시
            /// UserData/{UID}/Item/{AreaCd}/ 에서 해당 dataCd 찾아서 삭제
            /// AreaData/Item/ 에서 해당 dataCD 찾아서 삭제
            /// AreaData/Business/ 는 첫번 째 동작 후 해당 {AreaCd} 가 없을 경우 삭제
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
    
}
