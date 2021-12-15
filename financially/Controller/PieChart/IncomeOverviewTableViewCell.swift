//
//  IncomeOverviewTableViewCell.swift
//  financially
//
//  Created by Sarath P on 15/12/21.
//

import UIKit

class IncomeOverviewTableViewCell: UITableViewCell {

    @IBOutlet weak var transactionTitle: UILabel!
    @IBOutlet weak var transactionCategory: UILabel!
    @IBOutlet weak var transactionAmount: UILabel!
    @IBOutlet weak var transactionDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
