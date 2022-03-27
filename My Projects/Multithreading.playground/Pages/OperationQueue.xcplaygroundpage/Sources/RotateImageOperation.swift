import UIKit

public class RotateImageOperation: Operation {
    private let inputImage: UIImage?
    public var result: UIImage?
    
    public init(image: UIImage?) {
        inputImage = image
        super.init()
    }
    
    public override func main() {
        if let inputImage = inputImage?.rotate(radians: .pi / 2) {
            result = inputImage
        } else {
            retrievImageResult()
        }
    }
    
    func retrievImageResult() {
        let operation = dependencies
            .filter { $0 is IImageLoadOperation }
            .first as? IImageLoadOperation
        
        guard let result = operation?.result else {
            return
        }
        
        switch result {
        case let .success(image):
            self.result = image.rotate(radians: .pi / 2)
        case let .failure(error):
            print(error)
            // обработка ошибки
        }
    }
}
