//
//  CarDetailTableViewCell.swift
//  HomeExercise
//
//  Created by Zaman Meraj on 30/09/21.
//

import UIKit

class CarDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var carNameLbl: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var oneStarRatingView: UIView!
    @IBOutlet weak var twoStarRatingView: UIView!
    @IBOutlet weak var threeStarRatingView: UIView!
    @IBOutlet weak var fourStarRatingView: UIView!
    @IBOutlet weak var fiveStarRatingView: UIView!
    @IBOutlet weak var separatorLbl: UILabel!
    
    var carDetail: CarDetails? {
        didSet{
            self.configureCell()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureCell() {
        self.carNameLbl.text = carDetail?.make
        self.carImageView.image = UIImage(named: carDetail?.carImage ?? "")
        self.containerView.backgroundColor = ColorCodes.lightGray
        self.priceLbl.text = carDetail?.customerPrice.roundedWithAbbreviations
        self.separatorLbl.backgroundColor = ColorCodes.orange
        self.setRating()
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    private func setRating() {
        switch self.carDetail?.rating ?? 0 {
        case 0:
            break
        case 1:
            [self.twoStarRatingView, self.threeStarRatingView, self.fourStarRatingView, self.fiveStarRatingView].forEach({ $0?.isHidden = true })
            
            [self.oneStarRatingView].forEach({ $0?.isHidden = false })
            
            break
        case 2:
            [self.threeStarRatingView, self.fourStarRatingView, self.fiveStarRatingView].forEach({ $0?.isHidden = true })
            [self.oneStarRatingView, self.twoStarRatingView].forEach({ $0?.isHidden = false })
            break
        case 3:
            [self.fourStarRatingView, self.fiveStarRatingView].forEach({ $0?.isHidden = true })
            [self.oneStarRatingView, self.twoStarRatingView, self.threeStarRatingView].forEach({ $0?.isHidden = false })
            break
        case 4:
            [self.fiveStarRatingView].forEach({ $0?.isHidden = true })
            [self.oneStarRatingView, self.twoStarRatingView, self.threeStarRatingView, self.fourStarRatingView].forEach({ $0?.isHidden = false })
            break
        case 5:
            
            break
        default:
            break
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
