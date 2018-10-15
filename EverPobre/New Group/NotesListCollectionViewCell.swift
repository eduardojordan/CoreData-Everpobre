//
//  NotesListCollectionViewCell.swift
//  EverPobre
//
//  Created by Eduardo on 15/10/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//

import UIKit

class NotesListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    
    var item: Note!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with item: Note) {
        backgroundColor = .brown
        titleLabel.text = item.title
        creationDateLabel.text = (item.creationDate as Date?)?.customStringLabel()
    }
}
