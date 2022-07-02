//
//  User.swift
//  VContact
//
//  Created by Mikhail Shendrikov on 18.06.2022.
//

import Foundation
import RealmSwift
//MARK: Class for Friends
class FriendsResponse: Decodable {
     var response: ListsFriendsResponse
}

class ListsFriendsResponse: Decodable {
    var items: [Friends]
}

class Friends: Object, Decodable {
    @Persisted var id: Int = 0
    @Persisted var first_name: String = ""
    @Persisted var last_name: String = ""
    
//    override static func primaryKey() -> String? {
//        return "id"
//    }
}

//MARK: Class for Groups

class GroupsResponse: Decodable {
    let response: ListsGroupsResponce
}

class ListsGroupsResponce: Decodable {
    let items: [Groups]
}

class Groups: Object, Decodable {
    @Persisted var id: Int = 0
    @Persisted var titles: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case titles = "name"

    }
}
//MARK: Class for Photos

class PhotosResponse: Decodable {
    let response: ItemsPhotoResponse
}

class ItemsPhotoResponse: Decodable{
    let items: [Photos]
}

class Photos: Object, Decodable {
    @Persisted var id: Int = 0
    @Persisted var owner_id: Int = 0
    @Persisted var url: String = ""
    
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

//MARK: User with avatar image

class UserWithAvatarResponse: Decodable{
    let response: [UserWithAvatar]
}

class UserWithAvatar: Decodable {
    var first_name: String = ""
    var last_name: String = ""
    var urlPhoto: String = ""
    
    enum KeyCod: String, CodingKey {
        case first_name, last_name
        case urlPhoto = "photo_50"
    }
}
