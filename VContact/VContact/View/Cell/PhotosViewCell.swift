//
//  CollectionViewCell.swift
//  VContact
//
//  Created by Mikhail Shendrikov on 10.05.2022.
//

import UIKit

class PhotosViewCell: UICollectionViewCell {
    @IBOutlet weak var pfotoImage: UIImageView!
    @IBOutlet weak var heardImage: UIImageView!
    @IBOutlet weak var countLike: UILabel!
    private var numberLikesTap: Int = 0
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        countLike.text = String(numberLikesTap)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLike()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLike()
    }
    
    private func setupLike() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLike(_:)))
        addGestureRecognizer(tap)
    }
    
    @objc private func tapLike(_ gestureRecognise: UITapGestureRecognizer) {
        if numberLikesTap == 0 {
            heardImage.image = .init(systemName: "heart.fill")
            heardImage.tintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            numberLikesTap = 1
            countLike.text = String(numberLikesTap)
        } else {
            heardImage.image = .init(systemName: "heart")
            heardImage.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            numberLikesTap = 0
            countLike.text = String(numberLikesTap)
        }
    }
    
}


@IBDesignable
class LikeViewControl: UIControl {
   
    /*
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 20, y: 20))
        path.addLine(to: CGPoint(x: 10, y: 10))
        path.addArc(withCenter: CGPoint(x: 15, y: 10), radius: 5, startAngle: .pi, endAngle: .pi*2, clockwise: true)
        path.addArc(withCenter: CGPoint(x: 25, y: 10), radius: 5, startAngle: .pi, endAngle: .pi*2, clockwise: true)
        path.close()
        
        context?.addPath(path)
    }
    */
    
}
