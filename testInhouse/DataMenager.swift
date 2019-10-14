//
//  DataMenager.swift
//  testInhouse
//
//  Created by Alexander Nay on 10/14/19.
//  Copyright © 2019 Alexander Nay. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire
import AlamofireRSSParser

class DataMenager {

    private let url = "https://news.rambler.ru/rss/moscow_city/"
    
    func getItems(complition: @escaping([NewsItem]?, Error?) -> Void) {
        
        Alamofire.request(url).responseRSS { (response) in
            // get from BD
            let realm = try! Realm()
            
            if let error = response.error {
                let newsItems = Array(realm.objects(NewsItem.self))
                complition(newsItems, error)
                return
            }
            guard let result = response.result.value else {return}
            let newsItems: [NewsItem] = result.items.map {NewsItem(value: [
                "title" : $0.title ?? "",
                "link" : $0.link  ?? "",
                "itemDescription" : $0.itemDescription  ?? "",
                "imageURL" : $0.imagesFromContent?.first  ?? "",
            ])}
            
            //clear BD Here
            try! realm.write {
                realm.deleteAll()
            }
            try! realm.write {
                newsItems.forEach { realm.add($0) }
            }
            
            complition(newsItems, nil)
        }
    }
    
    
    func getNews(url: String, complition: @escaping(News, Error?) -> Void) {
        
        Alamofire.request(url).responseString { (response) in
            
            let realm = try! Realm()
            
            if let error = response.error {
                guard let news = Array(realm.objects(News.self).filter("baseUrl = '\(url)'")).first else { return }
                complition(news, error)
                return
            }
            
            guard let result = response.result.value else {return}
            let news = News()
            news.baseUrl = url
            news.htmlString = result
            try! realm.write {
                realm.add(news)
            }
            
            complition(news, nil)
        }
        
    }
}
