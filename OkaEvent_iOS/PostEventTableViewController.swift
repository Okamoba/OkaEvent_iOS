//
//  PostEventTableViewController.swift
//  OkaEvent_iOS
//
//  Created by Ishikawa Akira on 2018/05/20.
//  Copyright © 2018年 talkie. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class PostEventTableViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var locationTextFielld: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var startDateTimeTextField: UITextField!
    @IBOutlet weak var endDateTimeTextField: UITextField!
    @IBOutlet weak var postButton: UIBarButtonItem!
    
    var db: Firestore?
    
    override func viewDidLoad() {
        db = Firestore.firestore()
        //最初は無効状態
        postButton.isEnabled = false
        
        titleTextField.delegate  = self
        descriptionTextView.delegate = self
        locationTextFielld.delegate = self
        linkTextField.delegate = self
        startDateTimeTextField.delegate = self
        endDateTimeTextField.delegate = self
    }
    
    //全ての項目が入力されているか確認
    private func isInputComplete() -> Bool {
        return titleTextField.text != "" &&
            descriptionTextView.text != "" &&
            locationTextFielld.text != "" &&
            linkTextField.text != "" &&
            startDateTimeTextField.text != "" &&
            endDateTimeTextField.text != ""
    }
    
    //textFieldのフォーカスが移動したら呼ばれる
    func textFieldDidEndEditing(_ textField: UITextField) {
        //前後の余計な余白を削除
        textField.text = textField.text?.trimmingCharacters(in: NSCharacterSet.whitespaces)
        //入力が終わったら、何か文字列が入っているか確認
        postButton.isEnabled = isInputComplete()
    }
    
    //textViewのフォーカスが移動したら呼ばれる
    func textViewDidEndEditing(_ textView: UITextView) {
        //前後の余計な余白を削除
        textView.text = textView.text.trimmingCharacters(in: NSCharacterSet.whitespaces)
        //入力が終わったら、何か文字列が入っているか確認
        postButton.isEnabled = isInputComplete()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func postTapped(_ sender: Any) {
        //isInputComplete()で値入っていることを確認しているので強制アンラップする
        let title = titleTextField.text!
        let description = descriptionTextView.text!
        let location = locationTextFielld.text!
        let link = linkTextField.text!
        let startDateTimeStr = startDateTimeTextField.text!
        let endDateTimeStr = endDateTimeTextField.text!
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "ja_JP")
        
        //日付が不正なフォーマットだと投稿させない
        guard let startDateTime = formatter.date(from: startDateTimeStr) else {
            return
        }
        guard let endDateTime = formatter.date(from: endDateTimeStr) else {
            return
        }
        
        let event = EventData(name: title, startDateTime: startDateTime, endDateTime: endDateTime, address: location, description: description, url: link)
        var postParam = event.toDictionary()
        //uidを追加
        postParam["author"] = Auth.auth().currentUser?.uid
        //投稿
        db?.collection("events").document().setData(postParam) { err in
            if let error = err {
                print(error)
            } else {
                //投稿が成功すれば、イベント一覧へ遷移
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController")
                self.present(mainVC, animated: true, completion: nil)
            }
        }
    }
}
