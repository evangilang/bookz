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
    
    init(title: String, author: String) {
        self.title = title
        self.author = author
    }
}
