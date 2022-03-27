import Foundation

func runExample() {
    let userInteractiveQueue = DispatchQueue.global(qos: .userInteractive)
    let userInitiatedQueue = DispatchQueue.global(qos: .userInitiated)
    let utilityQueue = DispatchQueue.global(qos: .utility)
    let backgroundQueue = DispatchQueue.global(qos: .background)
    let unspecifiedQueue = DispatchQueue.global(qos: .unspecified)
    let defaultQueue = DispatchQueue.global()

    func printPriority(symbol: String) {
        for i in 0...10 {
            print("\(symbol), index = \(i), priority = \(qos_class_self())")
        }
    }
    
    func syncPriorityPrint(queue: DispatchQueue) {
        queue.sync {
            printPriority(symbol: "🐺")
        }
        printPriority(symbol: "🌚")
    }
    
    func asyncPriorityPrint(queue: DispatchQueue) {
        queue.async {
            printPriority(symbol: "🐺")
        }
        printPriority(symbol: "🌚")
    }

    asyncPriorityPrint(queue: userInitiatedQueue)

    // asyncPriorityPrint(queue: privateQueueSerial)

    let privateQueueSerial = DispatchQueue(label: "ru.tinkoff.fintech-serial", qos: .userInitiated, attributes: .concurrent)
    let privateQueueConcurrent = DispatchQueue(label: "ru.tinkoff.fintech-concurrent", qos: .userInitiated, attributes: .concurrent)
    let privateQueueConcurrentInactive = DispatchQueue(label: "ru.tinkoff.fintech-concurrent", qos: .userInitiated, attributes: [.concurrent, .initiallyInactive])
    
    func printInactive() {
        print("\(#function) started")
        privateQueueConcurrentInactive.async {
            print("> privateQueueConcurrentInactive task...")
        }
        print("\(#function) will be activate inactive queue")
        privateQueueConcurrentInactive.activate()
        print("\(#function) has been activated inactive queue")
        print("\(#function) finished")
    }

     printInactive()

    func dispatchGroupExample() {
        let group = DispatchGroup()
        var value = ""

        group.enter()
        privateQueueConcurrent.async {
            sleep(1)
            value += "👹"
            group.leave()
        }

        group.enter()
        privateQueueConcurrent.async {
            sleep(2)
            value += "🐺☝🏻"
            group.leave()
        }

        group.notify(queue: privateQueueConcurrent) {
            print(value)
        }
    }

     dispatchGroupExample()

    func barrierExample() {
        privateQueueConcurrent.async {
            printPriority(symbol: "🌚")
        }
        
        // добавить ещё тасок
        
        //
        privateQueueConcurrent.async(flags: .barrier) {
            printPriority(symbol: "👹")
        }
        
        privateQueueConcurrent.async {
            printPriority(symbol: "😎")
        }
    }

    // deadlock

    // (need to change)
    // barrierExample()

    // Создаем объект Thread
    let thread = Thread {
        print("Hello world!")
    }

    // Задаем потоку QOS
    thread.qualityOfService = .userInteractive

    // Стартуем выполнение операций на потоке
    thread.start()

}
