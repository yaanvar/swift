//
//  Country.swift
//  TFS UITableView & Navigation
//
//  Created by Sergey Shalnov on 28.02.2022.
//

import Foundation

struct Country {
    let name: String
    let cities: [String]
    
    // MARK: - Mock
    
    static let mock = [
        Country(
            name: "Грузия",
            cities: [
                "Тбилиси",
                "Абаша",
                "Амбролаури",
                "Ахалкалаки",
                "Ахалцихе",
                "Ахмета",
                "Багдати",
                "Батуми"
            ]
        ),
        Country(
            name: "Турция",
            cities: [
                "Стамбул",
                "Анкара",
                "Измир",
                "Бурса",
                "Адана",
                "Газиантеп",
                "Конья",
                "Анталья"
            ]
        ),
        Country(
            name: "Великобритания",
            cities: [
                "Лондон",
                "Бирмингем",
                "Лидс",
                "Глазго",
                "Шеффилд",
                "Манчестер",
                "Эдинбург",
                "Ливерпуль"
            ]
        )
    ]
}
