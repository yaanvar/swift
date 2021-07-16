import UIKit

var arrayOfNames = ["Helga", "Bazil", "Alex"]
let nextName = { arrayOfNames.remove(at: 0) }
arrayOfNames.count
nextName()
arrayOfNames.count

//lazy-by-need

let baseCollection = [1, 2, 3, 4, 5]
let lazyBaseCollection = baseCollection.lazy
type(of: lazyBaseCollection)
let collection = lazyBaseCollection.map{ $0 + 1 }
type(of: collection)
print(Array(collection))

let resultCollection = [1, 2, 3, 4, 5].lazy.map{ $0 + 1 }.filter{ $0 % 2 == 0 }
print(Array(resultCollection))
