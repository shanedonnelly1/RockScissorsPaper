//
//  ContentView.swift
//  RockScissorsPaper
//
//  Created by Shane on 05/08/2020.
//  Copyright © 2020 Shane. All rights reserved.
//

import SwiftUI

enum RockPaperScissors {
    case Rock, Paper, Scissors
}

extension RockPaperScissors: CustomStringConvertible {
    var description: String {
        switch self {
        case .Rock:
            return "Rock"
        case .Paper:
            return "Paper"
        case .Scissors:
            return "Scissors"
        }
    }
}

struct ContentView: View {
    var moves: [RockPaperScissors] = [.Rock, .Paper, .Scissors]
    @State private var currentAppChoice = Int.random(in: 0 ..< 3)
    @State private var playerToWin = Bool.random()
    @State private var score = 0
    @State private var alertTitle = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var roundCount = 0
    
    var body: some View {
        VStack {
            if roundCount == 0 {
                Text("Ready to play?")
                Button(action: {
                    self.startGame()
                }) {
                    Text("Let's play!")
                }
            } else if roundCount <= 10 {
                VStack {
                    Text("Score: \(score)")
                    Text("You must decide how to:")
                    Text(playerToWin == true ? "Win" : "Lose")
                    Text("When app chooses \(moves[currentAppChoice].description)")
                }
                
                ForEach(0 ..< moves.count) { move in
                    Button(action: {
                        self.playerChooses(move)
                    }){
                        Text("\(self.moves[move].description)")
                    }
                }
                Spacer()
            } else {
                Text("Game Over")
                Text("You scored: \(score)")
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Continue")) {
                self.startRound()
            })
        }
    }
    
    func playerChooses(_ move: Int) {
        switch moves[currentAppChoice] {
        case .Rock:
            if playerToWin && moves[move] == .Paper {
                playerWinsRound()
            } else if playerToWin == false && moves[move] == .Scissors {
                playerWinsRound()
            } else {
                playerLosesRound()
            }
        case .Paper:
            if playerToWin && moves[move] == .Scissors {
                playerWinsRound()
            } else if playerToWin == false && moves[move] == .Rock {
                playerWinsRound()
            } else {
                playerLosesRound()
            }
        default:
            // Case Scissors
            if playerToWin && moves[move] == .Rock {
                playerWinsRound()
            } else if playerToWin == false && moves[move] == .Paper {
                playerWinsRound()
            } else {
                playerLosesRound()
            }
        }
        showingAlert = true
    }
    
    func playerWinsRound() {
        alertTitle = "Correct!"
        alertMessage = "You chose the right answer"
        score += 1
    }
    
    func playerLosesRound() {
        alertTitle = "Wrong!"
        alertMessage = "It's a good guess, but it's not quite right. "
        score -= 1
    }
    
    func startGame() {
        currentAppChoice = Int.random(in: 0 ..< moves.count)
        playerToWin = Bool.random()
        roundCount = 1
    }
    
    func startRound() {
        currentAppChoice = Int.random(in: 0 ..< moves.count)
        playerToWin = Bool.random()
        roundCount += 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
