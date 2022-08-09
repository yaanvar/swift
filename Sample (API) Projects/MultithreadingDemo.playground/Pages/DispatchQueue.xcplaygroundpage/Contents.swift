import Foundation

DispatchQueue.main.async {
    print("1")
      DispatchQueue.main.sync {
        print("2")
      }
      print("3")
}
