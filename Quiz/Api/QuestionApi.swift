import SwiftUI
import Foundation
import Combine


class QuestionApi: ObservableObject {
    @Published var questions: [Question] = []

    func updateQuestions(questions: [Question]) {
            let mainQueue = DispatchQueue.main
            let questionsPublisher = Just(questions)
                .receive(on: mainQueue)
                .assign(to: \.questions, on: self)
    }
    
    
    //api deel, check: https://www.youtube.com/watch?v=sqo844saoC4&t=516s
    func fetchQuestions(category: String, limit: Int ,completion: @escaping (Result<[Question], Error>) -> ()) {
        let urlString = "https://quizapi.io/api/v1/questions?apiKey=kBDMEYm0dPlFXz9Wpw4xGtEruKHYEjammCMrse9O"
        print(category)
        print(limit)
        let url = URL(string: urlString + "&limit=\(limit)" + "&category=\(category)")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(APIError.invalidResponse))
                    return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            let questions = parseQuestions(data: data)
            completion(.success(questions))
        }
        
        task.resume()
    }
}

enum APIError: Error {
    case invalidResponse
    case noData
}


func parseQuestions(data: Data) -> [Question] {
    do {
        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]

        var questions: [Question] = []

        for item in json {
            let id = item["id"] as! Int
            let question = item["question"] as! String
            let description = item["description"] as? String
            let correctAnswer = item["correct_answer"] as? String
            let explanation = item["explanation"] as? String
            let tip = item["tip"] as? String
            let category = item["category"] as! String
            let difficulty = item["difficulty"] as! String
            
            //multipleCorrectAnswers van string naar bool
            let multipleCorrectAnswers = stringToBool(val: item["multiple_correct_answers"] as! String)
            
            //answers fixen
            let answersObject = item["answers"] as? [String: Any] ?? [:]
            var answers: [String: String?] = [:]
            for (key, value) in answersObject {
                answers[key] = value as? String
            }
            
            //correct answers fixen
            let correctAnswersObject = item["correct_answers"] as? [String: Any] ?? [:]
            var correctAnswers: [String: Bool] = [:]
            for (key, value) in correctAnswersObject {
                correctAnswers[key] = stringToBool(val: value as! String)
            }
            
            let questionItem = Question(
                id: id,
                question: question,
                description: description,
                answers: answers,
                multipleCorrectAnswers: multipleCorrectAnswers,
                correctAnswers: correctAnswers,
                correctAnswer: correctAnswer,
                explanation: explanation,
                tip: tip,
                category: category,
                difficulty: difficulty
            )
            questions.append(questionItem)
        }

        return questions
    } catch {
        return []
    }
}


func stringToBool(val: String) -> Bool {
    switch val {
    case "true":
        return true
    case "false":
        return false
    default:
        return false
    }
}


