//
//  NoteDetailsViewController.swift
//  EverPobre
//
//  Created by Eduardo on 9/10/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//

import UIKit
import CoreData

protocol NoteDeatailsViewControllerProtocol: class {
    func didSaveNote()
}

class NoteDetailsViewController: UIViewController {
    
   
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var titleTextField: UITextField!
    
    @IBOutlet var tagsLabel: UILabel!
    
    @IBOutlet var creationDateLabel: UILabel!
    
    @IBOutlet var lastSeenDateLabel: UILabel!
  
    @IBOutlet var descriptionTextView: UITextView!
    
    
   
    
    //    let note: Note
    enum Kind {
        case new(notebook:Notebook)
        case existing(note:Note)
    }
    
    
    let managedContex: NSManagedObjectContext
    let kind: Kind
    
    weak var delegate:NoteDeatailsViewControllerProtocol?
    
    init(kind: Kind, managedContex: NSManagedObjectContext) {
        self.kind = kind
        self.managedContex = managedContex
        super.init(nibName: "NoteDetailsViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(with: kind)
    }
    
    private func configure(with kind: Kind) {
        switch kind {
        case .new:
            let saveButtonItem = UIBarButtonItem(barButtonSystemItem: .save
                , target: self, action: #selector(saveNote))
            self.navigationItem.rightBarButtonItem = saveButtonItem
            let cancelButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
            navigationItem.leftBarButtonItem = cancelButtonItem
            configureValues()
        case .existing:
            configureValues()
        }
    }
    
    @objc private func saveNote() {
        
        switch kind {
        case .existing(let note ):
            note.title = titleTextField.text
            note.text = descriptionTextView.text
            note.lastSeenDate = NSDate()
            
            do{
                try managedContex.save()
                delegate?.didSaveNote()
            } catch let error as NSError{
                print("error:\(error.localizedDescription)")
            }
            navigationController?.popViewController(animated:true)
        case .new(let notebook):
           let note = Note(context: managedContex)
           note.title = titleTextField.text
           note.text = descriptionTextView.text
           note.creationDate = NSDate()
           note.notebook = notebook
            
           if let notes = notebook.notes?.mutableCopy() as? NSMutableOrderedSet{
             notes.add(note)
             notebook.notes = notes
            }
           
           do{
            try managedContex.save()
             delegate?.didSaveNote()
           } catch let error as NSError{
            print("error:\(error.localizedDescription)")
            }
           
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    @objc private func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    private func configureValues() {
        title = kind.title
        titleTextField.text = kind.note?.title
        //tagsLabel.text = note.tags?.joined(separator: ",")
        creationDateLabel.text = "Creado: \((kind.note?.creationDate as Date?)?.customStringLabel() ?? "ND")"
        lastSeenDateLabel.text = "Visto: \((kind.note?.lastSeenDate as Date?)?.customStringLabel() ?? "ND")"
        descriptionTextView.text = kind.note?.text ?? "Ingrese texto..."
    }
    
}

private extension NoteDetailsViewController.Kind {
    var note: Note? {
        guard case let .existing(note) = self else { return nil }
        return note
    }
    
    var title: String {
        switch self {
        case .existing:
            return "Detalle"
        case .new:
            return "Nueva Nota"
        }
    }
}
