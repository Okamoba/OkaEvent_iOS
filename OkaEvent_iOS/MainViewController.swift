//
//  ViewController.swift
//  OkaEvent_iOS
//
//  Created by talkie on 2017/12/10.
//  Copyright © 2017年 talkie. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func mailAuthViewControllerTransition() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Authentication", bundle: nil)
        let mailAuthViewController = storyboard.instantiateViewController(withIdentifier: "MailAuthViewController")
        present(mailAuthViewController, animated: true, completion: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
        } else {
            mailAuthViewControllerTransition()
        }
    }

}

