//
//  ViewController.swift
//  OkaEvent_iOS
//
//  Created by talkie on 2017/12/10.
//  Copyright © 2017年 talkie. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
 {
    @IBOutlet weak var TreeView: UITableView!
    //配列fruitsを設定
    var events: Array<EventData> = [EventData]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadEventList()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "EventListCell", for: indexPath)
        
        // セルに表示する値を設定する
        cell.textLabel?.text = events[indexPath.row].name
        cell.detailTextLabel?.text = events[indexPath.row].date

        return cell
    }
    
    func loadEventList(){
        var defaultStore: Firestore!
        defaultStore = Firestore.firestore()
        let ref = defaultStore.collection("events")
        
        self.events.removeAll()
        self.TreeView.reloadData()
        ref.order(by: "start_datetime").limit(to: 3).getDocuments{ (snapshot, error) in
            guard let snapshot = snapshot
                else{
                    print("Error : \(error!)")
                    return
            }
            for doc in snapshot.documents {
                let docData = doc.data()
                let dataName: String = docData["name"] as! String
                let dataDate = docData["start_datetime"] as! Date
                let formatter: DateFormatter = DateFormatter()
                formatter.dateFormat = "yyyy年MM月dd日"
                let formattedDate: String = formatter.string(from: dataDate)
                self.events.append(EventData(name: dataName, date: formattedDate))
            }
            self.TreeView.reloadData()
        }
    }
}

