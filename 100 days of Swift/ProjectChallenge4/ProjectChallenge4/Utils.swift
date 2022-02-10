//
//  Utils.swift
//  ProjectChallenge4
//
//  Created by Anvar Rahimov on 10.02.2022.
//

import UIKit

func getDocumenDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}
