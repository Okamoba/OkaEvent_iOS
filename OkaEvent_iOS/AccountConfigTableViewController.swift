//
//  AccountConfigTableViewController.swift
//  OkaEvent_iOS
//
//  Created by Ishikawa Akira on 2018/09/16.
//  Copyright © 2018年 talkie. All rights reserved.
//

import UIKit
import FirebaseAuth

class AccountConfigTableViewController: UITableViewController {

    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let user = Auth.auth().currentUser
        emailLabel.text = user?.email
        displayNameLabel.text = user?.displayName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

}
