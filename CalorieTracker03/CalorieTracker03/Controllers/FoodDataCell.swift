//
//  FoodDataCell.swift
//  CalorieTracker03
//
//  Created by LMD User on 10/13/23.
//  Copyright © 2023 mac. All rights reserved.
//

import UIKit

class FoodDataCell: UITableViewCell {
    
    
    @IBOutlet weak var calorieInLabel: UILabel!
    @IBOutlet weak var servingLabel: UILabel!
    
    @IBOutlet weak var foodGroupLabel: UILabel!
    @IBOutlet weak var mealTypeLabel: UILabel!
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
