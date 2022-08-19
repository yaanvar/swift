//
//  MatchedView.swift
//  DesignCode
//
//  Created by Anvar Rahimov on 19.08.2022.
//

import SwiftUI

struct MatchedView: View {
    @Namespace var namespace
    @State var show = false
    
    var body: some View {
        ZStack {
            if !show {
                CourseItem(namespace: namespace, show: $show)
            } else {
                CourseView(namespace: namespace, show: $show)
            }
        }
    }
}

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        MatchedView()
    }
}
