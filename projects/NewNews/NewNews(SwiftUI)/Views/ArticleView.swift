//
//  ArticleView.swift
//  NewNews(SwiftUI)
//
//  Created by Anvar Rahimov on 13.08.2022.
//

import SwiftUI
//import URLImage

struct ArticleView: View {
    
    @State var isLoading: Bool
    
    let article: Article
    
    var body: some View {
        articleImage
            .overlay(
                ZStack {
                    LinearGradient(colors: [.black.opacity(0.8), .clear],
                                   startPoint: .bottom,
                                   endPoint: .top)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        if let date = article.publishedAt {
                            Text(date.formatted(.dateTime.month().year().day().hour().minute()))
                                .foregroundColor(Color(.secondaryLabel))
                                .font(.system(size: 12, weight: .regular))
                        }
                        
                        Text(article.title ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .semibold))
                            .lineLimit(3)
                            .minimumScaleFactor(0.75)
                            .frame(maxHeight: .infinity, alignment: .bottomLeading)
                            .padding(.top)
                        
                        plaque
                            .offset(y: 40)
                    }
                    
            
                           
                }
            )
            .padding(.horizontal)
            .padding(.vertical, 10)
            .redacted(reason: isLoading ? .placeholder : [])
            .allowsHitTesting(!isLoading)
    }
    
    var articleImage: some View {
        HStack {
            if let image = article.urlToImage,
               let url = URL(string: image) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    PlaceholderImageView()
                }
            } else {
                PlaceholderImageView()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .cornerRadius(20)
    }
    
    var plaque: some View {
        Text("plaque")
    }
}

struct PlaceholderImageView: View {
    var body: some View {
        Image(systemName: "photo.fill")
            .foregroundColor(.white)
            .background(Color.gray)
            .frame(width: 100, height: 100)
            .cornerRadius(10)
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(isLoading: false,
                    article: .example[0])
    }
}
