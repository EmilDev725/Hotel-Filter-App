//
//  RoomCollectionViewCell.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 2/24/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import UIKit

class RoomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var adultsCountLabel: UILabel!
    @IBOutlet weak var bedCountLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var promotionView: UIView!
    @IBOutlet weak var promotionPercentLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var roomImageView: UIImageView!
    @IBOutlet weak var cellWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }
    
    func setupUI() {
        
        // Room Name
        roomNameLabel.font = customFont.subHeaderBoldUIFont
        roomNameLabel.textColor = configs.colorText
        
        // Adults and childern limit count label
        adultsCountLabel.font = customFont.normalUIFont
        adultsCountLabel.textColor = configs.colorText
        
        // Bed Count

        
        // Promotion Label
        promotionPercentLabel.font = customFont.subHeaderBoldUIFont
        promotionPercentLabel.textColor = configs.colorWhite
        
        // Promotion View
        promotionView.backgroundColor = configs.colorPromotion
        
        // Price
        priceLabel.font = customFont.subHeaderBoldUIFont
        priceLabel.textColor = configs.colorPromotion
        
        
    }

}
