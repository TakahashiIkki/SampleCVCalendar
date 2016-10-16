//
//  EventViewController.swift
//  SampleCVCalendar
//
//  Created by 一騎高橋 on 2016/10/15.
//  Copyright © 2016年 IkkiTakahashi. All rights reserved.
//

import UIKit
import EventKit
import CVCalendar
import SCLAlertView

class EventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var eventTableView: UITableView!
    
    open var myItems: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // 表示するセルの個数を表示
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myItems.count
    }
    
    // セルに表示する値を指定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventTableView.dequeueReusableCell(withIdentifier: "EventBasicCell", for: indexPath)
        
        let item = myItems[indexPath.row]
        
        cell.textLabel?.text = "\(item)"
        
        return cell
    }

    open func settingAndReloadContent(count: Int) {
        guard count >= 0 else {
            return
        }
        
        myItems = []
        
        for i in 0...count {
            myItems.append("テスト No.\(i)")
        }
        
        if eventTableView != nil {
            self.eventTableView.reloadData()
        }
    }
    
    open func reloadEventList(targetDate: Date) {
        
        self.settingAndReloadContent(count: CVDate(date: targetDate).day - 1)
        
        print("reloadEventList")
    }
    
    fileprivate func getEventList(targetDate: Date) -> [EKEvent] {
        
        // ステータスを取得.
        let status = EKEventStore.authorizationStatus(for: .event)
        
        // ステータスを表示 許可されている場合のみtrueを返す.
        switch status {
        case .notDetermined:
            print("NotDetermined")
            
            
        case .denied:
            print("Denied")
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("設定しない", action: {})
            alertView.addButton("設定する") {
                if let url = NSURL(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.open(url as URL)
                }
            }
            alertView.showWarning("エラー", subTitle: "カレンダーへのアクセスが許可されていないので、読み込めませんでした。")
            
        case .authorized:
            print("Authorized")
            //            myEventStore.requestAccess(to: .event) { (granted , error) -> Void in
            //
            //                // 許可を得られなかった場合アラート発動.
            //                if granted {
            //                    return
            //                } else {
            //
            //                    // メインスレッド 画面制御. 非同期.
            //                    DispatchQueue.main.async(){ () -> Void in
            //
            //                        // アラート生成.
            //                        let myAlert = UIAlertController(title: "権限許可なし", message: "カレンダー情報の取得は許可されていません", preferredStyle: .alert)
            //
            //                        // アラートアクション.
            //                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            //
            //                        myAlert.addAction(okAction)
            //                        self.present(myAlert, animated: true, completion: nil)
            //                    }
            //                }
            //            }
        case .restricted:
            print("Restricted")
            
        }
        
        return []
    }
}
