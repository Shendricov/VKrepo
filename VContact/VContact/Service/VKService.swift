//
//  VKService.swift
//  VContact
//
//  Created by Wally on 15.06.2022.
//

import Foundation
import Alamofire
import Kingfisher
import RealmSwift
import UIKit

class VKService {

    enum Methods: String {
        case friends = "/method/friends.get"
        case photo = "/method/photos.get"
        case getGroups = "/method/groups.get"
        case searchGroup = "/method/groups.search"
        case user = "/method/users.get"
    }
    
    
    
//    let currentSession: URLSession = {
//        let configure = URLSessionConfiguration.default
//        return URLSession(configuration: configure)
//    }()
    
    func getURL (requestMethod: Methods) -> URLComponents {
        
        var url = URLComponents()
        url.scheme = "https"
        url.host = "api.vk.com"
        url.path =  requestMethod.rawValue
        url.queryItems = [URLQueryItem(name: "user-id", value: Session.user.userID),
                          URLQueryItem(name: "v", value: "5.131"),
                          URLQueryItem(name: "access_token", value: Session.user.token)]
        var extraQueryItem = URLQueryItem(name: "", value: "")
        if requestMethod == .friends {
            extraQueryItem = URLQueryItem(name: "fields", value: "first_name")
        } else if requestMethod == .getGroups {
            extraQueryItem = URLQueryItem(name: "extended", value:  "1")
        } else if requestMethod == .photo {
            extraQueryItem = URLQueryItem(name: "album_id", value:  "wall")
        }
        url.queryItems?.append(extraQueryItem)
        return url
    }
//    MARK: Получаем и обрабатываем данные для сцены Friends.
    
    func saveFriendsData(friends: [Friends]) {
        do {
//            MARK: Удалить при размещении
            var configuration = Realm.Configuration.defaultConfiguration
            configuration.deleteRealmIfMigrationNeeded = false
        
            let realm = try Realm(configuration: configuration)
            let oldFriends = realm.objects(Friends.self)
            realm.beginWrite()
            realm.delete(oldFriends)
            realm.add(friends)
            try realm.commitWrite()
            print(realm.configuration.fileURL)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getFriends() {
        let url = getURL(requestMethod: .friends)
        Alamofire.request(url).responseJSON(completionHandler: {response in
            guard let data = response.data else { return }
            do {
            let json = try JSONDecoder().decode(FriendsResponse.self, from: data)
                let friendsArr = (json.response.items)
                self.saveFriendsData(friends: friendsArr)
            } catch {
                Swift.print(error.localizedDescription)
            }
        })
    }
    
//    func getUsersIdInfo(complation: @escaping ([UserWithAvatar]) -> Void) {
//        var friendsArrayWithID: [Friends] = []
//        getFriends(completion: {friends in
//            friendsArrayWithID = friends})
//
//            for friend in friendsArrayWithID {
//                var urlUser = URLComponents()
//                urlUser.scheme = "https"
//                urlUser.host = "api.vk.com"
//                urlUser.path = Methods.user.rawValue
//                urlUser.queryItems = [
//                    URLQueryItem(name: "user_ids", value: String(friend.id)),
//                    URLQueryItem(name: "v", value: "5.81"),
//                    URLQueryItem(name: "access_token", value: Session.user.token),
//                    URLQueryItem(name: "fields", value: "photo_50")
//                ]
//                Alamofire.request(urlUser).responseJSON(completionHandler: {response in
//                    guard let data = response.data else { return }
//                    do {
//                        let json = try JSONDecoder().decode(UserWithAvatarResponse.self, from: data)
//                        complation(json.response)
//                    } catch {
//                        print (error.localizedDescription)
//                    }
//                })
//            }
//    }
//
//    func getAvatarUser(user: UserWithAvatar, complation: (UIImageView) -> Void) {
//        let urlPhoto = URL(string: user.urlPhoto)
//        let avatarImage = UIImageView()
//            avatarImage.kf.setImage(with: urlPhoto)
//            complation(avatarImage)
//    }
    func savePhotoData(photos: [Photos]) {
        do {
        let realm = try Realm()
            let oldPhotos = realm.objects(Photos.self)
        try realm.write({
            realm.delete(oldPhotos)
            realm.add(photos)
            print(realm.configuration.fileURL)
        })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getCollectionPhotos(completion: @escaping () -> Void) {
        let url = getURL(requestMethod: .photo)
        Alamofire.request(url).responseJSON(completionHandler: {response in
            guard let data = response.data else { return }
            let json = try! JSONDecoder().decode(PhotosResponse.self, from: data)
            let photosArray = json.response.items
            self.savePhotoData(photos: photosArray)
            completion()
        })
    }
    
    func getImageViewPhoto(photos: [Photos], complation: @escaping ([UIImageView]) -> Void) {
        var arrayPhotoImage = [UIImageView]()
        for photo in photos {
           let usr = URL(string: photo.url)
            let imagePhoto = UIImageView()
            imagePhoto.kf.setImage(with: usr)
            arrayPhotoImage.append(imagePhoto)
        }
        complation(arrayPhotoImage)
    }
    
    func saveGroupsData(groups: [Group]) {
        do {
//        var configuretion = Realm.Configuration.defaultConfiguration
//        configuretion.deleteRealmIfMigrationNeeded = true
        let realm = try Realm()
        let oldGroups = realm.objects(Group.self)
        try realm.write({
            realm.delete(oldGroups)
            realm.add(groups)
        })
            print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
            print(realm.configuration.fileURL)
        } catch {
            print(error.localizedDescription)
        }
    }
        func getCollectionGroups() {
            let url = getURL(requestMethod: .getGroups)
            Alamofire.request(url).responseJSON(completionHandler: {response in
                guard let data = response.data else { return }
                do {
                    let json = try JSONDecoder().decode(GroupsResponse.self, from: data)
                    let groups = json.response.items
                    var groupsFromAPI: [Group] = [Group(title: "KiteSerfing", selected: true), Group(title: "Cosmos", selected: false),Group(title: "Programming", selected: true),Group(title: "Serfing", selected: true),Group(title: "Formula1", selected: false)]
                    groups.forEach({ group in
                        let result = Group(title: group.titles, selected: false)
                        groupsFromAPI.append(result)
                    })
                    self.saveGroupsData(groups: groupsFromAPI)
                    
                } catch {
                    print(error.localizedDescription)
                }
            })
        }
    }



