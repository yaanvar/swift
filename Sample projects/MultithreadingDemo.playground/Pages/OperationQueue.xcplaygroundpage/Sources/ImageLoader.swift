import Foundation
import UIKit

public enum ImageLoadError: Error {
    case error
}

public func syncImageLoad(url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
    if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
        completion(.success(image))
    } else {
        completion(.failure(ImageLoadError.error))
    }
}


