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
import Floaty

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FloatyDelegate
 {
    @IBOutlet weak var treeView: UITableView!

    var floatyButton: Floaty = Floaty()

    //配列fruitsを設定
    var events: Array<EventData> = [EventData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        floatyButton.fabDelegate = self
        view.addSubview(floatyButton)
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

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日 h:mm:00"
        let startDateTime = events[indexPath.row].startDateTime
        let startDatetimeStr = formatter.string(from: startDateTime)
        // セルに表示する値を設定する
        cell.textLabel?.text = events[indexPath.row].name
        cell.detailTextLabel?.text = startDatetimeStr

        return cell
    }

    func loadEventList(){
        var defaultStore: Firestore!
        defaultStore = Firestore.firestore()
        let ref = defaultStore.collection("events")

        events.removeAll()
        treeView.reloadData()
        ref.order(by: "start_datetime").limit(to: 100).getDocuments{ (snapshot, error) in
            guard let snapshot = snapshot
                else{
                    print("Error : \(error!)")
                    return
            }
            for doc in snapshot.documents {
                let docData = doc.data()
                let dataName: String = docData["name"] as! String
                let dataDescription: String = docData["text"] as! String
                let startDataDate = docData["start_datetime"] as! Date
                let endDataDate  = docData["end_datetime"] as! Date
                let adress  = docData["address"] as! String
                let url: String = docData["url"] as! String
                self.events.append(EventData(name: dataName, startDateTime: startDataDate, endDateTime: endDataDate, address: adress, description: dataDescription, url: url))
            }
            self.treeView.reloadData()
        }
    }

    func emptyFloatySelected(_ floaty: Floaty) {
        //イベント投稿画面へ遷移
        let storyboard = UIStoryboard(name: "Post", bundle: nil)
        let postVC = storyboard.instantiateViewController(withIdentifier: "PostEventNavigationController")
        present(postVC, animated: true, completion: nil)
    }
}

