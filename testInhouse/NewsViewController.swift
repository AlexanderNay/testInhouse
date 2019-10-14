//
//  NewsViewController.swift
//  testInhouse
//
//  Created by Alexander Nay on 10/13/19.
//  Copyright © 2019 Alexander Nay. All rights reserved.
//

import UIKit
import WebKit

class NewsViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var stringUrl: String!
    let dataMenager = DataMenager()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataMenager.getNews(url: stringUrl) { (news, error) in
            //handle when no connection and DB is empty
            let news = news
            let baseURL = URL(string: news.baseUrl)
            self.webView.loadHTMLString(news.htmlString, baseURL: baseURL)
        }
    }
}
