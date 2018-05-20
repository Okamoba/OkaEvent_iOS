//
//  PostEventTableViewController.swift
//  OkaEvent_iOS
//
//  Created by Ishikawa Akira on 2018/05/20.
//  Copyright © 2018年 talkie. All rights reserved.
//

import UIKit

class PostEventTableViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var locationTextFielld: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    
    
    override func viewDidLoad() {
        titleTextField.delegate  = self
        descriptionTextView.delegate = self
        locationTextFielld.delegate = self
        linkTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
