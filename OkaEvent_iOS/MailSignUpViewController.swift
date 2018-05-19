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
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //userNameをセット
    func registerUserName(response: @escaping ()->()) {
        guard let userName = userNameTextField.text else {
            return
        }
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = userName
        changeRequest?.commitChanges(completion: { error in
            if let error = error {
                print(error)
                return
            }
            response()
        })
    }

    @IBAction func SignUpTapped(_ sender: Any) {
        guard userNameTextField.text != nil else {
            return
        }
        guard let mailAddress = mailTextField.text else {
            return
        }
        guard let password = passwordTextField.text else {
            return
        }
        
        //emailとパスワードを登録
        Auth.auth().createUser(withEmail: mailAddress, password: password) { (user, error) in
            if let error = error {
                print(error)
                return
            }
            //emailとパスワードを登録できたらユーザー名を登録する
            self.registerUserName {
                //ユーザー名を設定できたらMainVeiewControllerへ遷移
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
                self.present(mainViewController, animated: true, completion: nil)
            }
        }
    }

}
