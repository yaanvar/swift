import Foundation
import UIKit

public protocol IImageLoadOperation {
    var result: Result<UIImage, Error>? { get }
}

public class ImageLoadOperation: AsyncOperation, IImageLoadOperation {
    private let url: URL
    public private(set) var result: Result<UIImage, Error>?
    
    public init(url: URL) {
        self.url = url
        super.init()
    }
    
    public override func main() {
        if isCancelled {
            state = .finished
            return
        }
        
        syncImageLoad(url: url) { [weak self] result in
            self?.result = result
            self?.state = .finished
        }
    }
}
