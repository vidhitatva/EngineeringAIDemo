//
//  UserController.swift
//  VidhiEngineeringAiDemo
//
//  Created by MAC105 on 20/01/20.
//  Copyright © 2020 MAC105. All rights reserved.
//

import Foundation

class UserController {
    static func getUserWith(offset : Int,complition : @escaping(_ hasMore : Bool,_ user : [Users]) -> Void) {
        RequestManager.requestWithGET(with: API.getUsers(offset: offset, limit: 10)) { (status, responsedata, message) in
            if status {
                do {
                    let userResponse = try JSONDecoder().decode(UserResponse.self, from: responsedata)
                    if let users = userResponse.data?.users {
                        complition(userResponse.data?.has_more ?? false,users)
                    }else {
                        complition(false,[])
                    }
                }catch {
                    print("Error \(error.localizedDescription)")
                }
            }else {
                complition(false,[])
            }
        }
    }
}
