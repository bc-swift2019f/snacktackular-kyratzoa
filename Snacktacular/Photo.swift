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
}
