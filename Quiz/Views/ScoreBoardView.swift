//
//  ScoreBoardView.swift
//  Quiz
//
//  Created by Emile Van Tichelen on 30/12/2022.
//

import SwiftUI

struct ScoreBoardView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
            VStack {
                Text("Quiz complete!")
                    .font(.title)
                    .padding()
                Text("Your score:")
                    .font(.headline)
                    .padding()
                
                Text("\(viewModel.score)/\(viewModel.amountOfQuestions)")
                    .font(.title)
                Text(viewModel.score * 2 >= viewModel.amountOfQuestions ? "😃" : "😬")
                    .font(.title)
                
                NavigationLink(destination: HomeScreen()) {
                    CardView(content: "Go to start")//die van in questionView
                }
            }
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .navigationBarHidden(true)
    }
}


