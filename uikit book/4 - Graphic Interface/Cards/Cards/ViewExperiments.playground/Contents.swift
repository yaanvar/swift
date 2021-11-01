//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    
    override func loadView() {
        setupViews()
    }
    
    // настройка представлений сцены
    private func setupViews() {
        self.view = getRootView()
        let redView = getRedView()
        let greenView = getGreenView()
        let whiteView = getWhiteView()
        let pinkView = getPinkView()
        
        set(view: greenView, toCenterOfView: redView)
        whiteView.center = redView.center
        
        self.view.addSubview(redView)
        redView.addSubview(greenView)
        redView.addSubview(whiteView)
        self.view.addSubview(pinkView)
    }
    
    private func set(view moveView: UIView, toCenterOfView baseView: UIView){
        // размеры вложенного представления
        let moveViewWidth = moveView.frame.width
        let moveViewHeight = moveView.frame.height
        // размеры родительского представления
        let baseViewWidth = baseView.frame.width
        let baseViewHeight = baseView.frame.height
        // вычисление и изменение координат
        let newXCoordinate = (baseViewWidth - moveViewWidth) / 2
        let newYCoordinate = (baseViewHeight - moveViewHeight) / 2
        moveView.frame.origin = CGPoint(x: newXCoordinate, y: newYCoordinate)
    }
    
    // создание представления розового цвета
    private func getPinkView() -> UIView {
        let viewFrame = CGRect(x: 50, y: 300, width: 100, height: 100)
        let view = UIView(frame: viewFrame)
        view.backgroundColor = .systemPink
        
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.yellow.cgColor
        view.layer.cornerRadius = 10
        view.layer.shadowOpacity = 0.95
        view.layer.shadowRadius = 20
        view.layer.shadowOffset = CGSize(width: 10, height: 20)
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.opacity = 0.7
        
        return view
    }

    // создание белого представления
    private func getWhiteView() -> UIView {
        let viewFrame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let view = UIView(frame: viewFrame)
        view.backgroundColor = .white
        return view
    }
    
    // создание красного представления
    private func getRedView() -> UIView {
        let viewFrame = CGRect(x: 50, y: 50, width: 200, height: 200)
        let view = UIView(frame: viewFrame)
        view.backgroundColor = .red
        view.clipsToBounds = true
        return view
    }
    
    // создание зеленого представления
    private func getGreenView() -> UIView {
        let viewFrame = CGRect(x: 100, y: 100, width: 180, height: 180)
        let view = UIView(frame: viewFrame)
        view.backgroundColor = .green
        //view.clipsToBounds = true
        return view
    }
    
    // создание корневого представления
    private func getRootView() -> UIView {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }
    
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
