//
//  SnackUsersListViewController.swift
//  Snacktacular
//
//  Created by Anastasia on 11/20/19.
//  Copyright © 2019 John Gallaugher. All rights reserved.
//

import UIKit

class SnackUsersListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var snackUsers: SnackUsers!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        snackUsers = SnackUsers()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        snackUsers.loadData {
            self.tableView.reloadData()
        }
    }
    
}

extension SnackUsersListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snackUsers.snackUserArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SnackUserTableViewCell
        cell.snackUser = snackUsers.snackUserArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
