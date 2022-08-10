//
//  AvatarView.swift
//  DubDubGrub
//
//  Created by Anvar Rahimov on 10.08.2022.
//

import SwiftUI

struct AvatarView: View {
    
    var size: CGFloat
    var name: String?
    
    var body: some View {
        VStack {
            Image("default-avatar")
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .clipShape(Circle())
            
            if let name = name {
                Text(name)
                    .bold()
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
            }
        }
    }
}


struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(size: 35)
    }
}
