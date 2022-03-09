//
//  InterfaceController.swift
//  Project37 WatchKit Extension
//
//  Created by Anvar Rahimov on 07.03.2022.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        WKInterfaceDevice().play(.click)
    }
    
    @IBOutlet var welcomeText: WKInterfaceLabel!
    
    @IBAction func hideWelcomeText() {
        welcomeText.setHidden(true)
    }

    override func awake(withContext context: Any?) {
        // Configure interface objects here.
    }
    
    override func willActivate() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

}
