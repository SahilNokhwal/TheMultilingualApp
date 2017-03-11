//
//  ViewController.swift
//  TheMultilingualApp
//
//  Created by Nokhwal,Sahil on 3/30/16.
//  Copyright © 2016 Nokhwal,Sahil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var language:String = "Japanese"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var translatedTextTV: UITextView!

    
    @IBAction func segment(sender: UISegmentedControl) {
        
        var selectedSegmentIndex:Int = sender.selectedSegmentIndex
        
       language =  sender.titleForSegmentAtIndex(selectedSegmentIndex)!
       
    }
    @IBOutlet weak var textToTranslateTV: UITextView!
    
    @IBAction func translateBTN(sender: UIButton) {
        var textTV:String = textToTranslateTV.text.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        let languageCode = ["Japanese":"ja", "French":"fr", "Hindi":"hi"]
        print(textTV)
        print(languageCode[language])
        var urlString:String =  "https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20160307T213950Z.3c5c87c3e34aaaae.bfe9021dfa7e4b7e1ef4826c52e2e8781c8a1813&text=\(textTV)&lang=en-\(languageCode[language]!)"
      print(urlString)
        
        let url = NSURL(string: urlString) // do not include < >, just what
        let session = NSURLSession.sharedSession() // lies in between
        session.dataTaskWithURL(url!, completionHandler: processResults).resume()
        
        
    }
    func processResults(data:NSData?,response:NSURLResponse?,error:NSError?)->Void {
        var jsonData:[String:AnyObject]
        do {
            try jsonData = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! [String:AnyObject] // grab the data
            print(jsonData)
          
                let text = jsonData["text"]! as! [String]
                //let age = person["age"]! as! Int
               // let eyeColor = person["eyeColor"]! as! String
               // self.everybody.append(Person(name:name, age:age, eyeColor:eyeColor)
            
            
            dispatch_async(dispatch_get_main_queue()){
                 self.translatedTextTV.text = text[0]
            }
        }catch {
            //let blamees:[String] = ["Dennis", "Michael", "Charles"]
            print("Something has gone wrong")
        }
    }
}
    


