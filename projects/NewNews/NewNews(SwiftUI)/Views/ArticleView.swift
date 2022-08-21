//
//  ArticleView.swift
//  NewNews(SwiftUI)
//
//  Created by Anvar Rahimov on 13.08.2022.
//

import SwiftUI
import URLImage

struct ArticleView: View {
    
    @State var isLoading: Bool
    
    let article: Article
    
    var body: some View {
        HStack {
            if let image = article.urlToImage,
               let url = URL(string: image) {
                URLImage(url,
                         failure: { error, retry in
                            PlaceholderImageView()
                        },
                        content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        })
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                        .padding(.vertical, 5)
                        .environment(\.urlImageOptions,
                                      URLImageOptions(
                                        fetchPolicy: .returnStoreElseLoad(downloadDelay: 0.25)
                                        )
                                    )
            } else {
                    PlaceholderImageView()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(article.title ?? "")
                    .foregroundColor(Color(.label))
                    .font(.system(size: 18, weight: .semibold))
                    .lineLimit(3)
                    .minimumScaleFactor(0.75)
                Text(article.source?.name ?? "")
                    .foregroundColor(Color(.secondaryLabel))
                    .font(.system(size: 12, weight: .regular))
                if let date = article.publishedAt {
                    Text(date, style: .time)
                        .foregroundColor(Color(.secondaryLabel))
                        .font(.system(size: 12, weight: .regular))
                    +
                    Text(" ")
                    +
                    Text(date, style: .date)
                        .foregroundColor(Color(.secondaryLabel))
                        .font(.system(size: 12, weight: .regular))
                }
            }
        }
        .redacted(reason: isLoading ? .placeholder : [])
        .allowsHitTesting(!isLoading)
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
