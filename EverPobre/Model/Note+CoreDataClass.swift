//
//  Note+CoreDataClass.swift
//  EverPobre
//
//  Created by Eduardo on 9/10/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {

    
}

extension Note {
    
    func csv() -> String {
        let exportedTitle = title ?? "Sin Titulo"
        let exportedText = text ?? ""
        let exportedCreationDate = (creationDate as Date?)?.customStringLabel() ?? "ND"
        
        return "\(exportedCreationDate),\(exportedTitle),\(exportedText)"
    }
}
