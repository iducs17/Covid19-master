//
//  ViewController.swift
//  Covid19
//
//  Created by comsoft on 2021/11/16.
//  Copyright © 2021 comsoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIWebViewDelegate  {

    @IBOutlet weak var txtUrl: UITextField!
    @IBOutlet weak var myWebView: UIWebView!
    @IBOutlet weak var myActivityindicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //myWebView 의 delegate 를 self 로 추가 합니다.
        myWebView.delegate = self
        //앱이 처음 나타나면 접속할 웹 페이지 주소를 추가 합니다.
        loadWebPage("http://www.todaymart.com")    }
    
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
         
        func webViewDidStartLoad(_ webView: UIWebView) {
           //액티비티 인디케이터 동작을 시작하는 함수
            myActivityindicator.startAnimating()
        }
         
        func webViewDidFinishLoad(_ webView: UIWebView) {
           ////액티비티 인디케이터 동작을 종료하는 함수
            myActivityindicator.stopAnimating()
        }
     
        @IBAction func btnGoUrl(_ sender: UIButton) {
        }
         
        //Site1 버튼 클릭하면 이동하는 페이지
        @IBAction func btnGoSite1(_ sender: UIButton) {
            loadWebPage("http://m.naver.com")
        }
        //Site2 버튼을 클릭하면 이동하는 페이지
        @IBAction func btnGoSite2(_ sender: UIButton) {
            loadWebPage("http://m.daum.net")
        }
         
        @IBAction func btnLoadHtmlString(_ sender: UIButton) {
        }
         
        @IBAction func btnLoadHtmlFile(_ sender: UIButton) {
        }
         
        @IBAction func btnStop(_ sender: UIBarButtonItem) {
        }
         
        @IBAction func btnReload(_ sender: UIBarButtonItem) {
        }
         
        @IBAction func btnGoBack(_ sender: UIBarButtonItem) {
        }
         
        @IBAction func btnGoForward(_ sender: UIBarButtonItem) {
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
