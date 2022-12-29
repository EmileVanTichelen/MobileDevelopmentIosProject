import SwiftUI
import Foundation

class QuizViewModelTest: ObservableObject {
    @Published var questions: [Question] = []
    
    func fetchQuestions(completion: @escaping (Result<[Question], Error>) -> ()) {
        let limit = "5"
        let urlString = "https://quizapi.io/api/v1/questions?apiKey=kBDMEYm0dPlFXz9Wpw4xGtEruKHYEjammCMrse9O&limit="
        
        let url = URL(string: urlString + limit)!
        
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
            // Here, you can parse the data returned from the server and pass the resulting questions to the completion handler
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
//    let tags: [[String: String]]
    let category: String
    let difficulty: String
}

func parseQuestions(data: Data) -> [Question] {
    do {
        // Convert the data to a dictionary
        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]

        var questions: [Question] = []

        for item in json {
            let id = item["id"] as! Int
            let question = item["question"] as! String
            let description = item["description"] as? String
            let correctAnswer = item["correct_answer"] as? String
            let explanation = item["explanation"] as? String
            let tip = item["tip"] as? String
//            let tags = item["tags"] as! [[String: String]]
            let category = item["category"] as! String
            let difficulty = item["difficulty"] as! String
            
            //multipleCorrectAnswers van string naar bool
//            let multipleCorrectAnswersString = item["multiple_correct_answers"] as? String ?? "false"
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
//                tags: tags,
                category: category,
                difficulty: difficulty
            )
            questions.append(questionItem)
        }

        return questions
    } catch {
        // If there is an error parsing the data, return an empty array
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


