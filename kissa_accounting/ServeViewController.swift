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
    //@IBOutlet weak var W2AmountLabel: UILabel!
    @IBOutlet weak var S1AmountLabel: UILabel!
    @IBOutlet weak var S2AmountLabel: UILabel!
    //@IBOutlet weak var S3AmountLabel: UILabel!
    @IBOutlet weak var P1AmountLabel: UILabel!
    @IBOutlet weak var P2AmountLabel: UILabel!
    @IBOutlet weak var D1AmountLabel: UILabel!
    @IBOutlet weak var D2AmountLabel: UILabel!
    @IBOutlet weak var D3AmountLabel: UILabel!
    @IBOutlet weak var D4AmountLabel: UILabel!
    @IBOutlet weak var D5AmountLabel: UILabel!
    /*@IBOutlet weak var D6AmountLabel: UILabel!
    @IBOutlet weak var D7AmountLabel: UILabel!
    @IBOutlet weak var D8AmountLabel: UILabel!
    @IBOutlet weak var D9AmountLabel: UILabel!
    @IBOutlet weak var D10AmountLabel: UILabel!*/
    @IBOutlet weak var D11AmountLabel: UILabel!
    @IBOutlet weak var D12AmountLabel: UILabel!
    //@IBOutlet weak var D13AmountLabel: UILabel!
    @IBOutlet weak var D14AmountLabel: UILabel!
    @IBOutlet weak var D15AmountLabel: UILabel!

    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var WStatusButton: UIButton!
    @IBOutlet weak var SStatusButton: UIButton!
    @IBOutlet weak var PStatusButton: UIButton!
    @IBOutlet weak var DStatusButton: UIButton!

    @IBOutlet weak var orderTimeLabel: UILabel!
    @IBOutlet weak var dessertTimeLabel: UILabel!

    var orderNumber : String?
    var neworderNumber : String?
    var DBRef:DatabaseReference!

    var status : String?
    var WStatus : String?
    var PStatus : String?
    var SStatus : String?
    var DStatus : String?

    var W1Amount : String?
    //var W2Amount : String?
    var P1Amount : String?
    var P2Amount : String?
    var S1Amount : String?
    var S2Amount : String?
    //var S3Amount : String?
    var D1Amount : String?
    var D2Amount : String?
    var D3Amount : String?
    var D4Amount : String?
    var D5Amount : String?
    /*var D6Amount : String?
    var D7Amount : String?
    var D8Amount : String?
    var D9Amount : String?
    var D10Amount : String?*/
    var D11Amount : String?
    var D12Amount : String?
    //var D13Amount : String?
    var D14Amount : String?
    var D15Amount : String?

    var dateUnix: TimeInterval = 0
    var hogeTime : String?
    var hogeTime2 : String?


    @IBAction func Serve(_ sender: Any) {
        if Int(self.status!) == 1 || Int(self.status!) == 2{
            let alertController = UIAlertController(title: "配膳完了（デザート以外）",message: "タイマーセットしますか？", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
                self.DBRef.child("table/status").child(self.orderNumber!).setValue(3)
                self.DBRef.child("table/order").child(self.orderNumber!).child("completeTime").setValue(ServerValue.timestamp())
            }
            let cancelButton = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: nil)
            alertController.addAction(okAction)
            alertController.addAction(cancelButton)
            present(alertController,animated: true,completion: nil)

        }else if Int(self.status!) == 3{
            let alertController = UIAlertController(title: "配膳完了",message: "番号札は出しましたか？", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
                self.DBRef.child("table/status").child(self.orderNumber!).setValue(4)
                self.DBRef.child("table/WStatus").child(self.orderNumber!).setValue(0)
                self.DBRef.child("table/SStatus").child(self.orderNumber!).setValue(0)
                self.DBRef.child("table/PStatus").child(self.orderNumber!).setValue(0)
                self.DBRef.child("table/DStatus").child(self.orderNumber!).setValue(0)
                //オーダーキーのリセット
                var hogeKey : String?
                let defaultPlace = self.DBRef.child("table/orderKey").child(self.orderNumber!)
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
            self.DBRef.child("table/WStatus").child(orderNumber!).setValue(2)
        } else if Int(self.WStatus!) == 2{
            self.DBRef.child("table/WStatus").child(orderNumber!).setValue(1)
        }
    }
    @IBAction func SServe(_ sender: Any) {
        if Int(self.SStatus!) == 1 {
            self.DBRef.child("table/SStatus").child(orderNumber!).setValue(2)
        } else if Int(self.SStatus!) == 2{
            self.DBRef.child("table/SStatus").child(orderNumber!).setValue(1)
        }
    }
    @IBAction func PServe(_ sender: Any) {
        if Int(self.PStatus!) == 1 {
            self.DBRef.child("table/PStatus").child(orderNumber!).setValue(2)
        } else if Int(self.PStatus!) == 2{
            self.DBRef.child("table/PStatus").child(orderNumber!).setValue(1)
        }
    }
    @IBAction func DServe(_ sender: Any) {
        if Int(self.DStatus!) == 1 {
            self.DBRef.child("table/DStatus").child(orderNumber!).setValue(2)
        } else if Int(self.DStatus!) == 2{
            self.DBRef.child("table/DStatus").child(orderNumber!).setValue(1)
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        //インスタンスを作成
        DBRef = Database.database().reference()

        //デフォルト表示
        orderNumber = neworderNumber ?? "001"
        self.navigationItem.title = "Order " + orderNumber!

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
        let defaultPlaceW1 = DBRef.child("table/order").child(orderNumber!).child("W1Amount")
        defaultPlaceW1.observe(.value, with: { (snapshot) in
            self.W1Amount = (snapshot.value! as AnyObject).description
            self.W1AmountLabel.text = self.W1Amount!
        })
        /*let defaultPlaceW2 = DBRef.child("table/order").child(orderNumber!).child("W2Amount")
        defaultPlaceW2.observe(.value, with: { (snapshot) in
            self.W2Amount = (snapshot.value! as AnyObject).description
            self.W2AmountLabel.text = self.W2Amount!
        })*/
        let defaultPlaceS1 = DBRef.child("table/order").child(orderNumber!).child("S1Amount")
        defaultPlaceS1.observe(.value, with: { (snapshot) in
            self.S1Amount = (snapshot.value! as AnyObject).description
            self.S1AmountLabel.text = self.S1Amount!
        })
        let defaultPlaceS2 = DBRef.child("table/order").child(orderNumber!).child("S2Amount")
        defaultPlaceS2.observe(.value, with: { (snapshot) in
            self.S2Amount = (snapshot.value! as AnyObject).description
            self.S2AmountLabel.text = self.S2Amount!
        })
        /*let defaultPlaceS3 = DBRef.child("table/order").child(orderNumber!).child("S3Amount")
        defaultPlaceS3.observe(.value, with: { (snapshot) in
            self.S3Amount = (snapshot.value! as AnyObject).description
            self.S3AmountLabel.text = self.S3Amount!
        })*/
        let defaultPlaceP1 = DBRef.child("table/order").child(orderNumber!).child("P1Amount")
        defaultPlaceP1.observe(.value, with: { (snapshot) in
            self.P1Amount = (snapshot.value! as AnyObject).description
            self.P1AmountLabel.text = self.P1Amount!
        })
        let defaultPlaceP2 = DBRef.child("table/order").child(orderNumber!).child("P2Amount")
        defaultPlaceP2.observe(.value, with: { (snapshot) in
            self.P2Amount = (snapshot.value! as AnyObject).description
            self.P2AmountLabel.text = self.P2Amount!
        })
        let defaultPlaceD1 = DBRef.child("table/order").child(orderNumber!).child("D1Amount")
        defaultPlaceD1.observe(.value, with: { (snapshot) in
            self.D1Amount = (snapshot.value! as AnyObject).description
            self.D1AmountLabel.text = self.D1Amount!
        })
        let defaultPlaceD2 = DBRef.child("table/order").child(orderNumber!).child("D2Amount")
        defaultPlaceD2.observe(.value, with: { (snapshot) in
            self.D2Amount = (snapshot.value! as AnyObject).description
            self.D2AmountLabel.text = self.D2Amount!
        })
        let defaultPlaceD3 = DBRef.child("table/order").child(orderNumber!).child("D3Amount")
        defaultPlaceD3.observe(.value, with: { (snapshot) in
            self.D3Amount = (snapshot.value! as AnyObject).description
            self.D3AmountLabel.text = self.D3Amount!
        })
        let defaultPlaceD4 = DBRef.child("table/order").child(orderNumber!).child("D4Amount")
        defaultPlaceD4.observe(.value, with: { (snapshot) in
            self.D4Amount = (snapshot.value! as AnyObject).description
            self.D4AmountLabel.text = self.D4Amount!
        })
        let defaultPlaceD5 = DBRef.child("table/order").child(orderNumber!).child("D5Amount")
        defaultPlaceD5.observe(.value, with: { (snapshot) in
            self.D5Amount = (snapshot.value! as AnyObject).description
            self.D5AmountLabel.text = self.D5Amount!
        })
        /*let defaultPlaceD6 = DBRef.child("table/order").child(orderNumber!).child("D6Amount")
        defaultPlaceD6.observe(.value, with: { (snapshot) in
            self.D6Amount = (snapshot.value! as AnyObject).description
            self.D6AmountLabel.text = self.D6Amount!
        })
        let defaultPlaceD7 = DBRef.child("table/order").child(orderNumber!).child("D7Amount")
        defaultPlaceD7.observe(.value, with: { (snapshot) in
            self.D7Amount = (snapshot.value! as AnyObject).description
            self.D7AmountLabel.text = self.D7Amount!
        })
        let defaultPlaceD8 = DBRef.child("table/order").child(orderNumber!).child("D8Amount")
        defaultPlaceD8.observe(.value, with: { (snapshot) in
            self.D8Amount = (snapshot.value! as AnyObject).description
            self.D8AmountLabel.text = self.D8Amount!
        })
        let defaultPlaceD9 = DBRef.child("table/order").child(orderNumber!).child("D9Amount")
        defaultPlaceD9.observe(.value, with: { (snapshot) in
            self.D9Amount = (snapshot.value! as AnyObject).description
            self.D9AmountLabel.text = self.D9Amount!
        })
        let defaultPlaceD10 = DBRef.child("table/order").child(orderNumber!).child("D10Amount")
        defaultPlaceD10.observe(.value, with: { (snapshot) in
            self.D10Amount = (snapshot.value! as AnyObject).description
            self.D10AmountLabel.text = self.D10Amount!
        })*/
        let defaultPlaceD11 = DBRef.child("table/order").child(orderNumber!).child("D11Amount")
        defaultPlaceD11.observe(.value, with: { (snapshot) in
            self.D11Amount = (snapshot.value! as AnyObject).description
            self.D11AmountLabel.text = self.D11Amount!
        })
        let defaultPlaceD12 = DBRef.child("table/order").child(orderNumber!).child("D12Amount")
        defaultPlaceD12.observe(.value, with: { (snapshot) in
            self.D12Amount = (snapshot.value! as AnyObject).description
            self.D12AmountLabel.text = self.D12Amount!
        })
        /*let defaultPlaceD13 = DBRef.child("table/order").child(orderNumber!).child("D13Amount")
        defaultPlaceD13.observe(.value, with: { (snapshot) in
            self.D13Amount = (snapshot.value! as AnyObject).description
            self.D13AmountLabel.text = self.D13Amount!
        })*/
        let defaultPlaceD14 = DBRef.child("table/order").child(orderNumber!).child("D14Amount")
        defaultPlaceD14.observe(.value, with: { (snapshot) in
            self.D14Amount = (snapshot.value! as AnyObject).description
            self.D14AmountLabel.text = self.D14Amount!
        })
        let defaultPlaceD15 = DBRef.child("table/order").child(orderNumber!).child("D15Amount")
        defaultPlaceD15.observe(.value, with: { (snapshot) in
            self.D15Amount = (snapshot.value! as AnyObject).description
            self.D15AmountLabel.text = self.D15Amount!
        })

        //各カテゴリーの配膳状況表示
        let defaultPlace = DBRef.child("table/status").child(self.orderNumber!)
        defaultPlace.observe(.value, with: { snapshot in
            self.status = (snapshot.value! as AnyObject).description
            if Int(self.status!) == 0{
                self.statusButton.backgroundColor = UIColor.clear
            }else if Int(self.status!) == 1{
                self.statusButton.backgroundColor = UIColor(red:0.81, green:0.91, blue:0.92, alpha:1.0)
            }else if Int(self.status!) == 2{
                self.statusButton.backgroundColor = UIColor(red:0.96, green:0.87, blue:0.90, alpha:1.0)
            }else if Int(self.status!) == 3{
                self.statusButton.backgroundColor = UIColor(red:0.98, green:0.96, blue:0.70, alpha:1.0)
            }else if Int(self.status!) == 4{
                self.statusButton.backgroundColor = UIColor(red:0.87, green:0.91, blue:0.70, alpha:1.0)
            }
        })

        let defaultPlaceW = DBRef.child("table/WStatus").child(self.orderNumber!)
        defaultPlaceW.observe(.value, with: { snapshot in
            self.WStatus = (snapshot.value! as AnyObject).description
            if Int(self.WStatus!) == 1{
                self.WStatusButton.backgroundColor = UIColor(red:0.96, green:0.87, blue:0.90, alpha:1.0)
            }else if Int(self.WStatus!) == 2{
                self.WStatusButton.backgroundColor = UIColor(red:0.87, green:0.91, blue:0.70, alpha:1.0)
            }else{
                self.WStatusButton.backgroundColor = UIColor.clear
            }
        })
        let defaultPlaceS = DBRef.child("table/SStatus").child(self.orderNumber!)
        defaultPlaceS.observe(.value, with: { snapshot in
            self.SStatus = (snapshot.value! as AnyObject).description
            if Int(self.SStatus!) == 1{
                self.SStatusButton.backgroundColor = UIColor(red:0.96, green:0.87, blue:0.90, alpha:1.0)
            }else if Int(self.SStatus!) == 2{
                self.SStatusButton.backgroundColor = UIColor(red:0.87, green:0.91, blue:0.70, alpha:1.0)
            }else{
                self.SStatusButton.backgroundColor = UIColor.clear
            }
        })
        let defaultPlaceP = DBRef.child("table/PStatus").child(self.orderNumber!)
        defaultPlaceP.observe(.value, with: { snapshot in
            self.PStatus = (snapshot.value! as AnyObject).description
            if Int(self.PStatus!) == 1{
                self.PStatusButton.backgroundColor = UIColor(red:0.96, green:0.87, blue:0.90, alpha:1.0)
            }else if Int(self.PStatus!) == 2{
                self.PStatusButton.backgroundColor = UIColor(red:0.87, green:0.91, blue:0.70, alpha:1.0)
            }else{
                self.PStatusButton.backgroundColor = UIColor.clear
            }
        })
        let defaultPlaceD = DBRef.child("table/DStatus").child(self.orderNumber!)
        defaultPlaceD.observe(.value, with: { snapshot in
            self.DStatus = (snapshot.value! as AnyObject).description
            if Int(self.DStatus!) == 1{
                self.DStatusButton.backgroundColor = UIColor(red:0.96, green:0.87, blue:0.90, alpha:1.0)
            }else if Int(self.DStatus!) == 2{
                self.DStatusButton.backgroundColor = UIColor(red:0.87, green:0.91, blue:0.70, alpha:1.0)
            }else{
                self.DStatusButton.backgroundColor = UIColor.clear
            }
        })

        let defaultPlaceOT = DBRef.child("table/order").child(self.orderNumber!).child("time")
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
        let defaultPlaceCT = DBRef.child("table/order").child(self.orderNumber!).child("completeTime")
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
