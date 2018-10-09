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
