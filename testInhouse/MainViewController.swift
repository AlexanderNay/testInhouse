//
//  MainViewController.swift
//  testInhouse
//
//  Created by Alexander Nay on 10/13/19.
//  Copyright © 2019 Alexander Nay. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView! {
        willSet {
            newValue.delegate = self
            newValue.dataSource = self
        }
    }
    
    @IBOutlet weak var activityIndicatorContainerView: UIView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let dataManager = DataMenager()
    var indexPath = IndexPath()
    var newsItems: [NewsItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivityIndicator()
        registerCells()
        dataManager.getItems { (newsItems, error) in
            if error != nil {
                self.showAlert()
            }
            self.newsItems = newsItems
            self.mainTableView.reloadData()
            self.hideActivityIndicator()
        }
    }
    
    
    private func showAlert() {
        let alert = UIAlertController(title: "Отсутствует интернет соединение", message: "Используются данные из кэша", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showActivityIndicator() {
        activityIndicator.startAnimating()
        activityIndicatorContainerView.layer.cornerRadius = 8
        activityIndicatorContainerView.isHidden = false
    }
    
    private func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicatorContainerView.isHidden = true
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

