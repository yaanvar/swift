//
//  ContentView.swift
//  MultiplicationTablePracticeApp
//
//  Created by Anvar Rahimov on 03.07.2022.
//

import SwiftUI

struct Question {
    var data: String
    var answer: Int
}

struct StepperView: View {
    @State var title: String
    @Binding var selectedOption : Int
    var range: ClosedRange<Int>
    
    var body: some View {
        Stepper(title, value: $selectedOption, in: range)
        Text("\(title): \(selectedOption)")
    }
}

struct ContentView: View {
    
    @State private var isGameActive = false
    @State private var selectedMutiplicationTable : Int = 5
    @State private var numberOfQuestions: Int = 5
    @State private var questions : Array<Question> = []
    @State private var currentQuestionIndex: Int = 1
    @State private var userInputtedAnswer: String = ""
    @State private var userScore = 0
    @State private var isGameComplete = false
    @State private var gameCompleteMessage = ""
    
    var body: some View {
        NavigationView {
            if isGameActive {
                Group {
                    VStack {
                        Text("User Score: \(userScore)")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .padding()
                        Text("\(questions[currentQuestionIndex].data)")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .padding()
                        TextField("Enter your answer", text: $userInputtedAnswer)
                            .padding()
                        Spacer()
                        Button("Enter") {
                            checkAnswer(userAnswer: Int(userInputtedAnswer) ?? 0, answer: questions[currentQuestionIndex].answer)
                        }
                        .foregroundColor(.accentColor)
                        .alert(isPresented: $isGameComplete) {
                            Alert(title: Text(gameCompleteMessage), message: Text("Restart game"), primaryButton: .destructive(Text("Okay")) {
                                isGameActive = false
                                userInputtedAnswer = ""
                                userScore = 0
                                gameCompleteMessage = ""
                                currentQuestionIndex = 1
                            }, secondaryButton: .cancel())
                        }
                    }
                }
                .navigationTitle("Multiplication Table")
            } else {
                Group {
                    VStack {
                        StepperView(title: "Multiplication Table", selectedOption: $selectedMutiplicationTable, range: 1...12)
                            .padding()
                        
                        StepperView(title: "Number of questions", selectedOption: $numberOfQuestions, range: 5...20)
                            .padding()
                        Spacer()
                        Button("Start game") {
                            generateQuestions()
                            isGameActive.toggle()
                        }
                        .foregroundColor(.accentColor)
                    }
                }
                .navigationTitle("Multiplication Table")
            }
        }
    }
    
    func generateQuestions() {
        questions.removeAll()
        for question in 1...numberOfQuestions {
            let question = Question(data: "\(selectedMutiplicationTable) X \(question)", answer: selectedMutiplicationTable * question)
            questions.append(question)
        }
    }
    
    func checkAnswer(userAnswer: Int, answer: Int) {
        if userAnswer == answer {
            userScore += 1
        }
        userInputtedAnswer = ""
        if currentQuestionIndex < numberOfQuestions - 1 {
            currentQuestionIndex += 1
        } else {
            gameCompleteMessage = "Your score is \(userScore)"
            isGameComplete = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
