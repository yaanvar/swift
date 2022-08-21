//
//  Task.swift
//  ToDoApp
//
//  Created by Anvar Rahimov on 21.08.2022.
//

import Foundation
import RealmSwift

class Task: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title = ""
    @Persisted var completed = false
}

