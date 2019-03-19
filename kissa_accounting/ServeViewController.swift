//
//  ServeViewController.swift
//  kissa_accounting
//
//  Created by Tomohiro Hori on 2019/03/19.
//  Copyright © 2019 Tomohiro Hori. All rights reserved.
//

import UIKit
import Firebase

class ServeViewController: UIViewController {
    
    //ラベルのコネクション
    @IBOutlet weak var W1AmountLabel: UILabel!
    @IBOutlet weak var W2AmountLabel: UILabel!
    @IBOutlet weak var S1AmountLabel: UILabel!
    @IBOutlet weak var S2AmountLabel: UILabel!
    @IBOutlet weak var S3AmountLabel: UILabel!
    @IBOutlet weak var P1AmountLabel: UILabel!
    @IBOutlet weak var P2AmountLabel: UILabel!
    
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var WStatusButton: UIButton!
    @IBOutlet weak var SStatusButton: UIButton!
    @IBOutlet weak var PStatusButton: UIButton!
    
    @IBOutlet weak var orderTimeLabel: UILabel!
    @IBOutlet weak var dessertTimeLabel: UILabel!
    
    var tableNumber : String?
    var newTableNumber : String?
    var DBRef:DatabaseReference!
    
    var status : String?
    var WStatus : String?
    var PStatus : String?
    var SStatus : String?
    
    var W1Amount : String?
    var W2Amount : String?
    var P1Amount : String?
    var P2Amount : String?
    var S1Amount : String?
    var S2Amount : String?
    var S3Amount : String?
    
    var dateUnix: TimeInterval = 0
    var hogeTime : String?
    var hogeTime2 : String?
    
    
    @IBAction func Serve(_ sender: Any) {
        if Int(self.status!) == 1 || Int(self.status!) == 2{
            let alertController = UIAlertController(title: "配膳完了（デザート以外）",message: "タイマーセットしますか？", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
                self.DBRef.child("table/status").child(self.tableNumber!).setValue(3)
                self.DBRef.child("table/WStatus").child(self.tableNumber!).setValue(0)
                self.DBRef.child("table/SStatus").child(self.tableNumber!).setValue(0)
                self.DBRef.child("table/order").child(self.tableNumber!).child("completeTime").setValue(ServerValue.timestamp())
            }
            let cancelButton = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: nil)
            alertController.addAction(okAction)
            alertController.addAction(cancelButton)
            present(alertController,animated: true,completion: nil)
            
        }else if Int(self.status!) == 3{
            let alertController = UIAlertController(title: "配膳完了",message: "実行しますか？", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
                self.DBRef.child("table/status").child(self.tableNumber!).setValue(4)
                self.DBRef.child("table/WStatus").child(self.tableNumber!).setValue(0)
                self.DBRef.child("table/SStatus").child(self.tableNumber!).setValue(0)
                self.DBRef.child("table/PStatus").child(self.tableNumber!).setValue(0)
                //オーダーキーのリセット
                var hogeKey : String?
                let defaultPlace = self.DBRef.child("table/orderKey").child(self.tableNumber!)
                defaultPlace.observeSingleEvent(of: .value, with: { (snapshot) in
                    hogeKey = (snapshot.value! as AnyObject).description
                    self.DBRef.child("inData").child(hogeKey!).updateChildValues(["completeTime":ServerValue.timestamp()])
                    self.DBRef.child("table/orderOrder").child(hogeKey!).setValue(nil)
                })
            }
            let cancelButton = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: nil)
            
            alertController.addAction(okAction)
            alertController.addAction(cancelButton)
            
