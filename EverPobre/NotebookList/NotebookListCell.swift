//
//  NotebookListCell.swift
//  EverPobre
//
//  Created by Eduardo on 9/10/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//

import UIKit


class NotebookListCell: UITableViewCell{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    
    override func prepareForReuse() {
        titleLabel.text = nil
        creationDateLabel.text = nil
    }
    
    func configure(with notebook: Notebook){
        titleLabel.text = notebook.name
        creationDateLabel.text = creationString(from: notebook.creationDate)
        
    }
    
    private func creationString(from date: Date)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        return "Creando: \(dateFormatter.string(from:date))"
    }
    
}
