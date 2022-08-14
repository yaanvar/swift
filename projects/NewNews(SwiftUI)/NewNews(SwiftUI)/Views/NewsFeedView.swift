//
//  NewsFeedView.swift
//  NewNews(SwiftUI)
//
//  Created by Anvar Rahimov on 14.08.2022.
//

import SwiftUI

struct NewsFeedView: View {
    @Environment(\.openURL) var openURL
    
    @StateObject var newsViewModel = NewsViewModel(service: NewsService())
    
    var body: some View {
        Group {
            switch newsViewModel.state {
            case .failed(let error):
                ErrorView(error: error) {
                    self.newsViewModel.getArticles()
                }
            default:
                NavigationView {
                    List(newsViewModel.isLoading ? Article.example : newsViewModel.articles) { article in
                        ArticleView(isLoading: newsViewModel.isLoading,
                                    article: article)
                            .onTapGesture {
                                load(url: article.url)
                            }
                    }
                    .navigationBarTitle("News")
                }
            }
        }
        .onAppear {
            self.newsViewModel.getArticles()
            print(newsViewModel.articles.count)
        }
    }
    
    func load(url: String?) {
        guard let url = url,
            let linkUrl = URL(string: url) else {
            return
        }
        openURL(linkUrl)
    }
}

struct NewsFeed_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView()
    }
}
