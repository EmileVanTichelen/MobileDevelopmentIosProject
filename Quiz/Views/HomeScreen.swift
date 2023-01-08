//
//  HomeScreen.swift
//  Quiz
//
//  Created by Emile Van Tichelen on 29/12/2022.
//

import SwiftUI

struct HomeScreenNav: View {
    var body: some View {
        NavigationView{
            HomeScreen()
        }
        .navigationViewStyle(StackNavigationViewStyle()) //voor ipad

    }
}
struct HomeScreen: View {
    @State var showingDetail = false
    private let categories = MenuViewModel.categories
    @State private var selectedCategory: String?

    var body: some View {
        ScrollView(.vertical){
            VStack(alignment: .leading) {
                Text("Welcome to the game!")
                    .font(.largeTitle)
                    .padding()
                Text("Choose a category.")
                    .font(.footnote)
                    .padding()
                ForEach(categories, id: \.0) { category in
                    NavigationLink(destination: AmountView(category: category)){
                        FormCard(content: category.1)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}
struct AmountView: View {
    private let amounts = MenuViewModel.amounts
    let category : (String, String)
    var body: some View {
        ScrollView(.vertical){
            VStack(alignment: .leading) {
                Text("Category: \(category.1)")
                    .font(.largeTitle)
                    .padding()
                Text("How many questions?")
                    .font(.largeTitle)
                    .padding()
                ForEach(amounts, id: \.self) { amount in
                    NavigationLink(destination: LoadingQuestionsView(category: category.0, amount: amount)) {
                        FormCard(content: String(amount))
                    }
                }
            }
        }
    }
}

struct FormCard: View {
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
        .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

