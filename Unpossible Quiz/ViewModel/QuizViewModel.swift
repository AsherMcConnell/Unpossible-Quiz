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
                     Answer(answerText: "Math", color: "yellow", correctAnswer: false)]),
        Question(questionText: "What has four eyes but can't see?", answers:
                    [Answer(answerText: "spider", color: "red", correctAnswer: false),
                     Answer(answerText: "shrek", color: "green", correctAnswer: false),
                     Answer(answerText: "mississippi", color: "blue", correctAnswer: true),
                     Answer(answerText: "romanFour", color: "yellow", correctAnswer: false)].shuffled()),
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
                     Answer(answerText: "Flappy Bird", color: "green", correctAnswer: false)].shuffled()),
        Question(questionText: "What has 4 wheels and flies?", answers:
                    [Answer(answerText: "garbageTruck", color: "red", correctAnswer: true),
                     Answer(answerText: "airplane", color: "green", correctAnswer: false),
                     Answer(answerText: "schoolBus", color: "yellow", correctAnswer: false),
                     Answer(answerText: "helicopter", color: "blue", correctAnswer: false)].shuffled()),
        Question(questionText: "Follow The Ball", answers: []),
        
        Question(questionText: "What Was the Answer To Question 2?", answers:
                    [Answer(answerText: "This One", color: "red", correctAnswer: false),
                     Answer(answerText: "This One", color: "blue", correctAnswer: true),
                     Answer(answerText: "This One", color: "yellow", correctAnswer: false),
                     Answer(answerText: "This One", color: "green", correctAnswer: false)]),
        Question(questionText: "Forwards I’m heavy but backwards I’m not. What am I?", answers:
                    [Answer(answerText: "A  ton", color: "green", correctAnswer: true),
                     Answer(answerText: "Heavy", color: "red", correctAnswer: false),
                     Answer(answerText: "Backwards", color: "yellow", correctAnswer: false),
                     Answer(answerText: "Forwards", color: "blue", correctAnswer: false)].shuffled()),
        Question(questionText: "What question number are we on", answers:
                    [Answer(answerText: "9", color: "red", correctAnswer: false),
                     Answer(answerText: "11", color: "green", correctAnswer: false),
                     Answer(answerText: "12", color: "yellow", correctAnswer: true),
                     Answer(answerText: "10", color: "blue", correctAnswer: false)].shuffled()),
        Question(questionText: "What is Bubba's real name?", answers:
                    [Answer(answerText: "Bubbs", color: "red", correctAnswer: true),
                     Answer(answerText: "Derek", color: "green", correctAnswer: false),
                     Answer(answerText: "Mr.Hall", color: "blue", correctAnswer: false),
                     Answer(answerText: "PuttPro435", color: "yellow", correctAnswer: false)].shuffled()),
        Question(questionText: "dogBark", answers:
                    [Answer(answerText: "woof woof", color: "red", correctAnswer: false),
                     Answer(answerText: "woof woof woof", color: "green", correctAnswer: true),
                     Answer(answerText: "WOOFFFF", color: "yellow", correctAnswer: false),
                     Answer(answerText: "woof woof woof woof", color: "blue", correctAnswer: false)].shuffled())
        
    ]
    
    func nextQuestion() {
        if questionNum <= 12 {
            questionNum += 1
            currentQuestion = questionDataDefault[questionNum]
        }
    }
    
}
