//
//  MainViewController.swift
//  Covid19
//
//  Created by SeongJae on 2021/11/14.
//  Copyright © 2021 comsoft. All rights reserved.
//

import UIKit
import SafariServices

enum TagType {
    case createDt
    case deathCnt
    case defCnt
    case gubun
    case gubunCn
    case gubunEn
    case incDec
    case isolClearCnt
    case isolIngCnt
    case localOccCnt
    case overFlowCnt
    case qurRate
    case seq
    case stdDay
    case none
}

struct item {
    var createDt: String
    var deathCnt: String
    var defCnt: String
    var gubun: String
    var gubunCn: String
    var gubunEn: String
    var incDec: String
    var isolClearCnt: String
    var isolIngCnt: String
    var localOccCnt: String
    var overFlowCnt: String
    var qurRate: String
    var seq: String
    var stdDay: String
    
    init() {
        createDt = ""
        deathCnt = ""
        defCnt = ""
        gubun = ""
        gubunCn = ""
        gubunEn = ""
        incDec = ""
        isolClearCnt = ""
        isolIngCnt = ""
        localOccCnt = ""
        overFlowCnt = ""
        qurRate = ""
        seq = ""
        stdDay = ""
    }
    
}

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, XMLParserDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = [[String]](repeating: Array (repeating: "", count: 5), count: 17)
    var isLock = false
    var tagType : TagType = .none
    var tempModel : item?
    var books: [item] = []
    var now = getDate(Date())
    var hour = getTime(Date())
    var now1 = getDate(Calendar.current.date(byAdding: .day, value: -1, to: Date())!)
    var day:String = ""
    
    
    
    @IBOutlet weak var defCntt: UILabel!
    @IBOutlet weak var deathCntt: UILabel!
    @IBOutlet weak var isolIngCntt: UILabel!
    @IBOutlet weak var incDecc: UILabel!
    @IBOutlet weak var localOccCntt: UILabel!
    @IBOutlet weak var overFlowCntt: UILabel!
    @IBOutlet weak var refreshRecord: UILabel!
    
    func getXMLData() {
        if Int(hour)! < 10{
            day = now1
        }else{
            day = now
        }
        
        let yourKey = "7LikYEB1dbb6OiFu5QjaZah2TeG1LckLCXn7mV7juBiP95O%2BNVwOvmkkopn9Nr%2B0GEuUpzP0JaTHZ2l%2B%2F2dCRQ%3D%3D" // 공공 데이터 포털에서 발급받은 개인 키
        let url = URL(string: "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19SidoInfStateJson?serviceKey=\(yourKey)&pageNo=1&numOfRows=10&startCreateDt=\(day)&endCreateDt=\(day)")
        var parser : XMLParser
        parser = XMLParser(contentsOf: url!)!
        parser.delegate = self
        parser.parse()
        print("XML Data Load")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 30;
        // Do any additional setup after loading the view.
        getXMLData()
    }
    
    /// 필수 함수 구현
    // 한 섹션(구분)에 몇 개의 셀을 표시할지
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count // 페이징이 필요없는 기능이기에 데이터의 갯수만큼 딱 맞게 셀 표시
    }
    
    // 특정 row에 표시할 cell 리턴
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 정의한 cell 만들기
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let numF = NumberFormatter()
        numF.numberStyle = .decimal
        
        // Cell Label의 내용 지정
        cell.area.text = data[indexPath.row][0]
        cell.coronic.text = data[indexPath.row][1]
        cell.treatment.text = data[indexPath.row][2]
        cell.dead.text = data[indexPath.row][3]
        cell.rate.text = data[indexPath.row][4]
        // Cell Lable의 폰트 설정(볼드체)
        cell.area.font = UIFont.boldSystemFont(ofSize: 11)
        cell.coronic.font = UIFont.boldSystemFont(ofSize: 11)
        cell.treatment.font = UIFont.boldSystemFont(ofSize: 11)
        cell.dead.font = UIFont.boldSystemFont(ofSize: 11)
        cell.rate.font = UIFont.boldSystemFont(ofSize: 11)
        
        // 생성한 Cell 리턴
        return cell
    }
    
    @IBAction func vacCineStatus(_ sender: UIButton) {
        guard let Url = URL(string: "https://ncv.kdca.go.kr")
                // 코로나19 예방접종
        else { return }
        
        let safariViewController = SFSafariViewController(url: Url)
        safariViewController.delegate = self as? SFSafariViewControllerDelegate
        safariViewController.modalPresentationStyle = .automatic
        self.present(safariViewController, animated: true, completion: nil)
    }
    @IBAction func homeTownStatus(_ sender: UIButton) {
        guard let Url = URL(string: "http://ncov.mohw.go.kr/bdBoardList_Real.do?brdId=1&brdGubun=13&ncvContSeq=&contSeq=&board_id=&gubun=")
                // 시도별 확진현황
        else { return }
        
        let safariViewController = SFSafariViewController(url: Url)
        safariViewController.delegate = self as? SFSafariViewControllerDelegate
        safariViewController.modalPresentationStyle = .automatic
        self.present(safariViewController, animated: true, completion: nil)
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        // 태그의 시작
        
        if elementName == "item" {
            isLock = true
            tempModel = item.init()
        } else if elementName == "createDt" {
            tagType = .createDt
        } else if elementName == "deathCnt" {
            tagType = .deathCnt
        } else if elementName == "defCnt" {
            tagType = .defCnt
        } else if elementName == "gubun" {
            tagType = .gubun
        } else if elementName == "gubunCn" {
            tagType = .gubunCn
        } else if elementName == "gubunEn" {
            tagType = .gubunEn
        } else if elementName == "incDec" {
            tagType = .incDec
        } else if elementName == "isolClearCnt" {
            tagType = .isolClearCnt
        } else if elementName == "isolIngCnt" {
            tagType = .isolIngCnt
        } else if elementName == "localOccCnt" {
            tagType = .localOccCnt
        } else if elementName == "overFlowCnt" {
            tagType = .overFlowCnt
        } else if elementName == "qurRate" {
            tagType = .qurRate
        } else if elementName == "seq" {
            tagType = .seq
        } else if elementName == "stdDay" {
            tagType = .stdDay
        } else {
            tagType = .none
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            guard let tempModel = tempModel else {
                return
            }
            books.append(tempModel)
            isLock = false
        } else {
            print("----- didEndElement (else)-----")
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let parseString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .decimal
        
        
        //        _ = numberFormatter.string(from: NSNumber(value:defCntt))
        if isLock == true {
            if let dCnt = tempModel?.defCnt, let deCnt = tempModel?.deathCnt, let inCnt = tempModel?.incDec, let lCnt = tempModel?.localOccCnt, let oFCnt = tempModel?.overFlowCnt, let rate = tempModel?.qurRate{
                let defCount = Int(dCnt)
                let deathCount = Int(deCnt)
                let incCount = Int(inCnt)
                let localCount = Int(lCnt)
                let overFlowCount = Int(oFCnt)
                let rateDouble = (Double(rate) ?? 0) * 0.001
                
                let defResult = numberFormatter.string(for: defCount)! + "명"
                let deathResult = numberFormatter.string(for: deathCount)! + "명"
                let incResult = numberFormatter.string(for: incCount)! + "명"
                let localResult = numberFormatter.string(for: localCount)! + "명"
                let overFlowResult = numberFormatter.string(for: overFlowCount)! + "명"
                
                //                numberFormatter.numberStyle = .none
                //                let rateResult = numberFormatter.string(for: rateDouble)!+"%"
                
                let rateResult = String(format: "%.2f", rateDouble) + "%"
                
                if(tempModel?.gubun == "합계"){
                    defCntt.text = defResult
                    deathCntt.text = deathResult
                    incDecc.text = incResult
                    localOccCntt.text = localResult
                    overFlowCntt.text = overFlowResult
                    refreshRecord.text = tempModel!.createDt
                }
                //                defCntt.text = tempModel?.defCnt
                //                deathCntt.text = tempModel?.deathCnt
                //                isolIngCntt.text = tempModel?.isolIngCnt
                //                incDecc.text = tempModel?.incDec
                //                localOccCntt.text = tempModel?.localOccCnt
                //                overFlowCntt.text = tempModel?.overFlowCnt
                
                //서울,경기,인천,광주,대전,울산,세종,강원,충북,충남,전북,전남,경북,경남,대구,부산,제주
                if(tempModel?.gubun == "서울"){
                    //시도명
                    data[0][0] = tempModel!.gubun
                    //누적 확진자
                    data[0][1] = defResult
                    //일일 확진자
                    data[0][2] = incResult
                    //사망자 수
                    data[0][3] = deathResult
                    //10만명당발생률
                    data[0][4] = rateResult
                }
                if(tempModel?.gubun == "경기"){
                    //시도명
                    data[1][0] = tempModel!.gubun
                    //누적 확진자
                    data[1][1] = defResult
                    //일일 확진자
                    data[1][2] = incResult
                    //사망자 수
                    data[1][3] = deathResult
                    //10만명당발생률
                    data[1][4] = rateResult
                }
                if(tempModel?.gubun == "인천"){
                    //시도명
                    data[2][0] = tempModel!.gubun
                    //누적 확진자
                    data[2][1] = defResult
                    //일일 확진자
                    data[2][2] = incResult
                    //사망자 수
                    data[2][3] = deathResult
                    //10만명당발생률
                    data[2][4] = rateResult
                }
                if(tempModel?.gubun == "광주"){
                    //시도명
                    data[3][0] = tempModel!.gubun
                    //누적 확진자
                    data[3][1] = defResult
                    //일일 확진자
                    data[3][2] = incResult
                    //사망자 수
                    data[3][3] = deathResult
                    //10만명당발생률
                    data[3][4] = rateResult
                }
                if(tempModel?.gubun == "대전"){
                    //시도명
                    data[4][0] = tempModel!.gubun
                    //누적 확진자
                    data[4][1] = defResult
                    //일일 확진자
                    data[4][2] = incResult
                    //사망자 수
                    data[4][3] = deathResult
                    //10만명당발생률
                    data[4][4] = rateResult
                }
                if(tempModel?.gubun == "울산"){
                    //시도명
                    data[5][0] = tempModel!.gubun
                    //누적 확진자
                    data[5][1] = defResult
                    //일일 확진자
                    data[5][2] = incResult
                    //사망자 수
                    data[5][3] = deathResult
                    //10만명당발생률
                    data[5][4] = rateResult
                }
                if(tempModel?.gubun == "세종"){
                    //시도명
                    data[6][0] = tempModel!.gubun
                    //누적 확진자
                    data[6][1] = defResult
                    //일일 확진자
                    data[6][2] = incResult
                    //사망자 수
                    data[6][3] = deathResult
                    //10만명당발생률
                    data[6][4] = rateResult
                }
                if(tempModel?.gubun == "강원"){
                    //시도명
                    data[7][0] = tempModel!.gubun
                    //누적 확진자
                    data[7][1] = defResult
                    //일일 확진자
                    data[7][2] = incResult
                    //사망자 수
                    data[7][3] = deathResult
                    //10만명당발생률
                    data[7][4] = rateResult
                }
                if(tempModel?.gubun == "충북"){
                    //시도명
                    data[8][0] = tempModel!.gubun
                    //누적 확진자
                    data[8][1] = defResult
                    //일일 확진자
                    data[8][2] = incResult
                    //사망자 수
                    data[8][3] = deathResult
                    //10만명당발생률
                    data[8][4] = rateResult
                }
                if(tempModel?.gubun == "충남"){
                    //시도명
                    data[9][0] = tempModel!.gubun
                    //누적 확진자
                    data[9][1] = defResult
                    //일일 확진자
                    data[9][2] = incResult
                    //사망자 수
                    data[9][3] = deathResult
                    //10만명당발생률
                    data[9][4] = rateResult
                }
                if(tempModel?.gubun == "전북"){
                    //시도명
                    data[10][0] = tempModel!.gubun
                    //누적 확진자
                    data[10][1] = defResult
                    //일일 확진자
                    data[10][2] = incResult
                    //사망자 수
                    data[10][3] = deathResult
                    //10만명당발생률
                    data[10][4] = rateResult
                }
                if(tempModel?.gubun == "전남"){
                    //시도명
                    data[11][0] = tempModel!.gubun
                    //누적 확진자
                    data[11][1] = defResult
                    //일일 확진자
                    data[11][2] = incResult
                    //사망자 수
                    data[11][3] = deathResult
                    //10만명당발생률
                    data[11][4] = rateResult
                }
                if(tempModel?.gubun == "경북"){
                    //시도명
                    data[12][0] = tempModel!.gubun
                    //누적 확진자
                    data[12][1] = defResult
                    //일일 확진자
                    data[12][2] = incResult
                    //사망자 수
                    data[12][3] = deathResult
                    //10만명당발생률
                    data[12][4] = rateResult
                }
                if(tempModel?.gubun == "경남"){
                    //시도명
                    data[13][0] = tempModel!.gubun
                    //누적 확진자
                    data[13][1] = defResult
                    //일일 확진자
                    data[13][2] = incResult
                    //사망자 수
                    data[13][3] = deathResult
                    //10만명당발생률
                    data[13][4] = rateResult
                }
                if(tempModel?.gubun == "대구"){
                    //시도명
                    data[14][0] = tempModel!.gubun
                    //누적 확진자
                    data[14][1] = defResult
                    //일일 확진자
                    data[14][2] = incResult
                    //사망자 수
                    data[14][3] = deathResult
                    //10만명당발생률
                    data[14][4] = rateResult
                }
                if(tempModel?.gubun == "부산"){
                    //시도명
                    data[15][0] = tempModel!.gubun
                    //누적 확진자
                    data[15][1] = defResult
                    //일일 확진자
                    data[15][2] = incResult
                    //사망자 수
                    data[15][3] = deathResult
                    //10만명당발생률
                    data[15][4] = rateResult
                }
                if(tempModel?.gubun == "제주"){
                    //시도명
                    data[16][0] = tempModel!.gubun
                    //누적 확진자
                    data[16][1] = defResult
                    //일일 확진자
                    data[16][2] = incResult
                    //사망자 수
                    data[16][3] = deathResult
                    //10만명당발생률
                    data[16][4] = rateResult
                }
                
                switch tagType {
                case .createDt:
                    tempModel?.createDt = parseString
                case .deathCnt:
                    tempModel?.deathCnt = parseString
                case .defCnt:
                    tempModel?.defCnt = parseString
                case .gubun:
                    tempModel?.gubun = parseString
                case .gubunCn:
                    tempModel?.gubunCn = parseString
                case .gubunEn:
                    tempModel?.gubunEn = parseString
                case .incDec:
                    tempModel?.incDec = parseString
                case .isolClearCnt:
                    tempModel?.isolClearCnt = parseString
                case .isolIngCnt:
                    tempModel?.isolIngCnt = parseString
                case .localOccCnt:
                    tempModel?.localOccCnt = parseString
                case .overFlowCnt:
                    tempModel?.overFlowCnt = parseString
                case .qurRate:
                    tempModel?.qurRate = parseString
                case .seq:
                    tempModel?.seq = parseString
                case .stdDay:
                    tempModel?.stdDay = parseString
                case .none: break
                }
            }
        }
    }
    static func getDate(_ date: Date)->String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyyMMdd"
        return dateformatter.string(from: date)
    }
    static func getTime(_ date: Date)->String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HH"
        return dateformatter.string(from: date)
    }
    
    @IBAction func tap(_ sender: Any) {
        getXMLData()
    }
    
}
