//
//  QuizeViewModel.swift
//  Unpossible Quiz
//
//  Created by Asher McConnell on 6/26/23.
//

import SwiftUI

class QuizViewModel: ObservableObject {
    
    var questionNum = 0
    
    @Published var currentQuestion: Question
    
    init() {
        self.currentQuestion = questionData[self.questionNum]
    }
    
    var questionData = [Question(questionText:"What word is spelled incorrectly in every single dictionary?", answers: [Answer(answerText: "Werd", color: "blue"), Answer(answerText: "Bologney", color: "red"), Answer(answerText: "Misasippy", color: "yellow"), Answer(answerText: "highperbowlee", color: "green")])]
    
    func nextQuestion() {
        questionNum += 1
    }
    
}
