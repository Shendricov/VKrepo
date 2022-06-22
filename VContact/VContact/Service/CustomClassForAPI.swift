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

class PhotosResponse: Decodable {
    let response: ItemsPhotoResponse
}

class ItemsPhotoResponse: Decodable{
    let items: [Photos]
}

class Photos: Decodable {
    var id: Int = 0
    var owner_id: Int = 0
    var url: String = ""
    
    enum CodKeys: String, CodingKey {
        case id
        case owner_id
        case sizes
    }
    
    enum SizeCodKeys: String, CodingKey{
        case url
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.owner_id = try container.decode(Int.self, forKey: .owner_id)
        var sizesContainer = try container.nestedUnkeyedContainer(forKey: .sizes)
        let firstSizes = try sizesContainer.nestedContainer(keyedBy: SizeCodKeys.self)
        self.url = try firstSizes.decode(String.self, forKey: .url)
    }
}
