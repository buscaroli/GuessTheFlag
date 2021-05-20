//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Matteo on 20/05/2021.
//

import SwiftUI

    
struct ContentView: View {
    @State private var countries: [String] = ["Italy", "France", "Germany", "Spain", "UK", "Estonia"].shuffled()
    @State private var correct = Int.random(in: 0 ... 2)
    @State private var score: Int = 0
    @State private var questionsRemaining: Int = 6
    @State private var gameOver: Bool = false


    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(edges: .all)
            VStack(spacing: 30) {
                Text("Pick the flag of:")
                    .foregroundColor(.primary)
                    .font(.title)
                Text(countries[correct])
                    .foregroundColor(.primary)
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
                VStack {
                    ForEach(0 ..< 3) { flag in
                        Button(action: {
                            checkAnswer(flag)
                            randomizeFlag()
                        }) {
                            Image(countries[flag])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .padding()
                                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        }
                        .alert(isPresented: $gameOver) {
                            Alert(title: Text("GAME OVER"),
                                  message: Text("You Scored \(score)"),
                                  dismissButton: Alert.Button.default(
                                    Text("Start a New Game"),
                                    action: { self.resetGame() }
                                  )
                            )
                        }
                    }
                }
                Spacer()
                
                Text("Score: \(score) point")
                    .font(.largeTitle)
                    .foregroundColor(.yellow)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Spacer()
            }
        }
        
    }
    
    func checkAnswer(_ flag: Int) {
        if flag == correct {
            score += 1
        } else {
            if (score > 0) {
                score -= 1
            }
        }
        countries.shuffle()
        questionsRemaining -= 1
        if (questionsRemaining <= 0) {
            gameOver = true
        }
    }
    
    func randomizeFlag() {
        correct = Int.random(in: 0 ... 2)
    }
    
    func resetGame() {
        countries.shuffle()
        score = 0
        questionsRemaining = 6
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
