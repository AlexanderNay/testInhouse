//
//  NewsItem.swift
//  testInhouse
//
//  Created by Alexander Nay on 10/14/19.
//  Copyright © 2019 Alexander Nay. All rights reserved.
//

import Foundation
import RealmSwift

class NewsItem: Object {
    @objc dynamic var title = ""
    @objc dynamic var link = ""
    @objc dynamic var itemDescription = ""
    @objc dynamic var imageURL = ""
}
