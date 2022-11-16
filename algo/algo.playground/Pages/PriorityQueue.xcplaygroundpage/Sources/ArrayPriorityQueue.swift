import Foundation

public struct PriorityQueueArray<T: Equatable>: Queue {    
    private var elements: [T] = []
    let sort: (Element, Element) -> Bool
    
    public init(sort: @escaping (Element, Element) -> Bool,
                elements: [Element] = []) {
        self.sort = sort
        self.elements = elements
        self.elements.sort(by: sort)
    }
    
    public mutating func enqueue(_ element: T) -> Bool {
        for (index, otherElement) in elements.enumerated() {
            if sort(element, otherElement) {
                elements.insert(element, at: index)
                return true
            }
        }
        elements.append(element)
        return true
    }
    
    mutating public func dequeue() -> T? {
        isEmpty ? nil : elements.removeFirst()
    }
    
    public var isEmpty: Bool {
        elements.isEmpty
    }
    
    public var peek: T? {
        elements.first
    }
    
}
