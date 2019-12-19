//
//  MenuViewController.swift
//  kissa_accounting
//
//  Created by Kei Kawamura on 2018/09/10.
//  Modified by Tomohiro Hori from 2019/03/18~.
//  Copyright © 2018 Kei Kawamura / 2019 Tomohiro Hori . All rights reserved.
//

import Foundation
import UIKit
import SwiftyDropbox
class MenuViewController : UIViewController{
    
    @IBAction func toServe(_ sender: Any) {
        performSegue(withIdentifier: "toServe", sender: nil)
    }
    @IBAction func toOutServe(_ sender: Any) {
        performSegue(withIdentifier: "toOutServe", sender: nil)
    }
    @IBAction func toInRegister(_ sender: Any) {
        performSegue(withIdentifier: "toInRegister", sender: nil)
    }
    @IBAction func toOutRegister(_ sender: Any) {
        performSegue(withIdentifier: "toOutRegister", sender: nil)
    }
    
    @IBAction func dropbox(_ sender: Any) {
        DropboxClientsManager.authorizeFromController(UIApplication.shared,controller: self,openURL: { (url: URL) -> Void in
            UIApplication.shared.openURL(url)
        })
    }
    
    @IBAction func upload(_ sender: Any) {
        guard let client = DropboxClientsManager.authorizedClient else {
            return
        }
        let fileData = "testing data example".data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        _ = client.files.upload(path:"/Data/myUploadTestFile.txt", input: fileData)
            .response { response, error in
                if let response = response {
                    print(response)
                }else if let error = error {
                    print(error)
                }
            }
            .progress { progressData in
                print(progressData)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
