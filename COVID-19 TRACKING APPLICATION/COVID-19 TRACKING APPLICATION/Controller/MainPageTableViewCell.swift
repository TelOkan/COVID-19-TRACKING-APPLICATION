//
//  MainPageTableViewCell.swift
//  COVID-19 TRACKING APPLICATION
//
//  Created by Okan on 1.03.2022.
//

import UIKit

class MainPageTableViewCell: UITableViewCell {
//this class for maing page tableview cell format.
    @IBOutlet weak var countryNameView: UIView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var confirmedTestLabel: UILabel!
    @IBOutlet weak var deathTollLabel: UILabel!
    @IBOutlet weak var casesLabel: UILabel!
    
    @IBOutlet weak var detailsButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
