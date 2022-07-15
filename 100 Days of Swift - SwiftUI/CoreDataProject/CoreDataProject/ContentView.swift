//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Anvar Rahimov on 15.07.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>
    
    var body: some View {
        VStack {
            List {
                ForEach(countries, id: \.self) { country in
                    Section(country.wrappedFullName) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }

            Button("Add") {
                let candy1 = Candy(context: moc)
                candy1.name = "Mars"
                candy1.country = Country(context: moc)
                candy1.country?.shortName = "UK"
                candy1.country?.fullName = "United Kingdom"

                let candy2 = Candy(context: moc)
                candy2.name = "KitKat"
                candy2.country = Country(context: moc)
                candy2.country?.shortName = "UK"
                candy2.country?.fullName = "United Kingdom"

                let candy3 = Candy(context: moc)
                candy3.name = "Twix"
                candy3.country = Country(context: moc)
                candy3.country?.shortName = "UK"
                candy3.country?.fullName = "United Kingdom"

                let candy4 = Candy(context: moc)
                candy4.name = "Toblerone"
                candy4.country = Country(context: moc)
                candy4.country?.shortName = "CH"
                candy4.country?.fullName = "Switzerland"

                try? moc.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
