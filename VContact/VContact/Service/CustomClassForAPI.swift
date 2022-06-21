//
//  User.swift
//  VContact
//
//  Created by Mikhail Shendrikov on 18.06.2022.
//

import Foundation

//MARK: Class for Friends
class FriendsResponse: Decodable {
    let response: ListsFriendsResponse
}

class ListsFriendsResponse: Decodable {
    var items: [Friends]
}

class Friends: Decodable {
    var id: Int = 0
    var first_name: String = ""
    var last_name: String = ""
}

//MARK: Class for Groups

class GroupsResponse: Decodable {
    let response: ListsGroupsResponce
}

class ListsGroupsResponce: Decodable {
    let items: [Groups]
}

class Groups: Decodable {
    var id: Int = 0
    var name: String = ""
}

//MARK: Class for Photos
