//
//  OutFinishViewController.swift
//  kissa_accounting
//
//  Created by Tomohiro Hori on 2019/05/23.
//  Copyright © 2018 Kei Kawamura / 2019 Tomohiro Hori. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SwiftyDropbox

class OutRegisterViewController: UIViewController{

    var DBRef : DatabaseReference!
    var orderNumber : String?
    var neworderNumber : String?

    var proceeds : String?
    var intProceeds : Int?

    //ラベルのコネクション
    //@IBOutlet weak var W1AmountLabel: UILabel!
    @IBOutlet weak var W2AmountLabel: UILabel!
    @IBOutlet weak var S1AmountLabel: UILabel!
    @IBOutlet weak var S2AmountLabel: UILabel!
    //@IBOutlet weak var S3AmountLabel: UILabel!
    //@IBOutlet weak var P1AmountLabel: UILabel!
    //@IBOutlet weak var P2AmountLabel: UILabel!
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
    @IBOutlet weak var C1AmountLabel: UILabel!
    @IBOutlet weak var C3AmountLabel: UILabel!
    @IBOutlet weak var C10AmountLabel: UILabel!

    //@IBOutlet weak var W1StepperValue: UIStepper!
    @IBOutlet weak var W2StepperValue: UIStepper!
    //@IBOutlet weak var P1StepperValue: UIStepper!
    //@IBOutlet weak var P2StepperValue: UIStepper!
    @IBOutlet weak var S1StepperValue: UIStepper!
    @IBOutlet weak var S2StepperValue: UIStepper!
    //@IBOutlet weak var S3StepperValue: UIStepper!
    @IBOutlet weak var D1StepperValue: UIStepper!
    @IBOutlet weak var D2StepperValue: UIStepper!
    @IBOutlet weak var D3StepperValue: UIStepper!
    @IBOutlet weak var D4StepperValue: UIStepper!
    @IBOutlet weak var D5StepperValue: UIStepper!
     /*@IBOutlet weak var D6StepperValue: UIStepper!
     @IBOutlet weak var D7StepperValue: UIStepper!
     @IBOutlet weak var D8StepperValue: UIStepper!
     @IBOutlet weak var D9StepperValue: UIStepper!
     @IBOutlet weak var D10StepperValue: UIStepper!*/
    @IBOutlet weak var D11StepperValue: UIStepper!
    @IBOutlet weak var D12StepperValue: UIStepper!
    //@IBOutlet weak var D13StepperValue: UIStepper!
    @IBOutlet weak var D14StepperValue: UIStepper!
    @IBOutlet weak var D15StepperValue: UIStepper!
    @IBOutlet weak var C1StepperValue: UIStepper!
    @IBOutlet weak var C3StepperValue: UIStepper!
    @IBOutlet weak var C10StepperValue: UIStepper!

    //@IBOutlet weak var AllW1AmountLabel: UILabel!
    @IBOutlet weak var AllW2AmountLabel: UILabel!
    //@IBOutlet weak var AllP1AmountLabel: UILabel!
    //@IBOutlet weak var AllP2AmountLabel: UILabel!
    @IBOutlet weak var AllS1AmountLabel: UILabel!
    @IBOutlet weak var AllS2AmountLabel: UILabel!
    //@IBOutlet weak var AllS3AmountLabel: UILabel!
    @IBOutlet weak var AllD1AmountLabel: UILabel!
    @IBOutlet weak var AllD2AmountLabel: UILabel!
    @IBOutlet weak var AllD3AmountLabel: UILabel!
    @IBOutlet weak var AllD4AmountLabel: UILabel!
    @IBOutlet weak var AllD5AmountLabel: UILabel!
     /*@IBOutlet weak var AllD6AmountLabel: UILabel!
     @IBOutlet weak var AllD7AmountLabel: UILabel!
     @IBOutlet weak var AllD8AmountLabel: UILabel!
     @IBOutlet weak var AllD9AmountLabel: UILabel!
     @IBOutlet weak var AllD10AmountLabel: UILabel!*/
    @IBOutlet weak var AllD11AmountLabel: UILabel!
    @IBOutlet weak var AllD12AmountLabel: UILabel!
    //@IBOutlet weak var AllD13AmountLabel: UILabel!
    @IBOutlet weak var AllD14AmountLabel: UILabel!
    @IBOutlet weak var AllD15AmountLabel: UILabel!
    @IBOutlet weak var AllC1AmountLabel: UILabel!
    @IBOutlet weak var AllC3AmountLabel: UILabel!
    @IBOutlet weak var AllC10AmountLabel: UILabel!

    var status : String?
    //var status2 : String?
    // intstatus2 : Int?
    //var WStatus : String?
    //var PStatus : String?
    //var SStatus : String?
    //var DStatus : String?
    //var W1Amount : String?
    var W2Amount : String?
    //var P1Amount : String?
    //var P2Amount : String?
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
    var C1Amount : String?
    var C3Amount : String?
    var C10Amount : String?
    var totalWAmount : Int?
    //var totalPAmount : Int?
    var totalSAmount : Int?
    var totalDAmount : Int?
    //var hoge : String?
    var WAmount = 0
    //var PAmount = 0
    var SAmount = 0
    var DAmount = 0
    var DAmount1 = 0
    var DAmount2 = 0
    var DAmount3 = 0
    var DAmount4 = 0
    var CAmount1 = 0
    var CAmount3 = 0
    var CAmount10 = 0
    //var allW1Amount : String?
    var allW2Amount : String?
    //var allP1Amount : String?
    //var allP2Amount : String?
    var allS1Amount : String?
    var allS2Amount : String?
    //var allS3Amount : String?
    var allD1Amount : String?
    var allD2Amount : String?
    var allD3Amount : String?
    var allD4Amount : String?
    var allD5Amount : String?
     /*var allD6Amount : String?
     var allD7Amount : String?
     var allD8Amount : String?
     var allD9Amount : String?
     var allD10Amount : String?*/
    var allD11Amount : String?
    var allD12Amount : String?
    //var allD13Amount : String?
    var allD14Amount : String?
    var allD15Amount : String?
    var allC1Amount : String?
    var allC3Amount : String?
    var allC10Amount : String?
    //var newAllW1Amount : Int?
    var newAllW2Amount : Int?
    //var newAllP1Amount : Int?
    //var newAllP2Amount : Int?
    var newAllS1Amount : Int?
    var newAllS2Amount : Int?
    //var newAllS3Amount : Int?
    var newAllD1Amount : Int?
    var newAllD2Amount : Int?
    var newAllD3Amount : Int?
    var newAllD4Amount : Int?
    var newAllD5Amount : Int?
     /*var newAllD6Amount : Int?
     var newAllD7Amount : Int?
     var newAllD8Amount : Int?
     var newAllD9Amount : Int?
     var newAllD10Amount : Int?*/
    var newAllD11Amount : Int?
    var newAllD12Amount : Int?
    //var newAllD13Amount : Int?
    var newAllD14Amount : Int?
    var newAllD15Amount : Int?
    var newAllC1Amount : Int?
    var newAllC3Amount : Int?
    var newAllC10Amount : Int?


