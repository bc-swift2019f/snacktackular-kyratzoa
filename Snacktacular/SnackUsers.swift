//
//  SnackUsers.swift
//  Snacktacular
//
//  Created by Anastasia on 11/20/19.
//  Copyright © 2019 John Gallaugher. All rights reserved.
//

import Foundation
import Firebase

class SnackUsers{
    var snackUserArray = [SnackUser]()
    var db: Firestore!
    
    init(){
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ()){
        db.collection("users").addSnapshotListener{ (querySnapshot, error) in
            guard error == nil else{
                print("ERROR: adding snapshotListener \(error!.localizedDescription)")
                return completed()
            }
            self.snackUserArray = []
            for document in querySnapshot!.documents{
                let snackUser = SnackUser(dictionary: document.data())
                snackUser.documentID = document.documentID
                self.snackUserArray.append(snackUser)
            }
            completed()
        }
    }
}
