//
//  Game.swift
//  Quiz
//
//  Created by Emile Van Tichelen on 02/01/2023.
//

import Foundation

struct Game {
    private(set) var questions: [Question]
    private(set) var currentQuestionIndex: Int
    private(set) var score: Int
    private(set) var lastQuestion: Bool = false
    
    init(questions: [Question]) {
        self.questions = questions
        currentQuestionIndex = 0
        score = 0
    }
    
    var currentQuestion: Question {
        questions[currentQuestionIndex]
    }
    
    mutating func nextQuestion() {
        if currentQuestionIndex + 1 < questions.count{
            currentQuestionIndex += 1
        }
        else{
            lastQuestion = true
        }
    }
    
    mutating func updateScore(selectedAnswers: [String]){
        if currentQuestion.checkAnswer(selectedAnswers: selectedAnswers) {
            score += 1
        }
    }
}
