import UIKit

public final class ViewController: UIViewController {
    private var imageView = UIImageView()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
    }
    
    public func set(image: UIImage?) {
        DispatchQueue.main.async { [weak self] in
            self?.imageView.image = image
            self?.imageView.sizeToFit()
        }
    }
}

