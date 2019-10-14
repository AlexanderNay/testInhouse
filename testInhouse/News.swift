//
//  News.swift
//  testInhouse
//
//  Created by Alexander Nay on 10/14/19.
//  Copyright © 2019 Alexander Nay. All rights reserved.
//

import Foundation
import RealmSwift

class News: Object {
    @objc dynamic var baseUrl = ""
    @objc dynamic var htmlString = ""
}
