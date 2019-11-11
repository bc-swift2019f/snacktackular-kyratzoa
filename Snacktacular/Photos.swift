//
//  Photos.swift
//  Snacktacular
//
//  Created by Anastasia on 11/10/19.
//  Copyright © 2019 John Gallaugher. All rights reserved.
//

import Foundation
import Firebase

class Photos{
    var photoArray: [Photo] = []
    var db: Firestore!
    
    init(){
        db = Firestore.firestore()
    }
    
    func loadData(spot: Spot, completed: @escaping () -> ())  {
        guard spot.documentID != "" else {
            return
        }
        
        db.collection("spots").document(spot.documentID).collection("photos").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("*** ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            let storage = Storage.storage()
            self.photoArray = []
            var loadAttempts = 0
            let storageRef = self.storage.reference().child(spot.documentID)
            for document in querySnapshot!.documents {
                let photo = Photo(dictionary: document.data())
                photo.documentUUID = document.documentID
                self.photoArray.append(photo)
                // Code to get images from Firebase Storage will go here
                let photoRef = storageRef.child(photo.documentUUID)
                photoRef.getData(maxSize: 25 * 1024 * 1024) { data, error in
                    if let error = error {
                        print("An error occurred while reading data from file ref: \(photoRef), error \(error.localizedDescription)")
                        loadAttempts += 1
                        if loadAttempts >= querySnapshot!.documents.count {
                            return completed()
                        }
                    } else {
                        let image = UIImage(data: data!)
                        photo.image = image!
                        loadAttempts += 1
                        if loadAttempts >= querySnapshot!.documents.count {
                            return completed()
                        }
                    }
                }
            }
        }
    }
}
