//
//  RoomDetailView.swift
//  PSHotels
//
//  Created by Thet Paing Soe on 3/11/18.
//  Copyright © 2018 Panacea-soft. All rights reserved.
//

import Foundation

protocol RoomDetailViewDelegate {
    func refreshHotelData()
}


@IBDesignable
class RoomDetailView: PSUIView  {
    
    var roomViewModel : RoomViewModel = RoomViewModel()
    var roomData : Room? = nil
    var delegate : RoomDetailViewDelegate? = nil
    
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var guestRatingLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var hotelDescLabel: UILabel!
    @IBOutlet weak var inquiryButton: UIButton!
    @IBOutlet weak var favImageView: UIImageView!
    @IBOutlet weak var priceTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var guestLimitTitleLabel: UILabel!
    @IBOutlet weak var guestLimitLabel: UILabel!
    @IBOutlet weak var bedsTitleLabel: UILabel!
    @IBOutlet weak var bedsLabel: UILabel!
    @IBOutlet weak var roomSizeTitleLabel: UILabel!
    @IBOutlet weak var roomSizeLabel: UILabel!
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var roomFeatureHeight: NSLayoutConstraint!
    @IBOutlet weak var roomFeaturesContainer: RoomFeaturesView!
   
    // MARK: - Override Functions
    override func initVariables() {
        roomViewModel.nibName = "RoomDetailView"
    }
    
    // MARK: - Override Functions
    // joining DetailView.swift and DetailView.xib
    override func getNibName() -> String {
        return roomViewModel.nibName
    }
    
    override func initUIViewAndActions() {
        super.initUIViewAndActions()
        
        setupUI()
        
        // Loading Monitoring
        roomViewModel.isLoading.bind{
            if($0) {
                Common.instance.showBarLoading()
            }else {
                Common.instance.hideBarLoading()
            }
        }
    }
    
    override func initData() {
        roomViewModel.getRoomById(loginUserId: loginUserId, roomId: (roomData?.room_id)!)
        roomViewModel.roomByRoomIdLiveData.bind{ [weak self] in
            
            if let resourse : Resourse<Room> = $0 {
                
                if resourse.status == Status.SUCCESS
                    || resourse.status == Status.LOADING {
                    
                    if let room : Room = resourse.data {
                        
                        self?.bindRoomData(room: room)
                        
                    }
                    
                } else if resourse.status == Status.ERROR {
                    print("Error in loading data. Message : " + resourse.message)
                }
            }else {
                print("Something Wrong")
            }
            
        }
        
        roomFeaturesContainer.delegate = self
        roomFeaturesContainer.roomData = self.roomData
        roomFeaturesContainer.setup()
        
        roomViewModel.doPostRoomTouchCount(roomId: (roomData?.room_id)!, loginUserId: super.loginUserId)
        
        roomViewModel.postRoomTouchCountLiveData.bind{
            if let resourse : Resourse<ApiStatus> = $0 {
                
                if resourse.status == Status.SUCCESS ||
                    resourse.status == Status.LOADING {
                    
                    print("Post Count Success.")
                    
                }else {
                    print("Error in loading data. Message : " + resourse.message)
                }
            }else {
                print("Something Wrong")
            }
        }
    }
    
    func bindRoomData(room: Room) {
        // hotel name
        hotelNameLabel.text = room.room_name
        
        // guest rating
        guestRatingLabel.text = "\(room.rating.final_rating) \(room.rating.rating_text)"
        
        // review count
        reviewCountLabel.text = "\(room.rating.review_count) \(language.search__review)"
        
        // hotel desc
        hotelDescLabel.text = room.room_desc
        hotelDescLabel.setLineHeight(height: configs.lineSpacing)
        
        // price
        priceTitleLabel.text = language.hotel__pricePerNight
        priceLabel.text = "\(room.currency_symbol) \(room.room_price)"
        
        // Guest Limit
        guestLimitTitleLabel.text = language.hotel__guestLimit
        guestLimitLabel.text = "\(room.room_adult_limit) \(language.hotel__adults) \(room.room_kid_limit) \(language.hotel__kids)"
        
       
        
        // hotel ImageView
        let imageURL = configs.imageUrl + room.default_photo.img_path
        
        hotelImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "PlaceholderImage"))
    }
    
    
    @IBAction func inquiryClicked(_ sender: Any) {
        PSNavigationController.instance.navigateToInquiry(hotelId: (roomData?.hotel_id)!, roomId: (roomData?.room_id)!)
        PSNavigationController.instance.updateBackButton()
    }
    
    func setupUI() {
        // hotel name
        hotelNameLabel.font = customFont.headerUIFont
        hotelNameLabel.textColor = configs.colorText
        
        // guest Rating
        guestRatingLabel.font = customFont.tagUIFont
        guestRatingLabel.textColor = configs.colorReviewTitle
        
        // review count
        reviewCountLabel.font = customFont.tagUIFont
        reviewCountLabel.textColor = configs.colorTextLight
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(RoomDetailView.openReviewList))
        reviewCountLabel.addGestureRecognizer(singleTap)
        
        // hotel desc
        hotelDescLabel.font = customFont.normalUIFont
        hotelDescLabel.textColor = configs.colorText
        hotelDescLabel.setLineHeight(height: configs.lineSpacing)
        
        // price
        priceTitleLabel.font = customFont.normalBoldUIFont
        priceTitleLabel.textColor = configs.colorText
        priceLabel.font = customFont.normalBoldUIFont
        priceLabel.textColor = configs.colorPromotion
        
        // checkout in/out
        guestLimitTitleLabel.font = customFont.normalBoldUIFont
        guestLimitTitleLabel.textColor = configs.colorText
        guestLimitLabel.font = customFont.normalUIFont
        guestLimitLabel.textColor = configs.colorText
        

        
        // Gallery
        let singleTap2 = UITapGestureRecognizer(target: self, action: #selector(HotelDetailView.openGallery))
        hotelImageView.addGestureRecognizer(singleTap2)
    }
    
    @objc func openGallery() {
        print("Clicked open Gallery")
        PSNavigationController.instance.navigateToGallery((self.roomData?.room_id)!)
        PSNavigationController.instance.updateBackButton()
    }
    
    @objc func openReviewList() {
        print("Clicked openReviewList")
        PSNavigationController.instance.navigateToRoomReviewList(roomData: roomData!, delegate: self)
        PSNavigationController.instance.updateBackButton()
    }
}


extension RoomDetailView : RoomFeaturesViewDelegate {
    func resizeRoomFeaturesContainer(_ height: CGFloat) {
        roomFeatureHeight.constant = height
    }

}

extension RoomDetailView : RoomReviewListViewDelegate {
    func refreshReviewData() {
        roomViewModel.getRoomById(loginUserId: loginUserId, roomId: (roomData?.room_id)!)
        
        delegate?.refreshHotelData()
    }
    
}


