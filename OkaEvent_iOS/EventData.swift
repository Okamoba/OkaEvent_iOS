//
//  EventData.swift
//  OkaEvent_iOS
//
//  Created by talkie on 2018/05/19.
//  Copyright © 2018年 talkie. All rights reserved.
//

import Foundation

struct EventData {
    let name: String
    let startDateTime: Date
    let endDateTime: Date
    let address: String
    let description: String
    let url: String
    
    func toDictionary() -> [String: Any] {
        var dic:[String:Any] = [:]
        dic["name"] = name
        dic["start_datetime"] = startDateTime
        dic["end_datetime"] = endDateTime
        dic["address"] = address
        dic["text"] = description
        dic["url"] = url
        return dic
    }
}
