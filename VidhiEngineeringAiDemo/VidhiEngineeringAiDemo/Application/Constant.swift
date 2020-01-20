//
//  Constant.swift
//  VidhiEngineeringAiDemo
//
//  Created by MAC105 on 20/01/20.
//  Copyright © 2020 MAC105. All rights reserved.
//

import Foundation

let BASEURL : String = "https://sd2-hiring.herokuapp.com/api/"

struct API {
    static func getUsers(offset : Int,limit : Int) -> String {
        return BASEURL+"users?offset=\(offset)&limit=\(limit)"
    }
}
