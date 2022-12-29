//
//  ContentView.swift
//  Quiz
//
//  Created by Emile Van Tichelen on 28/12/2022.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @ObservedObject var viewModel = QuizViewModelTest()
    
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                self.viewModel.fetchQuestions { result in
                    switch result {
                    case .success(let questions):
                        // Here, you can use the questions returned from the API in your view
                        print(questions)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
