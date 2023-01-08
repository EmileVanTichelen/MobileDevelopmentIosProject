//
//  QuestionViewmodel.swift
//  Quiz
//
//  Created by Emile Van Tichelen on 30/12/2022.
//

import SwiftUI

class GameViewModel: ObservableObject {
    
    @Published private var model: Game

    init(questions: [Question]) {
        model = Game(questions: questions)
    }
    
    func nextQuestion() {
        model.nextQuestion()
    }
    
    func updateScore(selectedAnswers: [String]) {
        model.updateScore(selectedAnswers: selectedAnswers)
    }

    var amountOfQuestions: Int {
        model.questions.count
    }
    var currentQuestionDisplayIndex: Int {
        model.currentQuestionIndex + 1
    }
    
    var isLast: Bool {
        model.lastQuestion
    }
    
    var currentQuestion: Question {
        model.currentQuestion
    }
    var score: Int {
        return model.score
    }
}
