//
//  TableViewController.swift
//  News
//
//  Created by Anvar Rahimov on 05.02.2022.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    // MARK: UserDefaults
    
    let defaults = UserDefaults.standard
    
    var news: [Article] {
        get {
            if let data = defaults.value(forKey: "news") as? Data {
                return try! PropertyListDecoder().decode([Article].self ,from: data)
            } else {
                return [Article]()
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: "news")
            } else {
                defaults.removeObject(forKey: "news")
            }
        }
    }
    
    var newsOnPage: [Article] {
        get {
            if let data = defaults.value(forKey: "newsOnPage") as? Data {
                return try! PropertyListDecoder().decode([Article].self ,from: data)
            } else {
                return [Article]()
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: "newsOnPage")
            } else {
                defaults.removeObject(forKey: "newsOnPage")
            }
        }
    }
    
    var viewCounters: [Int] {
        get {
            if let data = defaults.value(forKey: "viewCounters") as? Data {
                return try! PropertyListDecoder().decode([Int].self ,from: data)
            } else {
                return [Int]()
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: "viewCounters")
            } else {
                defaults.removeObject(forKey: "viewCounters")
            }
        }
    }
    
    // MARK: - api url
    
    // Если возникнут проблемы, то поменяйте мой ключ (меня забанили на время за большое количество запросов 0-0)
    let urlString = "https://newsapi.org/v2/top-headlines?" + "pageSize=100&" + "country=ru&" + "apiKey=b956f94fd1c545f8b1e1a43e522db33d"
    

    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - navigationView
        
        title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let goBack = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(previousPage))
        let goForward = UIBarButtonItem(image: UIImage(systemName: "arrow.forward"), style: .plain, target: self, action: #selector(nextPage))
        toolbarItems = [goBack, spacer, goForward]
        navigationController?.isToolbarHidden = false
        
        // MARK: - refreshControl
        
        tableView.refreshControl = {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
            return refreshControl
        }()
        
        // MARK: - url

        //print(String(newsOnPage.count) + "NewsOnPageBeforeURLRequest")
        //print(String(news.count) + "NewsBeforeURLRequest")
        //print(String(viewCounters.count) + "ViewCountersBeforeURLRequest")
        
        if news.count < 20 {
            newsOnPage = Array(news[0..<news.count])
        } else {
            newsOnPage = Array(news[0..<20])
        }
        
        loadDataFromUrl(urlString: urlString)
        
    }
    
    // MARK: - showError
    
    func showError() {
        let ac = UIAlertController(title: "No internet connection", message: "Check your internet connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Try again.", style: .default) { _ in
            self.loadDataFromUrl(urlString: self.urlString)
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    // MARK: - nextPage and previousPage
    
    var currentPage = 1
    
    @objc func nextPage() {
        if currentPage * 20 >= news.count {
            return
        }
        
        currentPage += 1
        
        var firstPoint: Int
        var lastPoint: Int
        
        if currentPage * 20 > news.count {
            firstPoint = (currentPage-1) * 20
            newsOnPage = Array(news[firstPoint...])
        } else {
            firstPoint = (currentPage-1) * 20
            lastPoint = currentPage * 20
            newsOnPage = Array(news[firstPoint..<lastPoint])
        }
        
        tableView.reloadData()
    }
    
    @objc func previousPage() {
        if currentPage == 1 {
            return
        }
        
        currentPage -= 1
            
        var firstPoint: Int
        var lastPoint: Int
        
        if currentPage * 20 > news.count {
            firstPoint = (currentPage-1) * 20
            newsOnPage = Array(news[firstPoint...])
        } else {
            firstPoint = (currentPage-1) * 20
            lastPoint = currentPage * 20
            newsOnPage = Array(news[firstPoint..<lastPoint])
        }
        
        tableView.reloadData()
    }
    
    // MARK: - refresh
    
    @objc func refresh(sender: UIRefreshControl) {
        loadDataFromUrl(urlString: urlString)
        sender.endRefreshing()
    }
    
    // MARK: - load data from url
    
    func loadDataFromUrl(urlString: String) {
        DispatchQueue.global().async { [weak self] in
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    self?.parse(json: data)
                    return
                } else {
                    DispatchQueue.main.async {
                        self?.showError()
                    }
                }
            }
        }
    }
    
    // MARK: - parsing JSON
    
    func parse(json: Data) {
        DispatchQueue.global().async { [weak self] in
            let decoder = JSONDecoder()
            
            if let jsonNews = try? decoder.decode(News.self, from: json) {
                self?.news = jsonNews.articles
                if jsonNews.articles.count < 20 {
                    self?.newsOnPage = Array(jsonNews.articles[0..<jsonNews.articles.count])
                } else {
                    self?.newsOnPage = Array(jsonNews.articles[0..<20])
                }
                
                //print(String(jsonNews.articles.count) + "parse")
                
                DispatchQueue.main.async {
                    self?.currentPage = 1
                    self?.tableView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    self?.showError()
                }
            }
        }
    }
    
    
    // MARK: - tableView

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsOnPage.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Article", for: indexPath)
        let article = newsOnPage[indexPath.row]
        cell.textLabel?.text = article.title
        if viewCounters.isEmpty {
            viewCounters = [Int].init(repeating: 0, count: news.count)
        }
        cell.detailTextLabel?.text = "Views: " + String(viewCounters[indexPath.row + (currentPage-1) * 20])
            
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ArticleViewController()
        vc.articleItem = newsOnPage[indexPath.row]
        viewCounters[indexPath.row + (currentPage-1) * 20] += 1
        tableView.reloadData()
        navigationController?.pushViewController(vc, animated: true)
    }

}

