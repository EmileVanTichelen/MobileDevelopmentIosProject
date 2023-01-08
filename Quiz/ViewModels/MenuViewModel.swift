//
//  MenuViewModel.swift
//  Quiz
//
//  Created by Emile Van Tichelen on 08/01/2023.
//

import Foundation

class MenuViewModel: ObservableObject {
    
    static let categories = [ //KEY is voor in api, value voor weer te geven
        ("Linux", "Linux"),
        ("Code", "Programming"),
        ("Docker", "Docker"),
        ("CMS", "CMS"),
        ("DevOps", "DevOps"),
        ("SQL", "Database"),
        ("", "Random Quiz")
    ]
    static let amounts = [3, 5, 7, 10]
}
