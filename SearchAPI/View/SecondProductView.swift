//
//  SecondProductView.swift
//  SearchAPI
//
//  Created by Ashish Singh Chauhan on 27/02/20.
//  Copyright © 2020 Ashish Singh Chauhan. All rights reserved.
//

import UIKit

class SecondProductView: UITableViewCell {

    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
