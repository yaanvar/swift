import UIKit
import Foundation
import PlaygroundSupport
import CoreGraphics

let viewController = ViewController()

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = viewController

// Создаем очередь
let operationQueue = OperationQueue()

// Настраиваем очередь
operationQueue.maxConcurrentOperationCount = 3
operationQueue.qualityOfService = .utility

// Создаем операции
let loadOperation = ImageLoadOperation(url: .url)
let rotateOperation = RotateImageOperation(image: nil)

// Добавляем операцию, которую вызовем по окончанию работы
let completionOperation = BlockOperation {
    viewController.set(image: rotateOperation.result)
}

// Настраиваем зависимость
completionOperation.addDependency(rotateOperation)
rotateOperation.addDependency(loadOperation)

// Добавляем операции и ждем их выполнения
operationQueue.addOperations(
    [loadOperation, rotateOperation, completionOperation],
    waitUntilFinished: true
)
