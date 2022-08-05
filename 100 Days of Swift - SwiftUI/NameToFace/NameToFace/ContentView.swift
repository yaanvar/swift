//
//  ContentView.swift
//  NameToFace
//
//  Created by Anvar Rahimov on 05.08.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputImage: UIImage?
    @State private var showingNewFaceView = false
    @StateObject private var people = People()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(people.shared, id: \.id) { person in
                    NavigationLink(destination: FaceDetailView(person: person)) {
                        FaceRow(image: person.image, name: person.name)
                    }
                }
            }
            .navigationTitle("Name To Face")
            .sheet(isPresented: $showingNewFaceView) {
                NewFaceView(people: people)
            }
            .toolbar {
                Button {
                    showingNewFaceView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    func loadImage() {
        
        
    }
}

struct FaceDetailView: View {
    var person: Person
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                person.image
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                
                Text(person.name)
                    .padding()
                
                Spacer()
            }
        }
    }
}

struct NewFaceView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @StateObject var people: People
    
    @State var image: Image?
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    ZStack {
                        Circle()
                            .fill(.secondary)

                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)

                        image?
                            .resizable()
                            .scaledToFill()
                    }
                    .clipShape(Circle())
                    .frame(width: geometry.size.width / 1.25, height: geometry.size.width / 1.25)
                    .onTapGesture {
                        showingImagePicker = true
                    }
                    
                    TextField("Name", text: $name)
                        .padding()
                    
                    Spacer()
                }
                .navigationTitle("New Person")
                .onChange(of: inputImage) { _ in
                    loadImage()
                }
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(image: $inputImage)
                }
                .toolbar {
                    Button("Save") {
                        saveNewPerson()
                    }
                }
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }

        image = Image(uiImage: inputImage)
    }
    
    func saveNewPerson() {
        guard let image = image else { return }
        
        people.shared.append(Person(image: image, name: name))
        people.shared = people.shared.sorted {
            $0.name < $1.name
        }
        print(people.shared)
        
        dismiss()
    }
}

struct Person: Equatable {
    let id = UUID()
    var image: Image
    var name: String
}

class People: ObservableObject {
    @Published var shared = [Person]()
}

struct FaceRow: View {
    var image: Image
    var name: String
    
    var body: some View {
        HStack {
            image
                .resizable()
                .scaledToFill()
                .frame(width: 90, height: 90)
                .clipShape(Circle())
            
            Text(name)
                .font(.headline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
