//
//  PostagemTableViewCell.swift
//  InstagramC
//
//  Created by Jeferson Dias dos Santos on 12/12/22.
//

import UIKit

class PostagemTableViewCell: UITableViewCell {

    @IBOutlet weak var fotoPostagem: UIImageView!
    @IBOutlet weak var descricaoPostagem: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
