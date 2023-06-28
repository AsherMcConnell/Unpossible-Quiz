//
//  QuizeViewModel.swift
//  Unpossible Quiz
//
//  Created by Asher McConnell on 6/26/23.
//

import SwiftUI

class QuizViewModel: ObservableObject {
    
    @Published var questionNum = 0
    @Published var lives = 0
    @Published var currentQuestion: Question
    
    init() {
        self.currentQuestion = questionDataDefault[0]
    }
    
    var questionDataDefault = [
        Question(questionText:"What word is spelled incorrectly in every single dictionary?", answers:
                    [Answer(answerText: "Werd", color: "blue", correctAnswer: false),
                     Answer(answerText: "Bologney", color: "red", correctAnswer: false),
                     Answer(answerText: "Misasippy", color: "yellow", correctAnswer: false),
                     Answer(answerText: "Highperbowlee", color: "green", correctAnswer: false)].shuffled()),
        
        Question(questionText: "How do you make the number one disappear?", answers:
                    [Answer(answerText: "Call a Magician", color: "red", correctAnswer: false),
                     Answer(answerText: "Add a G", color: "green", correctAnswer: true),
                     Answer(answerText: "U Don't!", color: "blue", correctAnswer: false),
                     Answer(answerText: "Math", color: "yellow", correctAnswer: false)].shuffled()),
        
        Question(questionText: "What will you find at the end of a rainbow?", answers:
                    [Answer(answerText: "A Leprechaun", color: "yellow", correctAnswer: false),
                     Answer(answerText: "Pot of Gold", color: "blue", correctAnswer: false),
                     Answer(answerText: "NOTHING", color: "red", correctAnswer: false),
                     Answer(answerText: "ROY G BIV", color: "green", correctAnswer: false)].shuffled()),
        Question(questionText: "How many seconds are there in a year?", answers:
                    [Answer(answerText: "12", color: "blue", correctAnswer: true),
                     Answer(answerText: "45,103,150", color: "green", correctAnswer: false),
                     Answer(answerText: "1", color: "red", correctAnswer: false),
                     Answer(answerText: "IDK", color: "yellow", correctAnswer: false)].shuffled()),
        Question(questionText: "Scroll Question", answers: []),
        Question(questionText: "What bird can lift the most weight?", answers:
                    [Answer(answerText: "Crane", color: "blue", correctAnswer: true),
                     Answer(answerText: "Canary", color: "yellow", correctAnswer: false),
                     Answer(answerText: "Angry Bird", color: "red", correctAnswer: false),
                     Answer(answerText: "Flappy Bird", color: "green", correctAnswer: false)]),
        Question(questionText: "What has 4 wheels and flies?", answers:
                    [Answer(answerText: "garbageTruck", color: "red", correctAnswer: true),
                     Answer(answerText: "airplane", color: "green", correctAnswer: false),
                     Answer(answerText: "schoolBus", color: "yellow", correctAnswer: false),
                     Answer(answerText: "helicopter", color: "blue", correctAnswer: false)])
    ]
    
    func nextQuestion() {
        if questionNum <= 5 {
            questionNum += 1
            currentQuestion = questionDataDefault[questionNum]
        }
    }
    
}
