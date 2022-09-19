//
//  NewsFeedView.swift
//  NewNews(SwiftUI)
//
//  Created by Anvar Rahimov on 14.08.2022.
//

import SwiftUI

struct NewsFeedView: View {
    @StateObject var newsViewModel = NewsViewModel(service: NewsService())
    
    @State private var showSafariView = false
    
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
                                newsViewModel.selectedArticle = article
                                showSafariView = true
                            }
                            .sheet(isPresented: $showSafariView) {
                                if let stringUrl = article.url,
                                   let url = URL(string: stringUrl) {
                                    SafariView(url: url)
                                }
                            }
                            .listRowSeparator(.hidden)
                    }
                    .navigationBarTitle("News")
                    .listStyle(.plain)
                }
            }
        }
        .onAppear {
            self.newsViewModel.getArticles()
            print(newsViewModel.articles.count)
        }
    }
}

struct NewsFeed_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView()
    }
}
