//
//  MainViewController.swift
//  testInhouse
//
//  Created by Alexander Nay on 10/13/19.
//  Copyright © 2019 Alexander Nay. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireRSSParser

class MainViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView! {
        willSet {
            newValue.delegate = self
            newValue.dataSource = self
        }
    }
    
    let dataManager = DataMenager()
    var indexPath = IndexPath()
    var newsItems: [NewsItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        dataManager.getItems { (newsItems, error) in
            self.newsItems = newsItems
            self.mainTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNews" {
            if let vc = segue.destination as? NewsViewController {
                guard let newsItem = newsItems?[indexPath.row] else { return }
                vc.stringUrl = newsItem.link
            }
        }
    }


}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func registerCells() {
        let feedTableViewCellNib = UINib(nibName: "FeedTableViewCell", bundle: Bundle.main)
        mainTableView.register(feedTableViewCellNib, forCellReuseIdentifier: "FeedTableViewCell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let newsItems = newsItems else { return 0 }
        //return feed.items.count
        return newsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let newsItems = newsItems else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as! FeedTableViewCell

        let item = newsItems[indexPath.row]
        cell.setupCell(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexPath = indexPath
        performSegue(withIdentifier: "toNews", sender: self)
    }
    
    
    
}

