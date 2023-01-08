//
//  Question.swift
//  Quiz
//
//  Created by Emile Van Tichelen on 30/12/2022.
//

import Foundation

struct Question {
    let id: Int
    let question: String
    let description: String?
    let answers: [String: String?]
    let multipleCorrectAnswers: Bool
    let correctAnswers: [String: Bool]
    let correctAnswer: String?
    let explanation: String?
    let tip: String?
    let category: String
    let difficulty: String
    
    func checkAnswer(selectedAnswers: [String]) -> Bool {
        var wrong = false

        for answerKey in selectedAnswers {// check fout selected
            if let value = correctAnswers[answerKey + "_correct"] {
                if !value {
                    wrong = true
                    break
                }
            }
        }
        let trueAnswers = correctAnswers.filter { $0.value == true }
        trueAnswers.forEach { answer in //check juiste non selected
            let str = String(answer.key.dropLast(8))
            if !selectedAnswers.contains(str) {
                wrong = true
            }
        }
        return !wrong
    }
}
