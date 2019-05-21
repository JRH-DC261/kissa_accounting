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
    var tableNumber : String?
    var newTableNumber : String?

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

    @IBOutlet weak var subTotalAmount: UILabel!
    @IBOutlet weak var discountAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var tenderAmount: UILabel!
    @IBOutlet weak var changeAmount: UILabel!


    @IBAction func WStepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        WCheckAmount.text = "\(Amount)"
        subTotalAmount.text = "\(Int(WCheckStepper.value)*300 + Int(SCheckStepper.value)*200 + Int(PCheckStepper.value)*300 + Int(DCheckStepper.value)*100)"
        discountAmount.text = "\((min(Int(WCheckStepper.value),Int(SCheckStepper.value),Int(DCheckStepper.value)) + min(Int(PCheckStepper.value),Int(SCheckStepper.value),Int(DCheckStepper.value)))*100)"
        totalAmount.text = "\(Int(subTotalAmount.text!)! - Int(discountAmount.text!)!)"
    }
    @IBAction func SStepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        SCheckAmount.text = "\(Amount)"
        subTotalAmount.text = "\(Int(WCheckStepper.value)*300 + Int(SCheckStepper.value)*200 + Int(PCheckStepper.value)*300 + Int(DCheckStepper.value)*100)"
        discountAmount.text = "\((min(Int(WCheckStepper.value),Int(SCheckStepper.value),Int(DCheckStepper.value)) + min(Int(PCheckStepper.value),Int(SCheckStepper.value),Int(DCheckStepper.value)))*100)"
        totalAmount.text = "\(Int(subTotalAmount.text!)! - Int(discountAmount.text!)!)"
    }
    @IBAction func PStepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        PCheckAmount.text = "\(Amount)"
        subTotalAmount.text = "\(Int(WCheckStepper.value)*300 + Int(SCheckStepper.value)*200 + Int(PCheckStepper.value)*300 + Int(DCheckStepper.value)*100)"
        discountAmount.text = "\((min(Int(WCheckStepper.value),Int(SCheckStepper.value),Int(DCheckStepper.value)) + min(Int(PCheckStepper.value),Int(SCheckStepper.value),Int(DCheckStepper.value)))*100)"
        totalAmount.text = "\(Int(subTotalAmount.text!)! - Int(discountAmount.text!)!)"
    }
    @IBAction func DStepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        DCheckAmount.text = "\(Amount)"
        subTotalAmount.text = "\(Int(WCheckStepper.value)*300 + Int(SCheckStepper.value)*200 + Int(PCheckStepper.value)*300 + Int(DCheckStepper.value)*100)"
        discountAmount.text = "\((min(Int(WCheckStepper.value),Int(SCheckStepper.value),Int(DCheckStepper.value)) + min(Int(PCheckStepper.value),Int(SCheckStepper.value),Int(DCheckStepper.value)))*100)"
        totalAmount.text = "\(Int(subTotalAmount.text!)! - Int(discountAmount.text!)!)"
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
        subTotalAmount.text = "\(Int(WCheckStepper.value)*300 + Int(SCheckStepper.value)*200 + Int(PCheckStepper.value)*300 + Int(DCheckStepper.value)*100)"
        discountAmount.text = "\((min(Int(WCheckStepper.value),Int(SCheckStepper.value),Int(DCheckStepper.value)) + min(Int(PCheckStepper.value),Int(SCheckStepper.value),Int(DCheckStepper.value)))*100)"
        totalAmount.text = "\(Int(subTotalAmount.text!)! - Int(discountAmount.text!)!)"
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
        totalAmount.text = "\(Int(subTotalAmount.text!)! - Int(discountAmount.text!)!)"
        changeAmount.text = "\(Int(tenderAmount.text!)! - Int(totalAmount.text!)!)"
        let alertController = UIAlertController(title: "会計処理",message: "実行しますか？", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            if Int(self.WRemainAmount.text!)! == 0 && Int(self.SCheckAmount.text!)! == 0 && Int(self.PCheckAmount.text!)! == 0 && Int(self.DCheckAmount.text!)! == 0{
                let alertController = UIAlertController(title: "会計が無効です",message: "注文が入っていません", preferredStyle: UIAlertController.Style.alert)
                let OKButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
                    self.WCheckAmount.text = "0"
                    self.WCheckStepper.value = 0
                    self.SCheckAmount.text = "0"
                    self.SCheckStepper.value = 0
                    self.PCheckAmount.text = "0"
                    self.PCheckStepper.value = 0
                    self.DCheckAmount.text = "0"
                    self.DCheckStepper.value = 0
                    self.subTotalAmount.text = "0"
                    self.discountAmount.text = "0"
                    self.totalAmount.text = "0"
                    self.tenderAmount.text = "0"
                    self.changeAmount.text = "0"
                }
                alertController.addAction(OKButton)
                self.present(alertController,animated: true,completion: nil)
            } else if Int(self.WCheckAmount.text!)! > Int(self.WRemainAmount.text!)! || Int(self.SCheckAmount.text!)! > Int(self.SRemainAmount.text!)! || Int(self.PCheckAmount.text!)! > Int(self.PRemainAmount.text!)! || Int(self.DCheckAmount.text!)! > Int(self.DRemainAmount.text!)!{
                let alertController = UIAlertController(title: "会計が無効です",message: "会計食数が残り食数を超えています", preferredStyle: UIAlertController.Style.alert)
                let OKButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
                    self.WCheckAmount.text = "0"
                    self.WCheckStepper.value = 0
                    self.SCheckAmount.text = "0"
                    self.SCheckStepper.value = 0
                    self.PCheckAmount.text = "0"
                    self.PCheckStepper.value = 0
                    self.DCheckAmount.text = "0"
                    self.DCheckStepper.value = 0
                    self.subTotalAmount.text = "0"
                    self.discountAmount.text = "0"
                    self.totalAmount.text = "0"
                    self.tenderAmount.text = "0"
                    self.changeAmount.text = "0"
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
                    let defaultPlace = self.DBRef.child("table/orderKey").child(self.tableNumber!)
                    defaultPlace.observeSingleEvent(of: .value, with: { (snapshot) in
                        hogeKey = (snapshot.value! as AnyObject).description
                        guard let client = DropboxClientsManager.authorizedClient else {
                            return}
                        let fileData = "\(self.tableNumber!),/\(hogeKey!)/,\(self.WCheckAmount.text!),\(self.SCheckAmount.text!),\(self.PCheckAmount.text!),\(self.DCheckAmount.text!),\(self.discountAmount.text!),\(self.tenderAmount.text!)".data(using: String.Encoding.utf8, allowLossyConversion: false)!
                        _ = client.files.deleteV2(path: "/kissa2019.system/kissa_accounting_reciept/Data/receipt.csv")
                            .response{ response, error in
                                if let response = response {
                                    print(response)
                                }else if let error = error {
                                    print(error)
                                }
                        }
                        _ = client.files.upload(path:"/kissa2019.system/kissa_accounting_reciept/Data/receipt.csv", input: fileData)
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
                        //self.GetMoneySum = "\(Int(self.GetMoneySum)! + Int(self.tenderAmount.text!)!)"

                        //全食数の更新
                        let defaultPlaceX = self.DBRef.child("inProceeds")
                        defaultPlaceX.observeSingleEvent(of: .value, with: { (snapshot) in
                            self.proceeds = (snapshot.value! as AnyObject).description
                            self.intProceeds = Int(self.proceeds!)! + Int(self.totalAmount.text!)!
                            self.DBRef.child("inProceeds").setValue(self.intProceeds)
                            self.totalAmount.text = "0"
                            self.subTotalAmount.text = "0"
                            self.discountAmount.text = "0"
                        })
                        let WRemaining = Int(self.WRemainAmount.text!)!-Int(self.WCheckAmount.text!)!
                        self.DBRef.child("table/order/").child(self.tableNumber!).child("totalWAmount").setValue(WRemaining)
                        let SRemaining = Int(self.SRemainAmount.text!)!-Int(self.SCheckAmount.text!)!
                        self.DBRef.child("table/order/").child(self.tableNumber!).child("totalSAmount").setValue(SRemaining)
                        let PRemaining = Int(self.PRemainAmount.text!)!-Int(self.PCheckAmount.text!)!
                        self.DBRef.child("table/order/").child(self.tableNumber!).child("totalPAmount").setValue(PRemaining)
                        let DRemaining = Int(self.DRemainAmount.text!)!-Int(self.DCheckAmount.text!)!
                        self.DBRef.child("table/order/").child(self.tableNumber!).child("totalDAmount").setValue(DRemaining)
                        self.WCheckAmount.text = "0"
                        self.WCheckStepper.value = 0
                        self.SCheckAmount.text = "0"
                        self.SCheckStepper.value = 0
                        self.PCheckAmount.text = "0"
                        self.PCheckStepper.value = 0
                        self.DCheckAmount.text = "0"
                        self.DCheckStepper.value = 0
                        self.tenderAmount.text = "0"
                        self.changeAmount.text = "0"

                        //会計終了判定
                        if WRemaining == 0,SRemaining == 0,PRemaining == 0,DRemaining == 0{
                            let alertController = UIAlertController(title: "会計が終了しました",message: "", preferredStyle: UIAlertController.Style.alert)
                            let OKButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
                                var hogeKey : String?
                                let defaultPlace = self.DBRef.child("table/orderKey").child(self.tableNumber!)
                                defaultPlace.observeSingleEvent(of: .value, with: { (snapshot) in hogeKey = (snapshot.value! as AnyObject).description
                                    self.DBRef.child("inData").child(hogeKey!).updateChildValues(["exitTime":ServerValue.timestamp()])
                                    self.DBRef.child("table/orderOrder").child(hogeKey!).setValue(nil)
                                    self.DBRef.child("table/orderKey").child(self.tableNumber!).setValue(nil)
                                })
                                self.DBRef.child("table/order").child(self.tableNumber!).setValue(["W1Amount":0, "P1Amount":0, "P2Amount":0, "S1Amount":0, "S2Amount":0, "D1Amount":0, "D2Amount":0, "D3Amount":0, "D4Amount":0, "D11Amount":0, "D12Amount":0, "D13Amount":0, "D14Amount":0, "D15Amount":0, "time":0, "completeTime":0, "totalWAmount":0, "totalSAmount":0, "totalPAmount":0, "totalDAmount":0])
                                self.DBRef.child("table/status").child(self.tableNumber!).setValue(0)
                                self.DBRef.child("table/WStatus").child(self.tableNumber!).setValue(0)
                                self.DBRef.child("table/PStatus").child(self.tableNumber!).setValue(0)
                                self.DBRef.child("table/SStatus").child(self.tableNumber!).setValue(0)
                                self.DBRef.child("table/DStatus").child(self.tableNumber!).setValue(0)
                            }
                            alertController.addAction(OKButton)
                            self.present(alertController,animated: true,completion: nil)
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
        tableNumber = newTableNumber ?? "001"
        self.navigationItem.title = "Table " + tableNumber!

        Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(self.amountload(_:)),
            userInfo: nil,
            repeats: false
        )
    }

    @objc func amountload(_ sender: Timer) {
        let defaultPlaceW = DBRef.child("table/order").child(tableNumber!).child("totalWAmount")
        defaultPlaceW.observe(.value, with: { snapshot in
            self.WRemainAmount.text = (snapshot.value! as AnyObject).description
        })
        let defaultPlaceS = DBRef.child("table/order").child(tableNumber!).child("totalSAmount")
        defaultPlaceS.observe(.value, with: { snapshot in
            self.SRemainAmount.text = (snapshot.value! as AnyObject).description
        })
        let defaultPlaceP = DBRef.child("table/order").child(tableNumber!).child("totalPAmount")
        defaultPlaceP.observe(.value, with: { snapshot in
            self.PRemainAmount.text = (snapshot.value! as AnyObject).description
        })
        let defaultPlaceD = DBRef.child("table/order").child(tableNumber!).child("totalDAmount")
        defaultPlaceD.observe(.value, with: { snapshot in
            self.DRemainAmount.text = (snapshot.value! as AnyObject).description
        })

        //        let defaultPlace7 = self.DBRef.child("inProceeds")
        //        defaultPlace7.observe(.value) { (snap: DataSnapshot) in
        //            self.ProceedsAmount.text = (snap.value! as AnyObject).description}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
