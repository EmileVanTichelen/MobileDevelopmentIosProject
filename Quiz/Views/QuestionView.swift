import SwiftUI

struct QuestionView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var shouldNavigateScore: Bool = false
    @State private var shouldNavigate: Bool = false

    @State private var selectedAnswers: [String] = []
    
    var body: some View {
        print(viewModel.currentQuestion.correctAnswers)
        return ScrollView(.vertical) {
            VStack(alignment: .leading) {
                if viewModel.isLast {
                    NavigationLink(destination: ScoreBoardView(viewModel: viewModel), isActive: $shouldNavigateScore){
                        EmptyView()
                    }
//                    ScoreBoardView(viewModel: viewModel)
                }
                //begin vraagding
                Text("Question: \(viewModel.currentQuestionDisplayIndex)/\(viewModel.amountOfQuestions)")
                    .font(.footnote)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .padding(.vertical, 0)
                Text("Score: \(viewModel.score)")
                    .font(.footnote)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .padding(.vertical, 0)
                Text(viewModel.currentQuestion.question)
                    .font(.title)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                Text("Select all possible answers.")
                    .font(.footnote)
                    .padding()
                //einde vraagding
                
                ForEach(viewModel.currentQuestion.answers.sorted { $0.key < $1.key }.map { (key: $0.key, value: $0.value) }, id: \.0) { answer in
                    if let value = answer.value, let key = answer.key {
                        AnswerView(answerKey: key, answer: value, selectedAnswers: $selectedAnswers)
                    }
                }
                
                if(selectedAnswers.count > 0){
                    NavigationLink(destination: QuestionView(viewModel: self.viewModel)) {
                        Button(action: {
                            viewModel.updateScore(selectedAnswers: selectedAnswers)//kan evt samen met nextQuestion
                            viewModel.nextQuestion()
                            selectedAnswers.removeAll()
                            shouldNavigate = true
                        }) {
                            CardView(content: "Submit")
                        }
                    }
                }
                
            }
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .onAppear {
                shouldNavigateScore = true
            }
        }
    }
}

struct CardView: View {
    var content: String

    var body: some View {
        VStack {
            Text(content)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.blue)
        .cornerRadius(8)
        .padding()
    }
}
