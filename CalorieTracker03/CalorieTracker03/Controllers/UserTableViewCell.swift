//
//  UserTableViewCell.swift
//  CalorieTracker03
//
//  Created by mac on 06/10/23.
//  Copyright © 2023 mac. All rights reserved.
//

import UIKit


class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var bmrField: UILabel!
    @IBOutlet weak var weightField: UILabel!
    @IBOutlet weak var heightField: UILabel!
    @IBOutlet weak var ageField: UILabel!
    @IBOutlet weak var name: UILabel!

    @IBOutlet weak var viewDataBtn: UIButton!
    @IBOutlet weak var addDataBtn: UIButton!

    
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
