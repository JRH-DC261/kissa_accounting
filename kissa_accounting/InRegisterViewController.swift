//
//  InFinishViewController.swift
//  kissa_accounting
//
//  Created by Tomohiro Hori on 2019/03/21.
//  Copyright © 2018 Kei Kawamura / 2019 Tomohiro Hori. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SwiftyDropbox

class InRegisterViewController: UIViewController{
    var DBRef : DatabaseReference!
    var orderNumber : String?
    var neworderNumber : String?

    var proceeds : String?
    var intProceeds : Int?

    @IBOutlet weak var WRemainAmount: UILabel!
    @IBOutlet weak var SRemainAmount: UILabel!
    @IBOutlet weak var PRemainAmount: UILabel!
    @IBOutlet weak var DRemainAmount: UILabel!

    @IBOutlet weak var WCheckAmount: UILabel!
    @IBOutlet weak var SCheckAmount: UILabel!
    @IBOutlet weak var PCheckAmount: UILabel!
    @IBOutlet weak var DCheckAmount: UILabel!

    @IBOutlet weak var WCheckStepper: UIStepper!
    @IBOutlet weak var SCheckStepper: UIStepper!
    @IBOutlet weak var PCheckStepper: UIStepper!
    @IBOutlet weak var DCheckStepper: UIStepper!

    @IBOutlet weak var C1AmountLabel: UILabel!
    @IBOutlet weak var C3AmountLabel: UILabel!
    @IBOutlet weak var C10AmountLabel: UILabel!

    @IBOutlet weak var C1StepperValue: UIStepper!
    @IBOutlet weak var C3StepperValue: UIStepper!
    @IBOutlet weak var C10StepperValue: UIStepper!

    @IBOutlet weak var AllC1AmountLabel: UILabel!
    @IBOutlet weak var AllC3AmountLabel: UILabel!
    @IBOutlet weak var AllC10AmountLabel: UILabel!

    var C1Amount : String?
    var C3Amount : String?
    var C10Amount : String?

    var allC1Amount : String?
    var allC3Amount : String?
    var allC10Amount : String?

    var newAllC1Amount : Int?
    var newAllC3Amount : Int?
    var newAllC10Amount : Int?


    //@IBOutlet weak var subTotalAmount: UILabel!
    //@IBOutlet weak var discountAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var tenderAmount: UILabel!
    @IBOutlet weak var changeAmount: UILabel!


    //let number = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40"];
    var tableStatus : String?


    @IBAction func add(_ sender: Any) {
        totalAmount.text = "\(Int(WCheckStepper.value)*400 + Int(SCheckStepper.value)*200 + Int(PCheckStepper.value)*400 + Int(DCheckStepper.value)*200 + Int(C1StepperValue.value)*150 + Int(C3StepperValue.value)*400 + Int(C10StepperValue.value)*1200)"
    }

