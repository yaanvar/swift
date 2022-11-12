import Foundation

let trie = Trie<String>()
trie.insert("car")
trie.insert("card")
trie.insert("care")
trie.insert("cared")
trie.insert("cars")
trie.insert("carbs")
trie.insert("carapace")
trie.insert("cargo")

print("\nCollections starting with \"car\"")
let prefixedWithCar = trie.collections(startingWith: "car")
print(prefixedWithCar)

print("\nCollections starting with \"care\"")
let prefixedWithCare = trie.collections(startingWith: "care")
print(prefixedWithCare)
