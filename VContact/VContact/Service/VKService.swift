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
        url.queryItems = [URLQueryItem(name: "user_ids", value: Session.user.userID),
                          URLQueryItem(name: "fields", value: "first_name"),
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
}
