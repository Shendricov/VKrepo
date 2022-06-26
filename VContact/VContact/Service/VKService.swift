//
//  VKService.swift
//  VContact
//
//  Created by Wally on 15.06.2022.
//

import Foundation
import Alamofire

class VKService {

    enum Methods: String {
        case friends = "/method/friends.get"
        case photo = "/method/photos.get"
        case getGroups = "/method/groups.get"
//        case searchGroup = "/method/groups.search"
//        case user = "/method/users.get"
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
        url.queryItems = [URLQueryItem(name: "user_id", value: Session.user.userID),
                          URLQueryItem(name: "v", value: "5.81"),
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
    
    func getCollectionFriends(completion: @escaping ([Friends]) -> Void) {
        let url = getURL(requestMethod: .friends)
        Alamofire.request(url).responseJSON(completionHandler: {response in
            guard let data = response.data else { return }
            do {
            let json = try JSONDecoder().decode(FriendsResponse.self, from: data)
            let friends = json.response.items
            completion(friends)
            } catch {
                print(error.localizedDescription)
            }
        })
    }
    
    func getCollectionPhotos(completion: @escaping ([UIImage]) -> Void) {
        let url = getURL(requestMethod: .photo)
        var photos = [UIImage]()
        Alamofire.request(url).responseJSON(completionHandler: {response in
            guard let data = response.data else { return }
            let json = try! JSONDecoder().decode(PhotosResponse.self, from: data)
            let arrayWithDataPhotos = json.response.items
            
            for element in arrayWithDataPhotos {
                do {
                let urlFile = URL(string: element.url)
                let photoData = try Data(contentsOf: urlFile!)
                    let image: UIImage = UIImage(data: photoData)!
                    photos.append(image)
                } catch {
                    print(error.localizedDescription)
                }
            }
        })
        completion(photos)
    }
    
    func getCollectionGroups(completion: @escaping ([Groups]) -> Void) {
        let url = getURL(requestMethod: .getGroups)
        Alamofire.request(url).responseJSON(completionHandler: {response in
            guard let data = response.data else { return }
            do {
            let json = try JSONDecoder().decode(GroupsResponse.self, from: data)
            let groups = json.response.items
            completion(groups)
            } catch {
                print(error.localizedDescription)
            }
        })
    }
    
}
