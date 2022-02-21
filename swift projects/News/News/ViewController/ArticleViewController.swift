//
//  ArticleViewController.swift
//  News
//
//  Created by Anvar Rahimov on 06.02.2022.
//

import UIKit

class ArticleViewController: UIViewController {
    var articleItem: Article?
    var articleTitle: UILabel!
    var articleDescription: UILabel!
    var articleSource: UILabel!
    var articleImage: UIImageView!
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBackground
        
        guard let articleItem = articleItem else { return }
        
        articleTitle = UILabel()
        articleTitle.text = articleItem.title
        articleTitle.font = UIFont.systemFont(ofSize: 28)
        articleTitle.numberOfLines = 0
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(articleTitle)
        
        
        articleDescription = UILabel()
        articleDescription.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        articleDescription.font = .systemFont(ofSize: 20)
        articleDescription.text = articleItem.description
        articleDescription.numberOfLines = 0
        articleDescription.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(articleDescription)
        

        articleImage = UIImageView()
        articleImage.contentMode = .scaleAspectFit
        articleImage.loadImage(urlString: articleItem.urlToImage)
        articleImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(articleImage)
        
        NSLayoutConstraint.activate([
            articleTitle.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            articleTitle.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            articleTitle.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            
            articleImage.topAnchor.constraint(equalTo: articleTitle.bottomAnchor),
            articleImage.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            articleImage.heightAnchor.constraint(equalTo: articleImage.widthAnchor, multiplier: 0.7),
            articleImage.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            
            articleDescription.topAnchor.constraint(equalTo: articleImage.bottomAnchor),
            articleDescription.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            articleDescription.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        ])
        
        //articleTitle.backgroundColor = .purple
        //articleDescription.backgroundColor = .red
        //articleImage.backgroundColor = .green
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
}
