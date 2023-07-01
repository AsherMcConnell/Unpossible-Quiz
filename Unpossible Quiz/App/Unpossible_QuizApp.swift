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
//                    .navigatesTo(UnpossibleQuiz.self, usesBackButton: false, usesBackSwipe: false)
                    .navigatesTo(UnpossibleQuiz.self, backButtonDisabled: true, backSwipeDisabled: true)
                    .navigatesTo(Settings.self)
                    .navigatesTo(Credits.self)
            }
        }
    }
}
