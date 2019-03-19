//
//  TableListViewController.swift
//  kissa_accounting
//
//  Created by Tomohiro Hori on 2019/03/19.
//  Copyright © 2019 Tomohiro Hori. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class TableListViewController: UITableViewController {
    
    @IBOutlet weak var sideTableView: UITableView!
    
    @IBAction func toMenu(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    let number = ["001","002","003","004","005","006","007","008","009","010","011","012","013","014","015","016","017","018"]
    var tableNumber : String?
    // インスタンス変数
    var DBRef:DatabaseReference!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return number.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath)
        // セルに表示する値を設定する
        cell.textLabel!.text = "Table " + number[indexPath.row]
        cell.detailTextLabel!.text = "空席"
        //席ステータス表示
        var status1 : String?
        var intstatus1 : Int?
        let defaultPlace = DBRef.child("table/status").child(number[indexPath.row])
        defaultPlace.observe(.value) { (snap: DataSnapshot) in status1 = (snap.value! as AnyObject).description
            intstatus1 = Int(status1!)
            if intstatus1! == 0{
                cell.detailTextLabel!.text = "空席"
                cell.backgroundColor = UIColor.clear
            }else if intstatus1! == 1{
                cell.detailTextLabel!.text = "注文完了"
                cell.backgroundColor = UIColor(red:0.75, green:0.88, blue:0.90, alpha:0.75)
            }else if intstatus1! == 2{
                cell.detailTextLabel!.text = "配膳待ち"
                cell.backgroundColor = UIColor(red:0.98, green:0.93, blue:0.95, alpha:1.0)
            }else if intstatus1! == 3{
                cell.detailTextLabel!.text = "食事配膳完了"
                cell.backgroundColor = UIColor(red:0.96, green:0.92, blue:0.41, alpha:0.5)
            }else if intstatus1! == 4{
                cell.detailTextLabel!.text = "全注文配膳完了"
                cell.backgroundColor = UIColor(red:0.75, green:0.83, blue:0.41, alpha:0.5)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableNumber = number[indexPath.row]
        performSegue(withIdentifier:"toNextView", sender: nil)
        sideTableView.deselectRow(at: indexPath, animated:true)
    }
    
    //次のビューに渡す値を設定
    override func  prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextNC = segue.destination as! UINavigationController
        let nextVC = nextNC.viewControllers.first as! ServeViewController
        nextVC.newTableNumber = tableNumber!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //インスタンスを作成
        DBRef = Database.database().reference()
    }

}
