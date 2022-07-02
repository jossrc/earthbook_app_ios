//
//  CategoriaViewCell.swift
//  earthbook
//

import UIKit

class CategoriaViewCell: UITableViewCell {

    @IBOutlet weak var txtIdCategoria: UILabel!
    @IBOutlet weak var txtNombreCategoria: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