    @IBAction func WStepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        WCheckAmount.text = "\(Amount)"
        //totalAmount.text = "\(Int(WCheckStepper.value)*400 + Int(SCheckStepper.value)*200 + Int(PCheckStepper.value)*400 + Int(DCheckStepper.value)*100)"
        //subTotalAmount.text = "\(Int(WCheckStepper.value)*400 + Int(SCheckStepper.value)*200 + Int(PCheckStepper.value)*400 + Int(DCheckStepper.value)*100)"
        //discountAmount.text = "\((min(Int(WCheckStepper.value),Int(SCheckStepper.value),Int(DCheckStepper.value)) + min(Int(PCheckStepper.value),Int(SCheckStepper.value),Int(DCheckStepper.value)))*100)"
        //totalAmount.text = "\(Int(subTotalAmount.text!)! - Int(discountAmount.text!)!)"
    }
    @IBAction func SStepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        SCheckAmount.text = "\(Amount)"
        //totalAmount.text = "\(Int(WCheckStepper.value)*400 + Int(SCheckStepper.value)*200 + Int(PCheckStepper.value)*400 + Int(DCheckStepper.value)*100)"
    }
    @IBAction func PStepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        PCheckAmount.text = "\(Amount)"
        //totalAmount.text = "\(Int(WCheckStepper.value)*400 + Int(SCheckStepper.value)*200 + Int(PCheckStepper.value)*400 + Int(DCheckStepper.value)*100)"
    }
    @IBAction func DStepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        DCheckAmount.text = "\(Amount)"
        //totalAmount.text = "\(Int(WCheckStepper.value)*400 + Int(SCheckStepper.value)*200 + Int(PCheckStepper.value)*400 + Int(DCheckStepper.value)*100)"
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

    @IBAction func checkAll(_ sender: Any) {
        WCheckAmount.text = WRemainAmount.text
        WCheckStepper.value = Double(Int(WRemainAmount.text!)!)
        SCheckAmount.text = SRemainAmount.text
        SCheckStepper.value = Double(Int(SRemainAmount.text!)!)
        PCheckAmount.text = PRemainAmount.text
        PCheckStepper.value = Double(Int(PRemainAmount.text!)!)
        DCheckAmount.text = DRemainAmount.text
        DCheckStepper.value = Double(Int(DRemainAmount.text!)!)
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

    //    @IBAction func change(_ sender: Any) {
    //        changeAmount.text = "\(Int(tenderAmount.text!)!-Int(totalAmount.text!)!)"
    //    }

    @IBAction func check(_ sender: Any) {
        //totalAmount.text = "\(Int(subTotalAmount.text!)! - Int(discountAmount.text!)!)"
        changeAmount.text = "\(Int(tenderAmount.text!)! - Int(totalAmount.text!)!)"
        let alertController = UIAlertController(title: "会計処理",message: "実行しますか？", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            if Int(self.WRemainAmount.text!)! == 0 && Int(self.SCheckAmount.text!)! == 0 && Int(self.PCheckAmount.text!)! == 0 && Int(self.DCheckAmount.text!)! == 0{
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
                    //self.subTotalAmount.text = "0"
                    //self.discountAmount.text = "0"
                    self.totalAmount.text = "0"
                    self.tenderAmount.text = "0"
                    self.changeAmount.text = "0"*/
                }
                alertController.addAction(OKButton)
                self.present(alertController,animated: true,completion: nil)
            } else if Int(self.WCheckAmount.text!)! > Int(self.WRemainAmount.text!)! || Int(self.SCheckAmount.text!)! > Int(self.SRemainAmount.text!)! || Int(self.PCheckAmount.text!)! > Int(self.PRemainAmount.text!)! || Int(self.DCheckAmount.text!)! > Int(self.DRemainAmount.text!)!{
                let alertController = UIAlertController(title: "会計が無効です",message: "会計食数が残り食数を超えています", preferredStyle: UIAlertController.Style.alert)
                let OKButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
                    /*self.WCheckAmount.text = "0"
                    self.WCheckStepper.value = 0
                    self.SCheckAmount.text = "0"
                    self.SCheckStepper.value = 0
                    self.PCheckAmount.text = "0"
                    self.PCheckStepper.value = 0
                    self.DCheckAmount.text = "0"
                    self.DCheckStepper.value = 0
                    //self.subTotalAmount.text = "0"
                    //self.discountAmount.text = "0"
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
            } else {
                //お釣り表示・各種初期化
                let alertController = UIAlertController(title: "お釣りは\(String(describing: self.changeAmount.text!))円です",message: "", preferredStyle: UIAlertController.Style.alert)
                let OKButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
                    //レシート印刷機能
                    var hogeKey : String?
                    let defaultPlace = self.DBRef.child("table/orderKey").child(self.orderNumber!)
                    defaultPlace.observeSingleEvent(of: .value, with: { (snapshot) in
                        hogeKey = (snapshot.value! as AnyObject).description
                        guard let client = DropboxClientsManager.authorizedClient else {
                            return}
                        let fileData = "\(self.orderNumber!),/\(hogeKey!)/,\(self.WCheckAmount.text!),\(self.SCheckAmount.text!),\(self.PCheckAmount.text!),\(self.DCheckAmount.text!),\(self.C1AmountLabel.text!),\(self.C3AmountLabel.text!),\(self.C10AmountLabel.text!),\(self.tenderAmount.text!)".data(using: String.Encoding.utf8, allowLossyConversion: false)!
                        _ = client.files.deleteV2(path: "/kissa2019.system.register/Data/receipt.csv")
                            .response{ response, error in
                                if let response = response {
                                    print(response)
                                }else if let error = error {
                                    print(error)
                                }
                        }


                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            _ = client.files.upload(path:"/kissa2019.system.register/Data/receipt.csv", input: fileData)
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
                        //self.GetMoneySum = "\(Int(self.GetMoneySum)! + Int(self.tenderAmount.text!)!)"

                        //クッキーオーダー入力
                        self.C1Amount = self.C1AmountLabel.text
                        self.C3Amount = self.C3AmountLabel.text
                        self.C10Amount = self.C10AmountLabel.text

                       var hogeKey : String?
                       let defaultPlace = self.DBRef.child("table/orderKey").child(self.orderNumber!)
                       defaultPlace.observeSingleEvent(of: .value, with: { (snapshot) in hogeKey = (snapshot.value! as AnyObject).description
                           self.DBRef.child("inData").child(hogeKey!).updateChildValues(["C1":self.C1Amount!, "C3":self.C3Amount!, "C10":self.C10Amount!])
                       })

                        //全食数の更新
                        let defaultPlaceX = self.DBRef.child("inProceeds")
                        defaultPlaceX.observeSingleEvent(of: .value, with: { (snapshot) in
                            self.proceeds = (snapshot.value! as AnyObject).description
                            self.intProceeds = Int(self.proceeds!)! + Int(self.totalAmount.text!)!
                            self.DBRef.child("inProceeds").setValue(self.intProceeds)
                            self.totalAmount.text = "0"
                            //self.subTotalAmount.text = "0"
                            //self.discountAmount.text = "0"
                        })
                        let WRemaining = Int(self.WRemainAmount.text!)!-Int(self.WCheckAmount.text!)!
                        self.DBRef.child("table/order/").child(self.orderNumber!).child("totalWAmount").setValue(WRemaining)
                        let SRemaining = Int(self.SRemainAmount.text!)!-Int(self.SCheckAmount.text!)!
                        self.DBRef.child("table/order/").child(self.orderNumber!).child("totalSAmount").setValue(SRemaining)
                        let PRemaining = Int(self.PRemainAmount.text!)!-Int(self.PCheckAmount.text!)!
                        self.DBRef.child("table/order/").child(self.orderNumber!).child("totalPAmount").setValue(PRemaining)
                        let DRemaining = Int(self.DRemainAmount.text!)!-Int(self.DCheckAmount.text!)!
                        self.DBRef.child("table/order/").child(self.orderNumber!).child("totalDAmount").setValue(DRemaining)

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

                        self.WCheckAmount.text = "0"
                        self.WCheckStepper.value = 0
                        self.SCheckAmount.text = "0"
                        self.SCheckStepper.value = 0
                        self.PCheckAmount.text = "0"
                        self.PCheckStepper.value = 0
                        self.DCheckAmount.text = "0"
                        self.DCheckStepper.value = 0
                        self.C1AmountLabel.text = "0"
                        self.C1StepperValue.value = 0
                        self.C3AmountLabel.text = "0"
                        self.C3StepperValue.value = 0
                        self.C10AmountLabel.text = "0"
                        self.C10StepperValue.value = 0
                        self.tenderAmount.text = "0"
                        self.changeAmount.text = "0"

                        //会計終了判定
                        if WRemaining == 0,SRemaining == 0,PRemaining == 0,DRemaining == 0{
                            //let alertController = UIAlertController(title: "会計が終了しました",message: "", preferredStyle: UIAlertController.Style.alert)
                            //let OKButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
                                var hogeKey : String?
                                let defaultPlace = self.DBRef.child("table/orderKey").child(self.orderNumber!)
                                defaultPlace.observeSingleEvent(of: .value, with: { (snapshot) in hogeKey = (snapshot.value! as AnyObject).description
                                    self.DBRef.child("inData").child(hogeKey!).updateChildValues(["exitTime":ServerValue.timestamp()])
                                    self.DBRef.child("table/orderOrder").child(hogeKey!).setValue(nil)
                                    self.DBRef.child("table/orderKey").child(self.orderNumber!).setValue(nil)
                                })
                                self.DBRef.child("table/order").child(self.orderNumber!).setValue(["W1Amount":0, "W2Amount":0, "P1Amount":0, "P2Amount":0, "S1Amount":0, "S2Amount":0, "D1Amount":0, "D2Amount":0, "D3Amount":0, "D4Amount":0, "D5Amount":0, "D11Amount":0, "D12Amount":0, "D13Amount":0, "D14Amount":0, "D15Amount":0, "C1Amount":0, "C3Amount":0, "C10Amount":0, "time":0, "completeTime":0, "totalWAmount":0, "totalSAmount":0, "totalPAmount":0, "totalDAmount":0])
                                self.DBRef.child("table/status").child(self.orderNumber!).setValue(0)
                                self.DBRef.child("table/WStatus").child(self.orderNumber!).setValue(0)
                                self.DBRef.child("table/PStatus").child(self.orderNumber!).setValue(0)
                                self.DBRef.child("table/SStatus").child(self.orderNumber!).setValue(0)
                                self.DBRef.child("table/DStatus").child(self.orderNumber!).setValue(0)
                            //}

                            //テーブル状態を変更
                            for tableNumber in 1...40{
                                let defaultPlace = self.DBRef.child("table/table").child(String(tableNumber))
                                defaultPlace.observeSingleEvent(of: .value, with: { (snapshot) in
                                    self.tableStatus = (snapshot.value! as AnyObject).description
                                    if self.tableStatus! == self.orderNumber! {
                                        defaultPlace.setValue(5)
                                    }
                                })
                            }
                            //alertController.addAction(OKButton)
                            //self.present(alertController,animated: true,completion: nil)
                        }
                    })
                }
                alertController.addAction(OKButton)
                self.present(alertController,animated: true,completion: nil)
            }
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
        orderNumber = neworderNumber ?? "001"
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
        let defaultPlaceW = DBRef.child("table/order").child(orderNumber!).child("totalWAmount")
        defaultPlaceW.observe(.value, with: { snapshot in
            self.WRemainAmount.text = (snapshot.value! as AnyObject).description
        })
        let defaultPlaceS = DBRef.child("table/order").child(orderNumber!).child("totalSAmount")
        defaultPlaceS.observe(.value, with: { snapshot in
            self.SRemainAmount.text = (snapshot.value! as AnyObject).description
        })
        let defaultPlaceP = DBRef.child("table/order").child(orderNumber!).child("totalPAmount")
        defaultPlaceP.observe(.value, with: { snapshot in
            self.PRemainAmount.text = (snapshot.value! as AnyObject).description
        })
        let defaultPlaceD = DBRef.child("table/order").child(orderNumber!).child("totalDAmount")
        defaultPlaceD.observe(.value, with: { snapshot in
            self.DRemainAmount.text = (snapshot.value! as AnyObject).description
        })

        //        let defaultPlace7 = self.DBRef.child("inProceeds")
        //        defaultPlace7.observe(.value) { (snap: DataSnapshot) in
        //            self.ProceedsAmount.text = (snap.value! as AnyObject).description}


        /*let defaultPlaceC1 = DBRef.child("table/order").child(orderNumber!).child("C1Amount")
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
        })*/

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
