//
//  ViewController.swift
//  Bookz
//
//  Created by Divisi CodeLabs on 8/10/16.
//  Copyright © 2016 Divisi CodeLabs. All rights reserved.
//

import UIKit
import SwiftyJSON


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //var tableView: UITableView!
    var books = [Buku]()
    var book: Buku?
    
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
                self.books.append(Buku(title: bookTitle, author: bookAuthor))
                print("\(bookTitle) | \(bookAuthor)" )
            }
            print(self.books.count)

        }.resume()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(books.count)
        return books.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? BookTableViewCell
        cell?.titleLabel.text = book?.title
        cell?.authorLabel.text = book?.author
        
        return cell!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ambilData()
        /*dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })*/

       
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

