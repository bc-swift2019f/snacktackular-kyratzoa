//
//  Spots.swift
//  Snacktacular
//
//  Created by Anastasia on 10/29/19.
//  Copyright © 2019 John Gallaugher. All rights reserved.
//

import Foundation
import Firebase

class Spots{
    var spotArray = [Spot]()
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    func loadData(completed: @escaping () -> ()){
        db.collection("spots").addSnapshotListener { (querySnapshot, error) in
        guard error == nil else {
            print("*** ERROR: adding the snapshot listener \(error!.localizedDescription)")
            return completed()
        }
        self.spotArray = []
        // there are querySnapshot!.documents.count documents in the spots snapshot
        for document in querySnapshot!.documents {
            let spot = Spot(dictionary: document.data())
            spot.documentID = document.documentID
            self.spotArray.append(spot)
        }
        completed()
    }
}
}
