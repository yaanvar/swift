import UIKit

var list = LinkedList<Int>()

list.append(3)
list.append(3)
list.append(3)
list.append(2)
list.append(3)
list.append(1)
list.append(3)

print(list)

func removeOccurences(_ value: Int, list: LinkedList<Int>) -> LinkedList<Int> {
    while var head = list.head, head.value == value {
        head = head.next!
    }
    
    return list
}

print(removeOccurences(3, list: list))
