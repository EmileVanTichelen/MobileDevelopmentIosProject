//
//  ContentView.swift
//  Quiz
//
//  Created by Emile Van Tichelen on 28/12/2022.
//

import SwiftUI
import Foundation

struct LoadingQuestionsView: View {
    @ObservedObject var api = QuestionApi()
    var category: String
    var amount: Int
    
    var body: some View {
        VStack {
            if api.questions.isEmpty {
                Text("Loading questions...")
            } else {
                QuestionView(viewModel: GameViewModel(questions: api.questions))
            }
        }
        .onAppear {
            self.api.fetchQuestions(category: category, limit: amount) { result in
                switch result {
                case .success(let questions):
                    self.api.questions = questions //warning niet kunnen oplossen
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingQuestionsView(category: "linux", amount: 2)
    }
}
