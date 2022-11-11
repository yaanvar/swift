import Foundation

public class QueueLinkedList<T>: Queue {
    public typealias Element = T
    
    private var list = DoubleLinkedList<T>()
    public init() {}
    
    public func enqueue(_ element: Element) -> Bool {
        list.append(element)
        return true
    }
    public func dequeue() -> Element? {
        guard !list.isEmpty, let element = list.first else {
            return nil
        }

        return list.remove(element)
    }
    
    public var peek: Element? {
        list.first?.value
    }
    
    public var isEmpty: Bool {
        list.isEmpty
    }
}

extension QueueLinkedList: CustomStringConvertible {
    public var description: String {
        String(describing: list)
    }
}