            present(alertController,animated: true,completion: nil)
        }
    }
    
    @IBAction func WServe(_ sender: Any) {
        if Int(self.WStatus!) == 1 {
            self.DBRef.child("table/WStatus").child(tableNumber!).setValue(2)
        } else if Int(self.WStatus!) == 2{
            self.DBRef.child("table/WStatus").child(tableNumber!).setValue(1)
        }
    }
    @IBAction func SServe(_ sender: Any) {
        if Int(self.SStatus!) == 1 {
            self.DBRef.child("table/SStatus").child(tableNumber!).setValue(2)
        } else if Int(self.SStatus!) == 2{
            self.DBRef.child("table/SStatus").child(tableNumber!).setValue(1)
        }
    }
    @IBAction func PServe(_ sender: Any) {
        if Int(self.PStatus!) == 1 {
            self.DBRef.child("table/PStatus").child(tableNumber!).setValue(2)
        } else if Int(self.PStatus!) == 2{
            self.DBRef.child("table/PStatus").child(tableNumber!).setValue(1)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //インスタンスを作成
        DBRef = Database.database().reference()
        
        //デフォルト表示
        tableNumber = newTableNumber ?? "001"
        self.navigationItem.title = "Table " + tableNumber!
        
        Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(self.status(_:)),
            userInfo: nil,
            repeats: false
        )
        Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(self.dessertTime(_:)),
            userInfo: nil,
            repeats: true
        )
    }
        
    @objc func status(_ sender: Timer) {
        //注文数取得
        let defaultPlaceW1 = DBRef.child("table/order").child(tableNumber!).child("W1Amount")
        defaultPlaceW1.observe(.value, with: { (snapshot) in
            self.W1Amount = (snapshot.value! as AnyObject).description
            self.W1AmountLabel.text = self.W1Amount!
        })
        let defaultPlaceW2 = DBRef.child("table/order").child(tableNumber!).child("W2Amount")
        defaultPlaceW2.observe(.value, with: { (snapshot) in
            self.W2Amount = (snapshot.value! as AnyObject).description
            self.W2AmountLabel.text = self.W2Amount!
        })
        let defaultPlaceS1 = DBRef.child("table/order").child(tableNumber!).child("S1Amount")
        defaultPlaceS1.observe(.value, with: { (snapshot) in
            self.S1Amount = (snapshot.value! as AnyObject).description
            self.S1AmountLabel.text = self.S1Amount!
        })
        let defaultPlaceS2 = DBRef.child("table/order").child(tableNumber!).child("S2Amount")
        defaultPlaceS2.observe(.value, with: { (snapshot) in
            self.S2Amount = (snapshot.value! as AnyObject).description
            self.S2AmountLabel.text = self.S2Amount!
        })
        let defaultPlaceS3 = DBRef.child("table/order").child(tableNumber!).child("S3Amount")
        defaultPlaceS3.observe(.value, with: { (snapshot) in
            self.S3Amount = (snapshot.value! as AnyObject).description
            self.S3AmountLabel.text = self.S3Amount!
        })
        let defaultPlaceP1 = DBRef.child("table/order").child(tableNumber!).child("P1Amount")
        defaultPlaceP1.observe(.value, with: { (snapshot) in
            self.P1Amount = (snapshot.value! as AnyObject).description
            self.P1AmountLabel.text = self.P1Amount!
        })
        let defaultPlaceP2 = DBRef.child("table/order").child(tableNumber!).child("P2Amount")
        defaultPlaceP2.observe(.value, with: { (snapshot) in
            self.P2Amount = (snapshot.value! as AnyObject).description
            self.P2AmountLabel.text = self.P2Amount!
        })
        
        //各カテゴリーの配膳状況表示
        let defaultPlace = DBRef.child("table/status").child(self.tableNumber!)
        defaultPlace.observe(.value, with: { snapshot in
            self.status = (snapshot.value! as AnyObject).description
            if Int(self.status!) == 0{
                self.statusButton.backgroundColor = UIColor.clear
            }else if Int(self.status!) == 1{
                self.statusButton.backgroundColor = UIColor(red:0.75, green:0.88, blue:0.90, alpha:0.75)
            }else if Int(self.status!) == 2{
                self.statusButton.backgroundColor = UIColor(red:0.98, green:0.93, blue:0.95, alpha:1.0)
            }else if Int(self.status!) == 3{
                self.statusButton.backgroundColor = UIColor(red:0.96, green:0.92, blue:0.41, alpha:0.5)
            }else if Int(self.status!) == 4{
                self.statusButton.backgroundColor = UIColor(red:0.75, green:0.83, blue:0.41, alpha:0.5)
            }
        })
        
        let defaultPlaceW = DBRef.child("table/WStatus").child(self.tableNumber!)
        defaultPlaceW.observe(.value, with: { snapshot in
            self.WStatus = (snapshot.value! as AnyObject).description
            if Int(self.WStatus!) == 1{
                self.WStatusButton.backgroundColor = UIColor(red:0.98, green:0.93, blue:0.95, alpha:1.0)
            }else if Int(self.WStatus!) == 2{
                self.WStatusButton.backgroundColor = UIColor(red:0.75, green:0.83, blue:0.41, alpha:0.5)
            }else{
                self.WStatusButton.backgroundColor = UIColor.clear
            }
        })
        let defaultPlaceS = DBRef.child("table/SStatus").child(self.tableNumber!)
        defaultPlaceS.observe(.value, with: { snapshot in
            self.SStatus = (snapshot.value! as AnyObject).description
            if Int(self.SStatus!) == 1{
                self.SStatusButton.backgroundColor = UIColor(red:0.98, green:0.93, blue:0.95, alpha:1.0)
            }else if Int(self.SStatus!) == 2{
                self.SStatusButton.backgroundColor = UIColor(red:0.75, green:0.83, blue:0.41, alpha:0.5)
            }else{
                self.SStatusButton.backgroundColor = UIColor.clear
            }
        })
        let defaultPlaceP = DBRef.child("table/PStatus").child(self.tableNumber!)
        defaultPlaceP.observe(.value, with: { snapshot in
            self.PStatus = (snapshot.value! as AnyObject).description
            if Int(self.PStatus!) == 1{
                self.PStatusButton.backgroundColor = UIColor(red:0.98, green:0.93, blue:0.95, alpha:1.0)
            }else if Int(self.PStatus!) == 2{
                self.PStatusButton.backgroundColor = UIColor(red:0.75, green:0.83, blue:0.41, alpha:0.5)
            }else{
                self.PStatusButton.backgroundColor = UIColor.clear
            }
        })
        
        let defaultPlaceOT = DBRef.child("table/order").child(self.tableNumber!).child("time")
        defaultPlaceOT.observeSingleEvent(of: .value, with: { snapshot in
            if Int(self.status!) == 0 {
                self.orderTimeLabel.text = "00:00:00"
            } else {
                self.hogeTime = (snapshot.value! as AnyObject).description
                self.dateUnix = TimeInterval(self.hogeTime!)!
                let hogedate = NSDate(timeIntervalSince1970: self.dateUnix/1000)
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm:ss"
                self.orderTimeLabel.text = formatter.string(from: hogedate as Date)
            }
        })
    }
    
    @objc func dessertTime(_ sender: Timer) {
        let defaultPlaceCT = DBRef.child("table/order").child(self.tableNumber!).child("completeTime")
        defaultPlaceCT.observe(.value, with: { snapshot in
            self.hogeTime2 = (snapshot.value! as AnyObject).description ?? "0"
            if Int(self.status!) == 3 {
                var calendar = Calendar.current
                calendar.locale = Locale(identifier: "ja_JP")
                self.dateUnix = TimeInterval(self.hogeTime2!)!
                let hogeDate = NSDate(timeIntervalSince1970: self.dateUnix/1000)
                let time = Date().timeIntervalSince(hogeDate as Date)
//                let formatter = DateComponentsFormatter()
//                formatter.calendar = calendar
//                formatter.unitsStyle = .positional
//                formatter.allowedUnits = [.hour, .minute, .second]
//                formatter.zeroFormattingBehavior = [.dropLeading]
                let interval = Int(time)
                let seconds = interval % 60
                let minutes = (interval / 60) % 60
                let hours = (interval / 3600)
                self.dessertTimeLabel.text = String(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
                //self.dessertTimeLabel.text = formatter.string(from: time)!
            } else {
                self.dessertTimeLabel.text = "00:00:00"
            }
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
