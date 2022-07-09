//
//  ListLayout.swift
//  Moonshot
//
//  Created by Anvar Rahimov on 09.07.2022.
//

import SwiftUI

struct ListLayout: View {
    
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
//    ScrollView {
//        LazyVGrid(columns: columns) {
//            ForEach(missions) { mission in
//                NavigationLink {
//                    MissionView(mission: mission, astronauts: astronauts)
//                } label: {
//                    VStack {
//                        Image(mission.image)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 100, height: 100)
//
//                        VStack {
//                            Text(mission.displayName)
//                                .font(.headline)
//                                .foregroundStyle(.white)
//
//                            Text(mission.formattedLaunchDate)
//                                .font(.caption)
//                                .foregroundColor(.white.opacity(0.5))
//                        }
//                    }
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(.lightBackground)
//                }
//                .clipShape(RoundedRectangle(cornerRadius: 10))
//                .overlay(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(.lightBackground)
//                )
//            }
//        }
//        .padding([.horizontal, .bottom])
//    }
    
    var body: some View {
        List {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)

                        Spacer()
                        
                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundStyle(.white)

                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.5))
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.lightBackground)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.lightBackground)
                )
            }
        }
    }
}

struct ListLayout_Previews: PreviewProvider {
    
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        ListLayout(astronauts: astronauts, missions: missions)
            .preferredColorScheme(.dark)
    }
}
