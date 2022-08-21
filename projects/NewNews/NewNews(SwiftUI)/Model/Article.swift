//
//  Article.swift
//  NewNews(SwiftUI)
//
//  Created by Anvar Rahimov on 13.08.2022.
//

import Foundation

struct Article: Codable, Identifiable, Equatable {
    let id = UUID()
    
    let source: Source?
    let author: String?
    let title: String?
    let articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

extension Article {
    static var example: [Article] {
        [
            .init(source: Source(id: "the-wall-street-journal", name: "The Wall Street Journal"),
                  author: "Ginger Adams Otis",
                  title: "Accused Salman Rushdie Attacker Charged With Attempted Murder, Assault - The Wall Street Journal",
                  articleDescription: "Hadi Matar pleaded not guilty to the charges and was being held without bail in southwestern New York. Mr. Rushdie was on Saturday taken off a ventilator and able to speak, the novelist’s agent confirmed.",
                  url: "https://www.wsj.com/articles/accused-salman-rushdie-attacker-charged-with-attempted-murder-assault-11660411604",
                  urlToImage: "https://images.wsj.net/im-603776/social",
                  publishedAt: Date.now,
                  content: nil),
            .init(source: Source(id: "the-wall-street-journal", name: "The Wall Street Journal"),
                  author: "Ginger Adams Otis",
                  title: "Accused Salman Rushdie Attacker Charged With Attempted Murder, Assault - The Wall Street Journal",
                  articleDescription: "Hadi Matar pleaded not guilty to the charges and was being held without bail in southwestern New York. Mr. Rushdie was on Saturday taken off a ventilator and able to speak, the novelist’s agent confirmed.",
                  url: "https://www.wsj.com/articles/accused-salman-rushdie-attacker-charged-with-attempted-murder-assault-11660411604",
                  urlToImage: "https://images.wsj.net/im-603776/social",
                  publishedAt: Date.now,
                  content: nil),
            .init(source: Source(id: "the-wall-street-journal", name: "The Wall Street Journal"),
                  author: "Ginger Adams Otis",
                  title: "Accused Salman Rushdie Attacker Charged With Attempted Murder, Assault - The Wall Street Journal",
                  articleDescription: "Hadi Matar pleaded not guilty to the charges and was being held without bail in southwestern New York. Mr. Rushdie was on Saturday taken off a ventilator and able to speak, the novelist’s agent confirmed.",
                  url: "https://www.wsj.com/articles/accused-salman-rushdie-attacker-charged-with-attempted-murder-assault-11660411604",
                  urlToImage: "https://images.wsj.net/im-603776/social",
                  publishedAt: Date.now,
                  content: nil),
            .init(source: Source(id: "the-wall-street-journal", name: "The Wall Street Journal"),
                  author: "Ginger Adams Otis",
                  title: "Accused Salman Rushdie Attacker Charged With Attempted Murder, Assault - The Wall Street Journal",
                  articleDescription: "Hadi Matar pleaded not guilty to the charges and was being held without bail in southwestern New York. Mr. Rushdie was on Saturday taken off a ventilator and able to speak, the novelist’s agent confirmed.",
                  url: "https://www.wsj.com/articles/accused-salman-rushdie-attacker-charged-with-attempted-murder-assault-11660411604",
                  urlToImage: "https://images.wsj.net/im-603776/social",
                  publishedAt: Date.now,
                  content: nil),
            .init(source: Source(id: "the-wall-street-journal", name: "The Wall Street Journal"),
                  author: "Ginger Adams Otis",
                  title: "Accused Salman Rushdie Attacker Charged With Attempted Murder, Assault - The Wall Street Journal",
                  articleDescription: "Hadi Matar pleaded not guilty to the charges and was being held without bail in southwestern New York. Mr. Rushdie was on Saturday taken off a ventilator and able to speak, the novelist’s agent confirmed.",
                  url: "https://www.wsj.com/articles/accused-salman-rushdie-attacker-charged-with-attempted-murder-assault-11660411604",
                  urlToImage: "https://images.wsj.net/im-603776/social",
                  publishedAt: Date.now,
                  content: nil),
            .init(source: Source(id: "the-wall-street-journal", name: "The Wall Street Journal"),
                  author: "Ginger Adams Otis",
                  title: "Accused Salman Rushdie Attacker Charged With Attempted Murder, Assault - The Wall Street Journal",
                  articleDescription: "Hadi Matar pleaded not guilty to the charges and was being held without bail in southwestern New York. Mr. Rushdie was on Saturday taken off a ventilator and able to speak, the novelist’s agent confirmed.",
                  url: "https://www.wsj.com/articles/accused-salman-rushdie-attacker-charged-with-attempted-murder-assault-11660411604",
                  urlToImage: "https://images.wsj.net/im-603776/social",
                  publishedAt: Date.now,
                  content: nil),
            .init(source: Source(id: "the-wall-street-journal", name: "The Wall Street Journal"),
                  author: "Ginger Adams Otis",
                  title: "Accused Salman Rushdie Attacker Charged With Attempted Murder, Assault - The Wall Street Journal",
                  articleDescription: "Hadi Matar pleaded not guilty to the charges and was being held without bail in southwestern New York. Mr. Rushdie was on Saturday taken off a ventilator and able to speak, the novelist’s agent confirmed.",
                  url: "https://www.wsj.com/articles/accused-salman-rushdie-attacker-charged-with-attempted-murder-assault-11660411604",
                  urlToImage: "https://images.wsj.net/im-603776/social",
                  publishedAt: Date.now,
                  content: nil)
        ]
    }
}
