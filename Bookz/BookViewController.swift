//
//  BookViewController.swift
//  Bookz
//
//  Created by Divisi CodeLabs on 8/16/16.
//  Copyright © 2016 Divisi CodeLabs. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func postData(sender: AnyObject) {
        let session = NSURLSession.sharedSession()
        let url = "http://bukuapi.azurewebsites.net/api/buku"
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        let params:[String:AnyObject] = ["kode_buku": "swft002",
                                         "judul_buku": "Swifty Book #2",
                                         "pengarang": "Evan Gilang Ramadhan",
                                         "penerbit": "insan madani",
                                         "tahun": 2016,
                                         "stok": 5,
                                         "harga": 65000]
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions())
            let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
                if let response = response {
                    let nsHTTPResponse = response as! NSHTTPURLResponse
                    let statusCode = nsHTTPResponse.statusCode
                    print("status code = \(statusCode)")
                }
                
                if let error = error {
                    print("\(error)")
                }
                
                if let data = data {
                    do {
                        let jsonResponse = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions())
                        print("data = \(jsonResponse)")
                    } catch _ {
                        print("oops")
                    }
                }
            })
            task.resume()
        } catch _ {
            print("something happened")
        }
        
    }
}
