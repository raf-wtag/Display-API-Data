//
//  CustomTableViewCell.swift
//  DataDisplayed
//
//  Created by Fahim Rahman on 28/3/21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    @IBOutlet weak var forecastDate: UILabel!
    @IBOutlet weak var forecastMaxTemp: UILabel!
    @IBOutlet weak var forecastMinTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
