//
//  NotebookListViewController.swift
//  EverPobre
//
//  Created by Eduardo on 9/10/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//

import UIKit

class NotebookListViewController: UIViewController{
    
    @IBOutlet weak var tableView:UITableView!
    
    var model : [Notebook] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        model = Notebook.dummyNotebookModel
        super.viewDidLoad()
    }
    
}

extension NotebookListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotebookListCell", for: indexPath) as! NotebookListCell
        
        cell.configure(with: model[indexPath.row])
        
        return cell
        
    }

}

extension NotebookListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let notebook = model [indexPath.row]
        let notesListVC = NotesListViewController(notebook: notebook)
        self.show(notesListVC, sender: nil)
       //  navigationController?.show(notesListVC, sender: nil)// <-se puede usar esta otra opcion
    }


//override func prepare(for segue: UIStoryboardSegue, sender:Any?){
//    if segue.identifier == "pushdet"{
//     let vc = segue.destination as! NotesListViewController
//     let indexPath = tableView.indexPathsForSelectedRows!
//     vc.notebook = model[indexPath].notebook
//        
//        
//        }
//    }
}
