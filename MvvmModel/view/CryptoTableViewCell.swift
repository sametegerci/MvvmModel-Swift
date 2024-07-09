//
//  CryptoTableViewCell.swift
//  MVVMModelYazmak
//
//  Created by Mehmet Samet Eğerci on 6.07.2024.
//

import UIKit
import RxSwift
import RxCocoa

class CryptoTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public var item : Cryptos! {
        didSet {
            self.nameLabel.text = item.currency
            self.priceLabel.text = item.price
        }
    }
    

}
