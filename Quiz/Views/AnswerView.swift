//
//  AnswersView.swift
//  Quiz
//
//  Created by Emile Van Tichelen on 02/01/2023.
//

import SwiftUI

struct AnswerView: View {
    var answerKey : String
    var answer: String
    @Binding var selectedAnswers: [String]
//    @State private var isSelected: Bool = false// is weg omdat het nooit gereset geraakte
    
    var body: some View{
        VStack {
            Text(answer)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(selectedAnswers.contains(answerKey) ? Color.blue : Color.secondary)
        .cornerRadius(8)
        .onTapGesture {
            if !selectedAnswers.contains(answerKey) {
                selectedAnswers.append(answerKey) 
            } else {
                selectedAnswers.removeAll { $0 == answerKey }
            }
        }
    }
}
