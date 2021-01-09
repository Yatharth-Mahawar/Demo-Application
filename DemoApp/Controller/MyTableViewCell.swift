//
//  MyTableViewCell.swift
//  DemoApp
//
//  Created by Yatharth Mahawar on 1/8/21.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatarImg.layer.cornerRadius = self.avatarImg.frame.size.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func deleteButton(_ sender: UIButton) {
    }
}
