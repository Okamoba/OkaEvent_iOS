//
//  AuthTopViewController.swift
//  OkaEvent_iOS
//
//  Created by Ishikawa Akira on 2018/07/22.
//  Copyright © 2018年 talkie. All rights reserved.
//

import UIKit
import FirebaseAuthUI

class AuthTopViewController: UIViewController, FUIAuthDelegate {
    
    var authUI :FUIAuth?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
    }
    
    @IBAction func EmailAuthButtonTapped(_ sender: Any) {
        let authVC = authUI?.authViewController()
        present(authVC!, animated: true, completion: nil)
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if let error = error {
            print(error)
        }
        if authDataResult?.user != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let MainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController")
            present(MainVC, animated: true, completion: nil)
        }
    }
}
