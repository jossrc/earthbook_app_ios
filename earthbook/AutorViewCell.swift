//
//  AutorViewCell.swift
//  earthbook
//
//  Created by CARLOS LOZANO ARANCIAGA on 7/2/22.
//

import UIKit

class AutorViewCell: UITableViewCell {

    @IBOutlet weak var lblIdAutor: UILabel!
    @IBOutlet weak var lblNombreAutor: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
