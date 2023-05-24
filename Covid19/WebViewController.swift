//
//  WebViewController.swift
//  Covid19
//
//  Created by comsoft on 2021/11/10.
//  Copyright © 2021 comsoft. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController  {
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "http://ncov.mohw.go.kr" // 띄울 웹 홈페이지 주소, http://ncov.mohw.go.kr, https://ncv.kdca.go.kr
        guard let url = URL(string: urlString) else {return}
        let request = URLRequest(url: url)
        webView.load(request)
        // Do any additional setup after loading the view.
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
