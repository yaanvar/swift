//
//  PersonsViewController.swift
//  FRApp
//
//  Created by n.gundorin on 26.03.2022.
//

import UIKit
import CoreData

final class PersonsViewController: UIViewController {

    // MARK: Public properties

    var coreDataStack: CoreDataStackProtocol?
    var demo: DemoFetchedResultsController?

    // MARK: - Private properties

    @IBOutlet weak var tableView: UITableView!

    private let cellIdentifier = "cellIdentifier"

    private lazy var fetchedResultsController: NSFetchedResultsController<Person> = {
        guard let context = coreDataStack?.viewContext else { fatalError() }

        let fetchRequest = Person.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: #keyPath(Person.position), ascending: true),
            NSSortDescriptor(key: #keyPath(Person.salary), ascending: true)
        ]

        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: context,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: nil)
        controller.delegate = self

        do {
            try controller.performFetch()
        } catch {
            print(error.localizedDescription)
        }

        return controller
    }()

    // MARK: Lifecycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // uncomment for FRC demo
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
//            guard let demo = self?.demo else { return }
//
//            demo.demoFetchedResultsController()
//        }
    }

}

// MARK: - UITableViewDataSource

extension PersonsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else {
            fatalError("No sections in fetchedResultsController")
        }

        return sections[section].numberOfObjects
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            else { return UITableViewCell() }

        let person = fetchedResultsController.object(at: indexPath)

        cell.textLabel?.text = person.position
        cell.detailTextLabel?.text = person.salary?.stringValue

        return cell
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension PersonsViewController: NSFetchedResultsControllerDelegate {

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print(#function)
        tableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print(#function)
        tableView.endUpdates()
    }

    func controller(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>,
        didChange anObject: Any,
        at indexPath: IndexPath?,
        for type: NSFetchedResultsChangeType,
        newIndexPath: IndexPath?
    ) {
        print(#function, type.name)

        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }

            tableView.insertRows(at: [newIndexPath], with: .bottom)

        case .delete:
            guard let indexPath = indexPath else { return }

            tableView.deleteRows(at: [indexPath], with: .left)

        case .move:
            guard let indexPath = indexPath,
                    let newIndexPath = newIndexPath else { return }

            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.insertRows(at: [newIndexPath], with: .automatic)

        case .update:
            guard let indexPath = indexPath else { return }

            tableView.reloadRows(at: [indexPath], with: .automatic)

        @unknown default:
            return
        }
    }
}
