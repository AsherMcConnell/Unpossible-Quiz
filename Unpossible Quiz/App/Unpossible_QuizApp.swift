//
//  Unpossible_QuizApp.swift
//  Unpossible Quiz
//
//  Created by Asher McConnell on 6/20/23.
//

import SwiftUI
import NavigationRouter

@main
struct Unpossible_QuizApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationRouter {
                HomeScreen()
                    .navigatesTo(UnpossibleQuiz.self, usesBackButton: false)
                    .navigatesTo(Settings.self)
                    .navigatesTo(Credits.self)
            }
        }
    }
}
