//
//  EventViewController.swift
//  SampleCVCalendar
//
//  Created by 一騎高橋 on 2016/10/15.
//  Copyright © 2016年 IkkiTakahashi. All rights reserved.
//

import UIKit
import CVCalendar

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
        guard count > 0 else {
            return
        }
        
        myItems = []
        
        for i in 0...count {
            myItems.append("テスト No.\(i)")
        }
        
        self.eventTableView.reloadData()
    }
    
}
