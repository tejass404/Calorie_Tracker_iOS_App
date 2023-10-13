//
//  ViewDataTableViewCell.swift
//  CalorieTracker03
//
//  Created by LMD User on 10/13/23.
//  Copyright © 2023 mac. All rights reserved.
//

import UIKit

class ViewDataTableViewCell: UITableViewCell {

    @IBOutlet weak var viewButton: UIButton!
    @IBOutlet weak var netCalorieLabel: UILabel!
    
    @IBOutlet weak var calorieOutLabel: UILabel!
    @IBOutlet weak var calorieInLabel: UILabel!
    @IBOutlet weak var bmrLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
