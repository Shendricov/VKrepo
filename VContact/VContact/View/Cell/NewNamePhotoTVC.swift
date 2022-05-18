//
//  NewNamePhotoTVC.swift
//  VContact
//
//  Created by Wally on 18.05.2022.
//

import UIKit

//@IBDesignable
class NewNamePhotoTVC: UITableViewCell {

    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        avatar.layer.masksToBounds = true
        avatar.layer.cornerRadius = 20
        avatar.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
        let subViewAvatar = UIView(frame: avatar.frame)
        subViewAvatar.layer.masksToBounds = false
        subViewAvatar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        subViewAvatar.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        subViewAvatar.layer.shadowRadius = 10
        subViewAvatar.layer.shadowOpacity = 1
        
        rootView.addSubview(subViewAvatar)
        rootView.bringSubviewToFront(subViewAvatar)
    }
    
}
