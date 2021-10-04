//
//  CompleteCarCell.swift
//  HomeExercise
//
//  Created by Zaman Meraj on 02/10/21.
//

import UIKit

class CompleteCarCell: UITableViewCell {
    
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var prosConsStackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var prosConsStackView: UIStackView!
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            self.containerView.backgroundColor = UIColor.appLightGray
        }
    }
    
    @IBOutlet weak var carName: UILabel! {
        didSet {
            self.carName.font = UIFont.carNameFont
            self.carName.textColor = UIColor.appDarkGray
        }
    }
    
    @IBOutlet weak var carPriceLbl: UILabel! {
        didSet {
            self.carPriceLbl.font = UIFont.priceFont
            self.carPriceLbl.textColor = UIColor.appDarkGray
        }
    }
    
    @IBOutlet weak var separatorLbl: UILabel! {
        didSet {
            self.separatorLbl.backgroundColor = UIColor.appOrange
        }
    }

    var isExpanded: Bool = false {
        didSet {
            self.prosConsStackView.subviews.forEach({ $0.removeFromSuperview() })
            
            if self.isExpanded {
                self.setupStackViewFrame()
            }else {
                self.prosConsStackViewHeight.constant = 0.0
                self.containerView.frame = CGRect(x: self.containerView.frame.origin.x,
                                                  y: self.containerView.frame.origin.y,
                                                  width: self.containerView.frame.width,
                                                  height: 20+self.carName.carNameHeight+self.carPriceLbl.priceLblHeight)
            }
            self.prosConsStackView.isHidden = !self.isExpanded
        }
    }
    
    var carDetail: CarDetails? {
        didSet {
            self.carImage.image = UIImage(named: carDetail?.carImage ?? "")
            let make = (self.carDetail?.make).unwrappedString
            let model = (self.carDetail?.model).unwrappedString
            self.carName.text = make + Constants.BlankSpace.space + model
            self.carPriceLbl.text = self.carDetail?.customerPrice.roundedWithAbbreviations
            guard let rating = Rating(rawValue: (self.carDetail?.rating).unwrappedInt) else { return }
            self.setRating(rating: rating)
        }
    }
    
    private func setRating(rating: Rating) {
        self.ratingStackView.subviews.enumerated().forEach({ $0.element.isHidden = $0.offset+1 > rating.rawValue })
    }
    
    private func calculateHeightForPros(prosList: [String]?, heightValue: inout CGFloat) {
        
        if (prosList?.count ?? 0) > 0 {
            heightValue += self.setHeadingForProsAndCons(text: Constants.Heading.prosHeading,
                                                         originY: heightValue,
                                                         isBulletHidden: true)
            prosList?.forEach({ heightValue += self.setHeadingForProsAndCons(text: $0, originY: heightValue) })
        }
    }
    
    private func claculateHeightForCons(consList: [String]?, heightValue: inout CGFloat) {
        
        if (consList?.count ?? 0) > 0 {
            heightValue += self.setHeadingForProsAndCons(text: Constants.Heading.consHeading,
                                                         originY: heightValue,
                                                         isBulletHidden: true)
            consList?.forEach({ heightValue += self.setHeadingForProsAndCons(text: $0, originY: heightValue) })
        }
    }
    
    private func setupStackViewFrame() {
        
        var heightValue: CGFloat = 0.0
        let prosList = self.carDetail?.prosList.filter({ return !$0.isEmpty })
        let consList = self.carDetail?.consList.filter({ return !$0.isEmpty })
        let totalCount = (prosList?.count ?? 0) + (consList?.count ?? 0)
        if totalCount > 0 {
            calculateHeightForPros(prosList: prosList,heightValue: &heightValue)
            claculateHeightForCons(consList: consList, heightValue: &heightValue)
            let height = self.carName.carNameHeight+self.carPriceLbl.priceLblHeight+heightValue
            let size = CGSize(width: self.containerView.frame.width, height: height)
            self.containerView.frame = CGRect(origin: self.containerView.frame.origin, size: size)
            self.prosConsStackViewHeight.constant = heightValue
        }
    }
    
    func setHeadingForProsAndCons(text: String, originY: CGFloat, isBulletHidden: Bool = false) -> CGFloat {
        
        let width: CGFloat = self.prosConsStackView.frame.width
        let height = text.height(withConstrainedWidth: width, font: UIFont.prosConsFont)
        let origin = CGPoint(x: 0, y: originY)
        let frame = CGRect(origin: origin, size: CGSize(width: width, height: height))
        let prosConsList = UIView.createProsConsView(frame: frame,
                                                     text: text,
                                                     isBulletHidden: isBulletHidden)
        self.prosConsStackView.addSubview(prosConsList)
        return prosConsList.frame.height
        
    }
}
