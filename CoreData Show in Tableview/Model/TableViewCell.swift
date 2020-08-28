//
//  TableViewCell.swift
//  CoreData Show in Tableview
//
//  Created by Mac on 28/08/20.
//  Copyright © 2020 Gunde Ramakrishna Goud. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var universityLbl: UILabel!
    
    var college : Colleges?
    {
        didSet{
            nameLbl.text = "Name: \(college?.name ?? "")"
            addressLbl.text = "Address: \(college?.address ?? "")"
            universityLbl.text = "Univercity: \(college?.univercity ?? "")"
            img.image = UIImage(data: college!.profileImage!)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        img.layer.cornerRadius = img.frame.size.height / 2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
