import Foundation

public class AsyncOperation: Operation {
    public enum State: String {
        case ready, executing, finished, cancelled
        
        fileprivate var keyPath: String {
            return "is" + rawValue.capitalized
        }
    }
    
    public var state: State = .ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
}

public extension AsyncOperation {
    override var isReady: Bool {
        super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
        state == .executing
    }
    
    override var isFinished: Bool {
        state == .finished
    }
    
    override var isCancelled: Bool {
        state == .cancelled
    }
    
    override var isAsynchronous: Bool {
        true
    }
    
    override func start() {
        if isCancelled {
            state = .finished
            return
        }
        
        main()
        state = .executing
    }
    
    override func cancel() {
        state = .cancelled
    }
}
