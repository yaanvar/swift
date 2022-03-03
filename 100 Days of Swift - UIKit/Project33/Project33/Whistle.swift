//
//  Whistle.swift
//  Project33
//
//  Created by Anvar Rahimov on 04.03.2022.
//

import UIKit
import CloudKit

class Whistle: NSObject {
    var recordID: CKRecord.ID!
    var genre: String!
    var comments: String!
    var audio: URL!
}
