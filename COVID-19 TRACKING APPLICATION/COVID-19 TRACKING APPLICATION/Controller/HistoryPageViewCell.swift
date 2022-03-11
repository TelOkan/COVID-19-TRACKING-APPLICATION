//
//  HistoryPageViewCell.swift
//  COVID-19 TRACKING APPLICATION
//
//  Created by Okan on 2.03.2022.
//

import UIKit

class HistoryPageViewCell: UITableViewCell {
//this class for historypage tableview format.
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var historyView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
