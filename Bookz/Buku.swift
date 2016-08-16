//
//  Buku.swift
//  Bookz
//
//  Created by Divisi CodeLabs on 8/11/16.
//  Copyright © 2016 Divisi CodeLabs. All rights reserved.
//

import Foundation
import SwiftyJSON

class Buku {
    var title: String
    var author: String
    var publisher: String
    var code: String
    var price: Int
    var stock: Int
    var year: Int
    
    init(title: String, author: String, publisher: String, code: String, price: Int, stock: Int, year: Int) {
        self.title = title
        self.author = author
        self.publisher = publisher
        self.price = price
        self.code = code
        self.stock = stock
        self.year = year
    }
}
