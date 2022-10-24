//
//  EntryViewModel.swift
//  DesenhoSemFio
//
//  Created by Marcelo Diefenbach on 23/10/22.
//

import Foundation
import FirebaseFirestore

class EntryViewModel: ObservableObject {
    
    let firestore = Firestore.firestore()
    
    func createRoom() {
        firestore.collection("room").document("ANFJ").setData(
            [
                "roomCode": "ANFJ"
            ]
            , merge: true
        ) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with")
            }
        }
    }
    
}
