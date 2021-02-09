//
//  ActionTableViewCell.swift
//  Savour
//
//  Created by FNSPL on 26/01/21.
//  Copyright © 2021 FNSPL. All rights reserved.
//

import UIKit

class ActionTableViewCell: UITableViewCell {

    @IBOutlet weak var lblReturn: UILabel!
    @IBOutlet weak var lblDining: UILabel!
    @IBOutlet weak var lblAttendance: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var shadowVw: UIView!
    @IBOutlet weak var holderVw: UIView!
    @IBOutlet weak var vwIndicator: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
