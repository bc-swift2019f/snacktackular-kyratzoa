//
//  Photo.swift
//  Snacktacular
//
//  Created by Anastasia on 11/10/19.
//  Copyright © 2019 John Gallaugher. All rights reserved.
//

import Foundation
import Firebase

class Photo{
    var image: UIImage
    var description: String
    var postedBy: String
    var date: Date
    var documentUUID: String //Universal Identifier
    var dictionary: [String: Any]{
        return["description": description, "postedBy": postedBy, "Date": date]
    }
    
    init(image: UIImage, description: String, postedBy: String, date: Date, documentUUID: String){
        self.image = image
        self.description = description
        self.postedBy = postedBy
        self.date = date
        self.documentUUID = documentUUID
    }
    
    convenience init(){
        let postedBy = Auth.auth().currentUser?.email ?? "Unknown User"
        self.init(image: UIImage(), description: "", postedBy: postedBy, date: Date(), documentUUID: "")
    }
    
    convenience init(dictionary: [String: Any]) {
        let description = dictionary["description"] as! String? ?? ""
        let postedBy = dictionary["postedBy"] as! String? ?? ""
        let time = dictionary["date"] as! Timestamp?
        let date = time?.dateValue() ?? Date()
        self.init(image: UIImage(), description: description, postedBy: postedBy, date: date, documentUUID: "")
    }
    
    func saveData(spot: Spot, completed: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        let storage = Storage.storage() // Create a Storage instance, just like db
        // Convert image to type Data so it can be saved to Storage
        guard let photoData = self.image.jpegData(compressionQuality: 0.5)else{
            print("*** ERROR: creating imageData from JPEGRepresentation")
            return completed(false)
        }
        
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/jpeg"
        
        documentUUID = UUID().uuidString // Create a unique doc name
        let storageRef =
            storage.reference().child(spot.documentID).child(self.documentUUID)
        // Save it & check the result
        let uploadTask = storageRef.putData(photoData, metadata: uploadMetadata) { metadata, error in
            guard error == nil else {
                print("😡😡😡 ERROR during .putData storage upload for reference \(storageRef). Error:\(error!.localizedDescription)")
                return
            }
        }
        
        uploadTask.observe(.success) { snapshot in // Report if update is successful
            // Save photo name & other info to "photos" collection for spot.documentID
            let dataToSave = self.dictionary
            let ref = db.collection("spots").document(spot.documentID).collection("photos").document(self.documentUUID)
            ref.setData(dataToSave) { (error) in
                if let error = error {
                    print("*** ERROR: updating document \(self.documentUUID) in spot \(spot.documentID) \(error.localizedDescription)")
                        completed(false)
                } else {
                    print("^^^ Document updated with ref ID \(ref.documentID)")
                    completed(true)
                }
            }
        }
        
        uploadTask.observe(.failure) { (snapshot) in
            if let error = snapshot.error {
                print("*** ERROR: Could not upload image: UUID - \(self.documentUUID), \(error.localizedDescription)")
                    return completed(false)
            }
        }
    }
}
