//
//  CustomCollectionViewCell.swift
//  Test_Task
//
//  Created by Марк Шнейдерман on 09.02.2021.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var pictureImageView: UIImageView!
    
    
    func configure(with image : String)
    {
        pictureImageView.sd_setImage(with: URL(string: image), placeholderImage: nil)
    }


}
