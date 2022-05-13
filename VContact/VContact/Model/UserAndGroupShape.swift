//
//  UserAndGroupShape.swift
//  VContact
//
//  Created by Mikhail Shendrikov on 09.05.2022.
//

import Foundation
import UIKit

protocol UserProtocol {
    var name: String { get set }
//    var avatar: UIImage { get set }
//    var photos: [UIImage] { get set }
}

struct User: UserProtocol,Equatable {
    var name: String
//    var avatar: UIImage
//    var photos: [UIImage]
    
}

protocol GroupProtocol {
    var title: String { get set }
//    var avatar: UIImage { get set }
}

struct Group: GroupProtocol, Equatable {
    var title: String
    var selected: Bool = false
//    var avatar: UIImage
}