    //@IBOutlet weak var subTotalAmount: UILabel!
    //@IBOutlet weak var discountAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var tenderAmount: UILabel!
    @IBOutlet weak var changeAmount: UILabel!


    //Stepper
    /*@IBAction func W1Stepper(_ sender: UIStepper) {
     let Amount = Int(sender.value)
     W1AmountLabel.text = "\(Amount)"
     }*/
    @IBAction func W2Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        W2AmountLabel.text = "\(Amount)"
     }
    /*@IBAction func P1Stepper(_ sender: UIStepper) {
     let Amount = Int(sender.value)
     P1AmountLabel.text = "\(Amount)"
     }
     @IBAction func P2Stepper(_ sender: UIStepper) {
     let Amount = Int(sender.value)
     P2AmountLabel.text = "\(Amount)"
     }*/
    @IBAction func S1Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        S1AmountLabel.text = "\(Amount)"
    }
    @IBAction func S2Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        S2AmountLabel.text = "\(Amount)"
    }
    /*@IBAction func S3Stepper(_ sender: UIStepper) {
     let Amount = Int(sender.value)
     S3AmountLabel.text = "\(Amount)"
     }*/
    @IBAction func D1Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        D1AmountLabel.text = "\(Amount)"
    }
    @IBAction func D2Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        D2AmountLabel.text = "\(Amount)"
    }
    @IBAction func D3Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        D3AmountLabel.text = "\(Amount)"
    }
    @IBAction func D4Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        D4AmountLabel.text = "\(Amount)"
    }
    @IBAction func D5Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        D5AmountLabel.text = "\(Amount)"
    }
     /*@IBAction func D6Stepper(_ sender: UIStepper) {
     let Amount = Int(sender.value)
     D6AmountLabel.text = "\(Amount)"
     }
     @IBAction func D7Stepper(_ sender: UIStepper) {
     let Amount = Int(sender.value)
     D7AmountLabel.text = "\(Amount)"
     }
     @IBAction func D8Stepper(_ sender: UIStepper) {
     let Amount = Int(sender.value)
     D8AmountLabel.text = "\(Amount)"
     }
     @IBAction func D9Stepper(_ sender: UIStepper) {
     let Amount = Int(sender.value)
     D9AmountLabel.text = "\(Amount)"
     }
     @IBAction func D10Stepper(_ sender: UIStepper) {
     let Amount = Int(sender.value)
     D10AmountLabel.text = "\(Amount)"
     }*/
    @IBAction func D11Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        D11AmountLabel.text = "\(Amount)"
    }
    @IBAction func D12Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        D12AmountLabel.text = "\(Amount)"
    }
    /*@IBAction func D13Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        D13AmountLabel.text = "\(Amount)"
    }*/
    @IBAction func D14Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        D14AmountLabel.text = "\(Amount)"
    }
    @IBAction func D15Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        D15AmountLabel.text = "\(Amount)"
    }
    @IBAction func C1Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        C1AmountLabel.text = "\(Amount)"
    }
    @IBAction func C3Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        C3AmountLabel.text = "\(Amount)"
    }
    @IBAction func C10Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        C10AmountLabel.text = "\(Amount)"
    }


    //各ボタン機能
    @IBAction func add(_ sender: Any) {
        self.WAmount = Int(self.W2AmountLabel.text!)!
        //self.PAmount = Int(self.P1AmountLabel.text!)! + Int(self.P2AmountLabel.text!)!
        self.SAmount = Int(self.S1AmountLabel.text!)! + Int(self.S2AmountLabel.text!)!
        self.DAmount1 = Int(self.D1AmountLabel.text!)! + Int(self.D2AmountLabel.text!)!
        self.DAmount2 = Int(self.D3AmountLabel.text!)! + Int(self.D4AmountLabel.text!)! + Int(self.D5AmountLabel.text!)!
        self.DAmount3 = Int(self.D11AmountLabel.text!)! + Int(self.D12AmountLabel.text!)!
        self.DAmount4 = Int(self.D14AmountLabel.text!)! + Int(self.D15AmountLabel.text!)!
        self.DAmount = self.DAmount1 + self.DAmount2 + self.DAmount3 + self.DAmount4
        self.CAmount1 = Int(self.C1AmountLabel.text!)!
        self.CAmount3 = Int(self.C3AmountLabel.text!)!
        self.CAmount10 = Int(self.C10AmountLabel.text!)!

        totalAmount.text = "\(WAmount*250 + SAmount*200 + DAmount*150 + CAmount1*150 + CAmount3*400 + CAmount10*1200)"
    }


    @IBAction func numPad(_ sender: UIButton) {
        if tenderAmount.text == "0"{
            if sender.titleLabel!.text != "00"{
                tenderAmount.text = ""
                tenderAmount.text! += sender.titleLabel!.text!
                changeAmount.text = "\(Int(tenderAmount.text!)! - Int(totalAmount.text!)!)"
            }
        }else if sender.titleLabel!.text == "00"{
            if Int(tenderAmount.text!)!<1000{
                tenderAmount.text! += sender.titleLabel!.text!
                changeAmount.text = "\(Int(tenderAmount.text!)! - Int(totalAmount.text!)!)"
            }
        }else{
            if Int(tenderAmount.text!)!<10000{
                tenderAmount.text! += sender.titleLabel!.text!
                changeAmount.text = "\(Int(tenderAmount.text!)! - Int(totalAmount.text!)!)"
            }
        }
    }

    @IBAction func numPadClear(_ sender: Any) {
        tenderAmount.text = "0"
        changeAmount.text = "0"
    }

    @IBAction func check(_ sender: Any) {
        changeAmount.text = "\(Int(tenderAmount.text!)! - Int(totalAmount.text!)!)"
        let alertController = UIAlertController(title: "会計処理",message: "実行しますか？", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            self.DBRef.child("table/status").child(self.orderNumber!).observeSingleEvent(of: .value, with: { (snapshot) in
                self.status = (snapshot.value! as AnyObject).description
                if Int(self.status!)! != 0{
                    let alertController = UIAlertController(title: "会計が無効です",message: "すでに注文が入っています", preferredStyle: UIAlertController.Style.alert)
                    let OKButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
                        self.totalAmount.text = "0"
                        self.tenderAmount.text = "0"
                        self.changeAmount.text = "0"
                    }
                    alertController.addAction(OKButton)
                    self.present(alertController,animated: true,completion: nil)
                } else if Int(self.totalAmount.text!)! == 0{
                    let alertController = UIAlertController(title: "会計が無効です",message: "注文が入っていません", preferredStyle: UIAlertController.Style.alert)
                    let OKButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
                        /*self.WCheckAmount.text = "0"
                         self.WCheckStepper.value = 0
                         self.SCheckAmount.text = "0"
                         self.SCheckStepper.value = 0
                         self.PCheckAmount.text = "0"
                         self.PCheckStepper.value = 0
                         self.DCheckAmount.text = "0"
                         self.DCheckStepper.value = 0
                         self.totalAmount.text = "0"
                         self.tenderAmount.text = "0"
                         self.changeAmount.text = "0"*/
                    }
                    alertController.addAction(OKButton)
                    self.present(alertController,animated: true,completion: nil)
                } else if Int(self.tenderAmount.text!)! < Int(self.totalAmount.text!)! {
                    let alertController = UIAlertController(title: "会計が無効です",message: "預り金額が合計金額に達していません", preferredStyle: UIAlertController.Style.alert)
                    let OKButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
                        self.tenderAmount.text = "0"
                        self.changeAmount.text = "0"
                    }
                    alertController.addAction(OKButton)
                    self.present(alertController,animated: true,completion: nil)
                } else{
                    //お釣り表示・各種初期化
                    let alertController = UIAlertController(title: "お釣りは\(String(describing: self.changeAmount.text!))円です",message: "", preferredStyle: UIAlertController.Style.alert)
                    let OKButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
                        //オーダーの入力
                        //self.W1Amount = self.W1AmountLabel.text
                        self.W2Amount = self.W2AmountLabel.text
                        //self.P1Amount = self.P1AmountLabel.text
                        //self.P2Amount = self.P2AmountLabel.text
                        self.S1Amount = self.S1AmountLabel.text
                        self.S2Amount = self.S2AmountLabel.text
                        //self.S3Amount = self.S3AmountLabel.text
                        self.D1Amount = self.D1AmountLabel.text
                        self.D2Amount = self.D2AmountLabel.text
                        self.D3Amount = self.D3AmountLabel.text
                        self.D4Amount = self.D4AmountLabel.text
                        self.D5Amount = self.D5AmountLabel.text
                         /*self.D6Amount = self.D6AmountLabel.text
                         self.D7Amount = self.D7AmountLabel.text
                         self.D8Amount = self.D8AmountLabel.text
                         self.D9Amount = self.D9AmountLabel.text
                         self.D10Amount = self.D10AmountLabel.text*/
                        self.D11Amount = self.D11AmountLabel.text
                        self.D12Amount = self.D12AmountLabel.text
                        //self.D13Amount = self.D13AmountLabel.text
                        self.D14Amount = self.D14AmountLabel.text
                        self.D15Amount = self.D15AmountLabel.text
                        self.C1Amount = self.C1AmountLabel.text
                        self.C3Amount = self.C3AmountLabel.text
                        self.C10Amount = self.C10AmountLabel.text

                        self.totalWAmount = Int(self.W2Amount!)!
                        self.totalSAmount = Int(self.S1Amount!)! + Int(self.S2Amount!)!
                        //self.totalPAmount = Int(self.P1Amount!)! + Int(self.P2Amount!)!
                        self.totalDAmount = Int(self.D1Amount!)! + Int(self.D2Amount!)! + Int(self.D3Amount!)! + Int(self.D4Amount!)! + Int(self.D5Amount!)! + Int(self.D11Amount!)! + Int(self.D12Amount!)! + Int(self.D14Amount!)! + Int(self.D15Amount!)!

                        self.DBRef.child("table/order").child(self.orderNumber!).setValue(["W1Amount":0, "W2Amount":self.W2Amount!, "S1Amount":self.S1Amount!, "S2Amount":self.S2Amount!, "D1Amount":self.D1Amount!, "D2Amount":self.D2Amount!, "D3Amount":self.D3Amount!, "D4Amount":self.D4Amount!, "D5Amount":self.D5Amount!, "D11Amount":self.D11Amount!, "D12Amount":self.D12Amount!, "D14Amount":self.D14Amount!, "D15Amount":self.D15Amount!, "totalSAmount":self.totalSAmount!,  "totalDAmount":self.totalDAmount!, "C1Amount":self.C1Amount!, "C3Amount":self.C3Amount!, "C10Amount":self.C10Amount!, "time":ServerValue.timestamp()])
                        self.DBRef.child("table/status").child(self.orderNumber!).setValue(1)

                        //オーダーキーの設定
                        let key = self.DBRef.child("table/orderOrder").childByAutoId().key;
                        self.DBRef.child("table/orderOrder").child(key).setValue(self.orderNumber!)
                        self.DBRef.child("table/orderKey").child(self.orderNumber!).setValue(key)
                        //データセット
                        self.DBRef.child("inData").child(key).setValue(["time":ServerValue.timestamp(), "table":self.orderNumber!, "W1":0, "W2":self.W2Amount!, "S1":self.S1Amount!, "S2":self.S2Amount!, "D1":self.D1Amount!, "D2":self.D2Amount!,"D3":self.D3Amount!, "D4":self.D4Amount!, "D5":self.D5Amount!, "D11":self.D11Amount!, "D12":self.D12Amount!,"D14":self.D14Amount!, "D15":self.D15Amount!, "C1":self.C1Amount!, "C3":self.C3Amount!, "C10":self.C10Amount!])

                        //全食数の更新
                        /*let defaultPlaceW1 = self.DBRef.child("table/allOrder/allW1Amount")
                         defaultPlaceW1.observeSingleEvent(of: .value, with: { (snapshot) in
                         self.allW1Amount = (snapshot.value! as AnyObject).description
                         self.newAllW1Amount = Int(self.allW1Amount!)! - Int(self.W1Amount!)!
                         self.DBRef.child("table/allOrder/allW1Amount").setValue(self.newAllW1Amount)
                         })*/
                        let defaultPlaceW2 = self.DBRef.child("table/allOrder/allW2Amount")
                         defaultPlaceW2.observeSingleEvent(of: .value, with: { (snapshot) in
                         self.allW2Amount = (snapshot.value! as AnyObject).description
                         self.newAllW2Amount = Int(self.allW2Amount!)! - Int(self.W2Amount!)!
                         self.DBRef.child("table/allOrder/allW2Amount").setValue(self.newAllW2Amount)
                         })
                        /*let defaultPlaceP1 = self.DBRef.child("table/allOrder/allP1Amount")
                         defaultPlaceP1.observeSingleEvent(of: .value, with: { (snapshot) in
                         self.allP1Amount = (snapshot.value! as AnyObject).description
                         self.newAllP1Amount = Int(self.allP1Amount!)! - Int(self.P1Amount!)!
                         self.DBRef.child("table/allOrder/allP1Amount").setValue(self.newAllP1Amount)
                         })
                         let defaultPlaceP2 = self.DBRef.child("table/allOrder/allP2Amount")
                         defaultPlaceP2.observeSingleEvent(of: .value, with: { (snapshot) in
                         self.allP2Amount = (snapshot.value! as AnyObject).description
                         self.newAllP2Amount = Int(self.allP2Amount!)! - Int(self.P2Amount!)!
                         self.DBRef.child("table/allOrder/allP2Amount").setValue(self.newAllP2Amount)
                         })*/
                        let defaultPlaceS1 = self.DBRef.child("table/allOrder/allS1Amount")
                        defaultPlaceS1.observeSingleEvent(of: .value, with: { (snapshot) in
                            self.allS1Amount = (snapshot.value! as AnyObject).description
                            self.newAllS1Amount = Int(self.allS1Amount!)! - Int(self.S1Amount!)!
                            self.DBRef.child("table/allOrder/allS1Amount").setValue(self.newAllS1Amount)
                        })
                        let defaultPlaceS2 = self.DBRef.child("table/allOrder/allS2Amount")
                        defaultPlaceS2.observeSingleEvent(of: .value, with: { (snapshot) in
                            self.allS2Amount = (snapshot.value! as AnyObject).description
                            self.newAllS2Amount = Int(self.allS2Amount!)! - Int(self.S2Amount!)!
                            self.DBRef.child("table/allOrder/allS2Amount").setValue(self.newAllS2Amount)
                        })
                        /*let defaultPlaceS3 = self.DBRef.child("table/allOrder/allS3Amount")
                         defaultPlaceS3.observeSingleEvent(of: .value, with: { (snapshot) in
                         self.allS3Amount = (snapshot.value! as AnyObject).description
                         self.newAllS3Amount = Int(self.allS3Amount!)! - Int(self.S3Amount!)!
                         self.DBRef.child("table/allOrder/allS3Amount").setValue(self.newAllS3Amount)
                         })*/
                        let defaultPlaceD1 = self.DBRef.child("table/allOrder/allD1Amount")
                        defaultPlaceD1.observeSingleEvent(of: .value, with: { (snapshot) in
                            self.allD1Amount = (snapshot.value! as AnyObject).description
                            self.newAllD1Amount = Int(self.allD1Amount!)! - Int(self.D1Amount!)!
                            self.DBRef.child("table/allOrder/allD1Amount").setValue(self.newAllD1Amount)
                        })
                        let defaultPlaceD2 = self.DBRef.child("table/allOrder/allD2Amount")
                        defaultPlaceD2.observeSingleEvent(of: .value, with: { (snapshot) in
                            self.allD2Amount = (snapshot.value! as AnyObject).description
                            self.newAllD2Amount = Int(self.allD2Amount!)! - Int(self.D2Amount!)!
                            self.DBRef.child("table/allOrder/allD2Amount").setValue(self.newAllD2Amount)
                        })
                        let defaultPlaceD3 = self.DBRef.child("table/allOrder/allD3Amount")
                        defaultPlaceD3.observeSingleEvent(of: .value, with: { (snapshot) in
                            self.allD3Amount = (snapshot.value! as AnyObject).description
                            self.newAllD3Amount = Int(self.allD3Amount!)! - Int(self.D3Amount!)!
                            self.DBRef.child("table/allOrder/allD3Amount").setValue(self.newAllD3Amount)
                        })
                        let defaultPlaceD4 = self.DBRef.child("table/allOrder/allD4Amount")
                        defaultPlaceD4.observeSingleEvent(of: .value, with: { (snapshot) in
                            self.allD4Amount = (snapshot.value! as AnyObject).description
                            self.newAllD4Amount = Int(self.allD4Amount!)! - Int(self.D4Amount!)!
                            self.DBRef.child("table/allOrder/allD4Amount").setValue(self.newAllD4Amount)
                        })
                        let defaultPlaceD5 = self.DBRef.child("table/allOrder/allD5Amount")
                            defaultPlaceD5.observeSingleEvent(of: .value, with: { (snapshot) in
                                self.allD5Amount = (snapshot.value! as AnyObject).description
                                self.newAllD5Amount = Int(self.allD5Amount!)! - Int(self.D5Amount!)!
                                self.DBRef.child("table/allOrder/allD5Amount").setValue(self.newAllD5Amount)
                        })
                         /*let defaultPlaceD6 = self.DBRef.child("table/allOrder/allD6Amount")
                         defaultPlaceD6.observeSingleEvent(of: .value, with: { (snapshot) in
                         self.allD6Amount = (snapshot.value! as AnyObject).description
                         self.newAllD6Amount = Int(self.allD6Amount!)! - Int(self.D6Amount!)!
                         self.DBRef.child("table/allOrder/allD6Amount").setValue(self.newAllD6Amount)
                         })
                         let defaultPlaceD7 = self.DBRef.child("table/allOrder/allD7Amount")
                         defaultPlaceD7.observeSingleEvent(of: .value, with: { (snapshot) in
                         self.allD7Amount = (snapshot.value! as AnyObject).description
                         self.newAllD7Amount = Int(self.allD7Amount!)! - Int(self.D7Amount!)!
                         self.DBRef.child("table/allOrder/allD7Amount").setValue(self.newAllD7Amount)
                         })
                         let defaultPlaceD8 = self.DBRef.child("table/allOrder/allD8Amount")
                         defaultPlaceD8.observeSingleEvent(of: .value, with: { (snapshot) in
                         self.allD8Amount = (snapshot.value! as AnyObject).description
                         self.newAllD8Amount = Int(self.allD8Amount!)! - Int(self.D8Amount!)!
                         self.DBRef.child("table/allOrder/allD8Amount").setValue(self.newAllD8Amount)
                         })
                         let defaultPlaceD9 = self.DBRef.child("table/allOrder/allD9Amount")
                         defaultPlaceD9.observeSingleEvent(of: .value, with: { (snapshot) in
                         self.allD9Amount = (snapshot.value! as AnyObject).description
                         self.newAllD9Amount = Int(self.allD9Amount!)! - Int(self.D9Amount!)!
                         self.DBRef.child("table/allOrder/allD9Amount").setValue(self.newAllD9Amount)
                         })
                         let defaultPlaceD10 = self.DBRef.child("table/allOrder/allD10Amount")
                         defaultPlaceD10.observeSingleEvent(of: .value, with: { (snapshot) in
                         self.allD10Amount = (snapshot.value! as AnyObject).description
                         self.newAllD10Amount = Int(self.allD10Amount!)! - Int(self.D10Amount!)!
                         self.DBRef.child("table/allOrder/allD10Amount").setValue(self.newAllD10Amount)
                         })*/
                        let defaultPlaceD11 = self.DBRef.child("table/allOrder/allD11Amount")
                        defaultPlaceD11.observeSingleEvent(of: .value, with: { (snapshot) in
                            self.allD11Amount = (snapshot.value! as AnyObject).description
                            self.newAllD11Amount = Int(self.allD11Amount!)! - Int(self.D11Amount!)!
                            self.DBRef.child("table/allOrder/allD11Amount").setValue(self.newAllD11Amount)
                        })
                        let defaultPlaceD12 = self.DBRef.child("table/allOrder/allD12Amount")
                        defaultPlaceD12.observeSingleEvent(of: .value, with: { (snapshot) in
                            self.allD12Amount = (snapshot.value! as AnyObject).description
                            self.newAllD12Amount = Int(self.allD12Amount!)! - Int(self.D12Amount!)!
                            self.DBRef.child("table/allOrder/allD12Amount").setValue(self.newAllD12Amount)
                        })
                        /*let defaultPlaceD13 = self.DBRef.child("table/allOrder/allD13Amount")
                        defaultPlaceD13.observeSingleEvent(of: .value, with: { (snapshot) in
                            self.allD13Amount = (snapshot.value! as AnyObject).description
                            self.newAllD13Amount = Int(self.allD13Amount!)! - Int(self.D13Amount!)!
                            self.DBRef.child("table/allOrder/allD13Amount").setValue(self.newAllD13Amount)
                        })*/
                        let defaultPlaceD14 = self.DBRef.child("table/allOrder/allD14Amount")
                        defaultPlaceD14.observeSingleEvent(of: .value, with: { (snapshot) in
                            self.allD14Amount = (snapshot.value! as AnyObject).description
                            self.newAllD14Amount = Int(self.allD14Amount!)! - Int(self.D14Amount!)!
                            self.DBRef.child("table/allOrder/allD14Amount").setValue(self.newAllD14Amount)
                        })
                        let defaultPlaceD15 = self.DBRef.child("table/allOrder/allD15Amount")
                        defaultPlaceD15.observeSingleEvent(of: .value, with: { (snapshot) in
                            self.allD15Amount = (snapshot.value! as AnyObject).description
                            self.newAllD15Amount = Int(self.allD15Amount!)! - Int(self.D15Amount!)!
                            self.DBRef.child("table/allOrder/allD15Amount").setValue(self.newAllD15Amount)
                        })
                        let defaultPlaceC1 = self.DBRef.child("table/allOrder/allC1Amount")
                        defaultPlaceC1.observeSingleEvent(of: .value, with: { (snapshot) in
                            self.allC1Amount = (snapshot.value! as AnyObject).description
                            self.newAllC1Amount = Int(self.allC1Amount!)! - Int(self.C1Amount!)!
                            self.DBRef.child("table/allOrder/allC1Amount").setValue(self.newAllC1Amount)
                        })
                        let defaultPlaceC3 = self.DBRef.child("table/allOrder/allC3Amount")
                        defaultPlaceC3.observeSingleEvent(of: .value, with: { (snapshot) in
                            self.allC3Amount = (snapshot.value! as AnyObject).description
                            self.newAllC3Amount = Int(self.allC3Amount!)! - Int(self.C3Amount!)!
                            self.DBRef.child("table/allOrder/allC3Amount").setValue(self.newAllC3Amount)
                        })
                        let defaultPlaceC10 = self.DBRef.child("table/allOrder/allC10Amount")
                        defaultPlaceC10.observeSingleEvent(of: .value, with: { (snapshot) in
                            self.allC10Amount = (snapshot.value! as AnyObject).description
                            self.newAllC10Amount = Int(self.allC10Amount!)! - Int(self.C10Amount!)!
                            self.DBRef.child("table/allOrder/allC10Amount").setValue(self.newAllC10Amount)
                        })
                        //レシート印刷機能
                        //TODO: ADD COOKIE TO RECIEPT
                        var hogeKey : String?
                        let defaultPlace = self.DBRef.child("table/orderKey").child(self.orderNumber!)
                        defaultPlace.observeSingleEvent(of: .value, with: { (snapshot) in
                            hogeKey = (snapshot.value! as AnyObject).description
                            guard let client = DropboxClientsManager.authorizedClient else {
                                return}
                            let fileData = "\(self.orderNumber!),/\(hogeKey!)/,\(self.WAmount),\(self.SAmount),\(self.DAmount),\(self.CAmount1),\(self.CAmount3),\(self.CAmount10),\(self.tenderAmount.text!)".data(using: String.Encoding.utf8, allowLossyConversion: false)!
                            _ = client.files.deleteV2(path: "/kissa2019.system.register/Data/receiptOut.csv")
                                .response{ response, error in
                                    if let response = response {
                                        print(response)
                                    }else if let error = error {
                                        print(error)
                                    }
                            }

                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                _ = client.files.upload(path:"/kissa2019.system.register/Data/receiptOut.csv", input: fileData)
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

                            //全食数の更新
                            let defaultPlaceX = self.DBRef.child("inProceeds")
                            defaultPlaceX.observeSingleEvent(of: .value, with: { (snapshot) in
                                self.proceeds = (snapshot.value! as AnyObject).description
                                self.intProceeds = Int(self.proceeds!)! + Int(self.totalAmount.text!)!
                                self.DBRef.child("inProceeds").setValue(self.intProceeds)
                                self.totalAmount.text = "0"
                                self.tenderAmount.text = "0"
                                self.changeAmount.text = "0"
                            })
                        })
                    }
                    alertController.addAction(OKButton)
                    self.present(alertController,animated: true,completion: nil)
                }
            })

        }
        let cancelButton = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelButton)
        present(alertController,animated: true,completion: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        //インスタンスを作成
        DBRef = Database.database().reference()

        //デフォルト表示
        orderNumber = neworderNumber ?? "101"
        self.navigationItem.title = "Order " + orderNumber!

        Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(self.amountload(_:)),
            userInfo: nil,
            repeats: false
        )
    }

    @objc func amountload(_ sender: Timer) {
        //初期値取得
        /*let defaultPlaceW1 = DBRef.child("table/order").child(orderNumber!).child("W1Amount")
         defaultPlaceW1.observeSingleEvent(of: .value, with: { (snapshot) in self.W1Amount = (snapshot.value! as AnyObject).description
         self.W1AmountLabel.text = self.W1Amount!
         self.W1StepperValue.value = Double(Int(self.W1Amount!)!)
         })*/
        let defaultPlaceW2 = DBRef.child("table/order").child(orderNumber!).child("W2Amount")
         defaultPlaceW2.observeSingleEvent(of: .value, with: { (snapshot) in self.W2Amount = (snapshot.value! as AnyObject).description
         self.W2AmountLabel.text = self.W2Amount!
         self.W2StepperValue.value = Double(Int(self.W2Amount!)!)
         })
        /*let defaultPlaceP1 = DBRef.child("table/order").child(orderNumber!).child("P1Amount")
         defaultPlaceP1.observeSingleEvent(of: .value, with: { (snapshot) in self.P1Amount = (snapshot.value! as AnyObject).description
         self.P1AmountLabel.text = self.P1Amount!
         self.P1StepperValue.value = Double(Int(self.P1Amount!)!)
         })
         let defaultPlaceP2 = DBRef.child("table/order").child(orderNumber!).child("P2Amount")
         defaultPlaceP2.observeSingleEvent(of: .value, with: { (snapshot) in self.P2Amount = (snapshot.value! as AnyObject).description
         self.P2AmountLabel.text = self.P2Amount!
         self.P2StepperValue.value = Double(Int(self.P2Amount!)!)
         })*/
        let defaultPlaceS1 = DBRef.child("table/order").child(orderNumber!).child("S1Amount")
        defaultPlaceS1.observeSingleEvent(of: .value, with: { (snapshot) in self.S1Amount = (snapshot.value! as AnyObject).description
            self.S1AmountLabel.text = self.S1Amount!
            self.S1StepperValue.value = Double(Int(self.S1Amount!)!)
        })
        let defaultPlaceS2 = DBRef.child("table/order").child(orderNumber!).child("S2Amount")
        defaultPlaceS2.observeSingleEvent(of: .value, with: { (snapshot) in self.S2Amount = (snapshot.value! as AnyObject).description
            self.S2AmountLabel.text = self.S2Amount!
            self.S2StepperValue.value = Double(Int(self.S2Amount!)!)
        })
        /*let defaultPlaceS3 = DBRef.child("table/order").child(orderNumber!).child("S3Amount")
         defaultPlaceS3.observeSingleEvent(of: .value, with: { (snapshot) in self.S3Amount = (snapshot.value! as AnyObject).description
         self.S3AmountLabel.text = self.S3Amount!
         self.S3StepperValue.value = Double(Int(self.S3Amount!)!)
         })*/
        let defaultPlaceD1 = DBRef.child("table/order").child(orderNumber!).child("D1Amount")
        defaultPlaceD1.observeSingleEvent(of: .value, with: { (snapshot) in self.D1Amount = (snapshot.value! as AnyObject).description
            self.D1AmountLabel.text = self.D1Amount!
            self.D1StepperValue.value = Double(Int(self.D1Amount!)!)
        })
        let defaultPlaceD2 = DBRef.child("table/order").child(orderNumber!).child("D2Amount")
        defaultPlaceD2.observeSingleEvent(of: .value, with: { (snapshot) in self.D2Amount = (snapshot.value! as AnyObject).description
            self.D2AmountLabel.text = self.D2Amount!
            self.D2StepperValue.value = Double(Int(self.D2Amount!)!)
        })
        let defaultPlaceD3 = DBRef.child("table/order").child(orderNumber!).child("D3Amount")
        defaultPlaceD3.observeSingleEvent(of: .value, with: { (snapshot) in self.D3Amount = (snapshot.value! as AnyObject).description
            self.D3AmountLabel.text = self.D3Amount!
            self.D3StepperValue.value = Double(Int(self.D3Amount!)!)
        })
        let defaultPlaceD4 = DBRef.child("table/order").child(orderNumber!).child("D4Amount")
        defaultPlaceD4.observeSingleEvent(of: .value, with: { (snapshot) in self.D4Amount = (snapshot.value! as AnyObject).description
            self.D4AmountLabel.text = self.D4Amount!
            self.D4StepperValue.value = Double(Int(self.D4Amount!)!)
        })
        let defaultPlaceD5 = DBRef.child("table/order").child(orderNumber!).child("D5Amount")
        defaultPlaceD5.observeSingleEvent(of: .value, with: { (snapshot) in self.D5Amount = (snapshot.value! as AnyObject).description
            self.D5AmountLabel.text = self.D5Amount!
            self.D5StepperValue.value = Double(Int(self.D5Amount!)!)
        })
         /*let defaultPlaceD6 = DBRef.child("table/order").child(orderNumber!).child("D6Amount")
         defaultPlaceD6.observeSingleEvent(of: .value, with: { (snapshot) in self.D6Amount = (snapshot.value! as AnyObject).description
         self.D6AmountLabel.text = self.D6Amount!
         self.D6StepperValue.value = Double(Int(self.D6Amount!)!)
         })
         let defaultPlaceD7 = DBRef.child("table/order").child(orderNumber!).child("D7Amount")
         defaultPlaceD7.observeSingleEvent(of: .value, with: { (snapshot) in self.D7Amount = (snapshot.value! as AnyObject).description
         self.D7AmountLabel.text = self.D7Amount!
         self.D7StepperValue.value = Double(Int(self.D7Amount!)!)
         })
         let defaultPlaceD8 = DBRef.child("table/order").child(orderNumber!).child("D8Amount")
         defaultPlaceD8.observeSingleEvent(of: .value, with: { (snapshot) in self.D8Amount = (snapshot.value! as AnyObject).description
         self.D8AmountLabel.text = self.D8Amount!
         self.D8StepperValue.value = Double(Int(self.D8Amount!)!)
         })
         let defaultPlaceD9 = DBRef.child("table/order").child(orderNumber!).child("D9Amount")
         defaultPlaceD9.observeSingleEvent(of: .value, with: { (snapshot) in self.D9Amount = (snapshot.value! as AnyObject).description
         self.D9AmountLabel.text = self.D9Amount!
         self.D9StepperValue.value = Double(Int(self.D9Amount!)!)
         })
         let defaultPlaceD10 = DBRef.child("table/order").child(orderNumber!).child("D10Amount")
         defaultPlaceD10.observeSingleEvent(of: .value, with: { (snapshot) in self.D10Amount = (snapshot.value! as AnyObject).description
         self.D10AmountLabel.text = self.D10Amount!
         self.D10StepperValue.value = Double(Int(self.D10Amount!)!)
         })*/
        let defaultPlaceD11 = DBRef.child("table/order").child(orderNumber!).child("D11Amount")
        defaultPlaceD11.observeSingleEvent(of: .value, with: { (snapshot) in
            self.D11Amount = (snapshot.value! as AnyObject).description
            self.D11AmountLabel.text = self.D11Amount!
            self.D11StepperValue.value = Double(Int(self.D11Amount!)!)
        })
        let defaultPlaceD12 = DBRef.child("table/order").child(orderNumber!).child("D12Amount")
        defaultPlaceD12.observeSingleEvent(of: .value, with: { (snapshot) in
            self.D12Amount = (snapshot.value! as AnyObject).description
            self.D12AmountLabel.text = self.D12Amount!
            self.D12StepperValue.value = Double(Int(self.D12Amount!)!)
        })
        /*let defaultPlaceD13 = DBRef.child("table/order").child(orderNumber!).child("D13Amount")
        defaultPlaceD13.observeSingleEvent(of: .value, with: { (snapshot) in
            self.D13Amount = (snapshot.value! as AnyObject).description
            self.D13AmountLabel.text = self.D13Amount!
            self.D13StepperValue.value = Double(Int(self.D13Amount!)!)
        })*/
        let defaultPlaceD14 = DBRef.child("table/order").child(orderNumber!).child("D14Amount")
        defaultPlaceD14.observeSingleEvent(of: .value, with: { (snapshot) in
            self.D14Amount = (snapshot.value! as AnyObject).description
            self.D14AmountLabel.text = self.D14Amount!
            self.D14StepperValue.value = Double(Int(self.D14Amount!)!)
        })
        let defaultPlaceD15 = DBRef.child("table/order").child(orderNumber!).child("D15Amount")
        defaultPlaceD15.observeSingleEvent(of: .value, with: { (snapshot) in
            self.D15Amount = (snapshot.value! as AnyObject).description
            self.D15AmountLabel.text = self.D15Amount!
            self.D15StepperValue.value = Double(Int(self.D15Amount!)!)
        })
        let defaultPlaceC1 = DBRef.child("table/order").child(orderNumber!).child("C1Amount")
        defaultPlaceC1.observeSingleEvent(of: .value, with: { (snapshot) in
            self.C1Amount = (snapshot.value! as AnyObject).description
            self.C1AmountLabel.text = self.C1Amount!
            self.C1StepperValue.value = Double(Int(self.C1Amount!)!)
        })
        let defaultPlaceC3 = DBRef.child("table/order").child(orderNumber!).child("C3Amount")
        defaultPlaceC3.observeSingleEvent(of: .value, with: { (snapshot) in
            self.C3Amount = (snapshot.value! as AnyObject).description
            self.C3AmountLabel.text = self.C3Amount!
            self.C3StepperValue.value = Double(Int(self.C3Amount!)!)
        })
        let defaultPlaceC10 = DBRef.child("table/order").child(orderNumber!).child("C10Amount")
        defaultPlaceC10.observeSingleEvent(of: .value, with: { (snapshot) in
            self.C10Amount = (snapshot.value! as AnyObject).description
            self.C10AmountLabel.text = self.C10Amount!
            self.C10StepperValue.value = Double(Int(self.C10Amount!)!)
        })

        //全食数の取得
        /*let defaultPlaceW12 = self.DBRef.child("table/allOrder/allW1Amount")
         defaultPlaceW12.observe(.value, with: { snapshot in
         self.AllW1AmountLabel.text = (snapshot.value! as AnyObject).description
         })*/
        let defaultPlaceW22 = self.DBRef.child("table/allOrder/allW2Amount")
         defaultPlaceW22.observe(.value, with: { snapshot in
         self.AllW2AmountLabel.text = (snapshot.value! as AnyObject).description
         })
        /*let defaultPlaceP12 = self.DBRef.child("table/allOrder/allP1Amount")
         defaultPlaceP12.observe(.value, with: { snapshot in
         self.AllP1AmountLabel.text = (snapshot.value! as AnyObject).description
         })
         let defaultPlaceP22 = self.DBRef.child("table/allOrder/allP2Amount")
         defaultPlaceP22.observe(.value, with: { snapshot in
         self.AllP2AmountLabel.text = (snapshot.value! as AnyObject).description
         })*/
        let defaultPlaceS12 = self.DBRef.child("table/allOrder/allS1Amount")
        defaultPlaceS12.observe(.value, with: { snapshot in
            self.AllS1AmountLabel.text = (snapshot.value! as AnyObject).description
        })
        let defaultPlaceS22 = self.DBRef.child("table/allOrder/allS2Amount")
        defaultPlaceS22.observe(.value, with: { snapshot in
            self.AllS2AmountLabel.text = (snapshot.value! as AnyObject).description
        })
        /*let defaultPlaceS32 = self.DBRef.child("table/allOrder/allS3Amount")
         defaultPlaceS32.observe(.value, with: { snapshot in
         self.AllS3AmountLabel.text = (snapshot.value! as AnyObject).description
         })*/
        let defaultPlaceD012 = self.DBRef.child("table/allOrder/allD1Amount")
        defaultPlaceD012.observe(.value, with: { snapshot in
            self.AllD1AmountLabel.text = (snapshot.value! as AnyObject).description
        })
        let defaultPlaceD22 = self.DBRef.child("table/allOrder/allD2Amount")
        defaultPlaceD22.observe(.value, with: { snapshot in
            self.AllD2AmountLabel.text = (snapshot.value! as AnyObject).description
        })
        let defaultPlaceD32 = self.DBRef.child("table/allOrder/allD3Amount")
        defaultPlaceD32.observe(.value, with: { snapshot in
            self.AllD3AmountLabel.text = (snapshot.value! as AnyObject).description
        })
        let defaultPlaceD42 = self.DBRef.child("table/allOrder/allD4Amount")
        defaultPlaceD42.observe(.value, with: { snapshot in
            self.AllD4AmountLabel.text = (snapshot.value! as AnyObject).description
        })
        let defaultPlaceD52 = self.DBRef.child("table/allOrder/allD5Amount")
            defaultPlaceD52.observe(.value, with: { snapshot in
            self.AllD5AmountLabel.text = (snapshot.value! as AnyObject).description
        })
         /*let defaultPlaceD62 = self.DBRef.child("table/allOrder/allD6Amount")
         defaultPlaceD62.observe(.value, with: { snapshot in
         self.AllD6AmountLabel.text = (snapshot.value! as AnyObject).description
         })
         let defaultPlaceD72 = self.DBRef.child("table/allOrder/allD7Amount")
         defaultPlaceD72.observe(.value, with: { snapshot in
         self.AllD7AmountLabel.text = (snapshot.value! as AnyObject).description
         })
         let defaultPlaceD82 = self.DBRef.child("table/allOrder/allD8Amount")
         defaultPlaceD82.observe(.value, with: { snapshot in
         self.AllD8AmountLabel.text = (snapshot.value! as AnyObject).description
         })
         let defaultPlaceD92 = self.DBRef.child("table/allOrder/allD9Amount")
         defaultPlaceD92.observe(.value, with: { snapshot in
         self.AllD9AmountLabel.text = (snapshot.value! as AnyObject).description
         })
         let defaultPlaceD102 = self.DBRef.child("table/allOrder/allD10Amount")
         defaultPlaceD102.observe(.value, with: { snapshot in
         self.AllD10AmountLabel.text = (snapshot.value! as AnyObject).description
         })*/
        let defaultPlaceD112 = self.DBRef.child("table/allOrder/allD11Amount")
        defaultPlaceD112.observe(.value, with: { snapshot in
            self.AllD11AmountLabel.text = (snapshot.value! as AnyObject).description
        })
        let defaultPlaceD122 = self.DBRef.child("table/allOrder/allD12Amount")
        defaultPlaceD122.observe(.value, with: { snapshot in
            self.AllD12AmountLabel.text = (snapshot.value! as AnyObject).description
        })
        /*let defaultPlaceD132 = self.DBRef.child("table/allOrder/allD13Amount")
        defaultPlaceD132.observe(.value, with: { snapshot in
            self.AllD13AmountLabel.text = (snapshot.value! as AnyObject).description
        })*/
        let defaultPlaceD142 = self.DBRef.child("table/allOrder/allD14Amount")
        defaultPlaceD142.observe(.value, with: { snapshot in
            self.AllD14AmountLabel.text = (snapshot.value! as AnyObject).description
        })
        let defaultPlaceD152 = self.DBRef.child("table/allOrder/allD15Amount")
        defaultPlaceD152.observe(.value, with: { snapshot in
            self.AllD15AmountLabel.text = (snapshot.value! as AnyObject).description
        })
        let defaultPlaceC12 = self.DBRef.child("table/allOrder/allC1Amount")
        defaultPlaceC12.observe(.value, with: { snapshot in
            self.AllC1AmountLabel.text = (snapshot.value! as AnyObject).description
        })
        let defaultPlaceC32 = self.DBRef.child("table/allOrder/allC3Amount")
        defaultPlaceC32.observe(.value, with: { snapshot in
            self.AllC3AmountLabel.text = (snapshot.value! as AnyObject).description
        })
        let defaultPlaceC102 = self.DBRef.child("table/allOrder/allC10Amount")
        defaultPlaceC102.observe(.value, with: { snapshot in
            self.AllC10AmountLabel.text = (snapshot.value! as AnyObject).description
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
