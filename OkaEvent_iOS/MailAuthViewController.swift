//
//  MailAuthViewController.swift
//  OkaEvent_iOS
//
//  Created by 石川諒 on 2018/01/21.
//  Copyright © 2018年 talkie. All rights reserved.
//

import UIKit
import FirebaseAuth

class MailAuthViewController: UIViewController {

    @IBOutlet weak var mailTextFiled: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func mailLogin(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let e = error {
                print(e)
                return
            }
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
            self.present(mainViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let mail = mailTextFiled.text else {
            return
        }
        guard let password = passwordTextField.text else {
            return
        }
        mailLogin(email: mail, password: password)
    }
    
    @IBAction func textFiledEditEnd(_ sender: Any) {
        guard let textField = sender as? UITextField else {
            return
        }
        textField.resignFirstResponder()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
