//
//  BookTableViewController.swift
//  Bookz
//
//  Created by Divisi CodeLabs on 8/12/16.
//  Copyright © 2016 Divisi CodeLabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class BookTableViewController: UITableViewController {
    
    var books = [Buku]()
    //var book: Buku?
    
    func ambilData() {
        let url = NSURL(string: "http://bukuapi.azurewebsites.net/api/buku")
        NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if error != nil {
                print(error)
                
                return
            }
            //print(response)
            
            let json = JSON(data: data!)
            //let judulBuku = json[0]["title"].string
            /*
             let pengarang = json["result"].arrayValue
             for item in pengarang {
             let namaPengarang = item["pengarang"].stringValue
             print(namaPengarang)
             }
             
             let judul = json["result"].arrayValue
             for item in judul {
             let judulBuku = item["judulBuku"].stringValue
             print(judulBuku)
             }*/
            
            let result = json["result"].arrayValue
            for item in result {
                let bookTitle = item["judulBuku"].stringValue
                let bookAuthor = item["pengarang"].stringValue
                let bookPublisher = item["penerbit"].stringValue
                let bookCode = item["kdBuku"].stringValue
                let bookPrice = item["harga"].intValue
                let bookStock = item["stok"].intValue
                let bookYear = item["tahun"].intValue
                self.books.append(Buku(title: bookTitle, author: bookAuthor, publisher: bookPublisher, code: bookCode, price: bookPrice, stock: bookStock, year: bookYear))
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })

                print("\(bookTitle) | \(bookAuthor)" )
            }
            print(self.books.count)
            
            }.resume()
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(books.count)
        return books.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? BookTableViewCell
        let book = books[indexPath.row]
        cell?.titleLabel.text = book.title
        cell?.authorLabel.text = book.author
        cell?.publisherLabel.text = book.publisher
        cell?.codeLabel.text = book.code
        cell?.priceLabel.text = String(book.price)
        cell?.stockLabel.text = String(book.stock)
        cell?.yearLabel.text = String(book.year)
        
        return cell!
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        print("heyho")
        ambilData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
