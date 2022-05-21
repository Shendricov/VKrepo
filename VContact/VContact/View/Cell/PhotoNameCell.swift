//
//  PhotoNameCell.swift
//  VContact
//
//  Created by Mikhail Shendrikov on 09.05.2022.
//

import UIKit


class PhotoNameCell: UITableViewCell {
    
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    let subViewAvatar = UIView()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
   var opacityShadow: Float = 1
   var widthShadow: CGFloat = -2
   var colorShadow: CGColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
//        layer.masksToBounds = false
                
//        avatar.layer.backgroundColor = #colorLiteral(red: 0.9465178847, green: 1, blue: 0.6836723089, alpha: 1).cgColor
//        avatar.layer.cornerRadius = 21
//        avatar.layer.masksToBounds = true
//
//
//        subViewAvatar.layer.frame = avatar.frame
//        subViewAvatar.layer.cornerRadius = 21
//        subViewAvatar.layer.masksToBounds = false
//        subViewAvatar.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
//        subViewAvatar.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
//        subViewAvatar.layer.shadowRadius = 10
//        subViewAvatar.layer.shadowOpacity = 0.5
        
        
//        rootView.layer.masksToBounds = false
//        rootView.addSubview(subViewAvatar)
//        rootView.bringSubviewToFront(avatar)

        
    }
    
}
