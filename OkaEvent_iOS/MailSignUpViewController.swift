//
//  MailSignInViewController.swift
//  OkaEvent_iOS
//
//  Created by 石川諒 on 2018/02/18.
//  Copyright © 2018年 talkie. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class MailSignUpViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setDisplayName() {
        guard let name = nameTextField.text else {
            return
        }
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        //displayNameのセット
        changeRequest?.displayName = name
        changeRequest?.commitChanges { (error) in
            if let e = error {
                print(e)
                return
            }
        }
        
        //MainViewControllerへ遷移
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        self.present(mainViewController, animated: true, completion: nil)
    }
    
    @IBAction func SignUpTapped(_ sender: Any) {
        guard nameTextField.text != nil else {
            return
        }
        guard let mailAddress = mailTextField.text else {
            return
        }
        guard let password = passwordTextField.text else {
            return
        }
        Auth.auth().createUser(withEmail: mailAddress, password: password) { (user, error) in
            if let error = error {
                print(error)
            }
            self.setDisplayName()
        }
    }

}
