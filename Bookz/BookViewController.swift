//
//  BookViewController.swift
//  Bookz
//
//  Created by Divisi CodeLabs on 8/16/16.
//  Copyright © 2016 Divisi CodeLabs. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
    
    @IBOutlet var bookCodeTextField: UITextField!
    @IBOutlet var bookTitleTextField: UITextField!
    @IBOutlet var bookAuthorTextField: UITextField!
    @IBOutlet var bookPublisherTextField: UITextField!
    @IBOutlet var bookYearPublishedTextField: UITextField!
    @IBOutlet var bookStockTextField: UITextField!
    @IBOutlet var bookPriceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   
    
    @IBAction func saveButton(sender: AnyObject) {
        let bookCode = bookCodeTextField.text
        let bookTitle = bookTitleTextField.text
        let bookAuthor = bookAuthorTextField.text
        let bookPublisher = bookPublisherTextField.text
        let bookYearPublished = Int(bookYearPublishedTextField.text!)
        let bookStock = Int(bookStockTextField.text!)
        let bookPrice = Int(bookPriceTextField.text!)
        let session = NSURLSession.sharedSession()
        let url = "http://bukuapi.azurewebsites.net/api/buku"
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        let params:[String:AnyObject] = ["kode_buku": bookCode!,
                                         "judul_buku": bookTitle!,
                                         "pengarang": bookAuthor!,
                                         "penerbit": bookPublisher!,
                                         "tahun": bookYearPublished!,
                                         "stok": bookStock!,
                                         "harga": bookPrice!]
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
        dismissViewControllerAnimated(true, completion: nil)
    }

    
}
