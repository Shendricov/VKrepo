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
        case friends = "/method/friends.getLists"
        case photo = "/method/photos.getAll"
        case getGroups = "/method/groups.get"
        case searchGroup = "/method/groups.search.g"
    }
    
    
    
    let currentSession: URLSession = {
        let configure = URLSessionConfiguration.default
        return URLSession(configuration: configure)
    }()
    
    func quertyURLSession(method: Methods){
    var url = URLComponents()
    url.scheme = "https"
        url.host = "api.vk.com"
        url.path =  method.rawValue
    url.queryItems = [URLQueryItem(name: "user-id", value: Session.user.userID),
                      URLQueryItem(name: "v", value: "5.81"),
                      URLQueryItem(name: "access_token", value: Session.user.token)]
        let request = URLRequest(url: url.url!)
        let task = currentSession.dataTask(with: request) { data, response, error in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            let resultRequest = json as! Dictionary<String,Any>
            print("//////////////////////////==============////////////////")
            print(resultRequest)
        }
    
        task.resume()
    }
    
    func getAlamofireResponse(method: Methods) {
        let configure = URLSessionConfiguration.default
        let sessionManager = Alamofire.SessionManager(configuration: configure)
        var url = URLComponents()
        url.scheme = "https"
        url.host = "api.vk.com"
        url.path = method.rawValue
        
        let parametrs: Parameters = [
            "user-id":Session.user.userID,
            "v":"5.81",
            "access_token":Session.user.token
        ]
        sessionManager.request(url,parameters: parametrs).responseJSON(completionHandler: {response in
            switch response.result {
            case .failure(let error):
                print("Error \(error.localizedDescription)")
            case .success(let result):
                print(result as! Dictionary<String,Any>)
            }
        })
        
        
    }
    
    
}
