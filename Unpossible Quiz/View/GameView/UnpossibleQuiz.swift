//
//  UnpossibleQuiz.swift
//  Unpossible Quiz
//
//  Created by Asher McConnell on 6/21/23.
//

import SwiftUI

struct UnpossibleQuiz: View {
    
    @ObservedObject var quizVM = QuizViewModel()
    @State var changeInLives = 0
    
    var body: some View {
        ZStack {
            VStack {
                    questionTitleWithButton
                Spacer()
                answersShape
                Spacer()
                lives
            }
        }
    }
}

struct UnpossibleQuiz_Previews: PreviewProvider {
    static var previews: some View {
        UnpossibleQuiz()
    }
}

// MARK: CONSTANTS

extension UnpossibleQuiz {
    private struct Constants {
        
        // MARK: - Title
        static let titleFirst = "What word is always spelled"
        static let titleLast = " in every dictionary ?"
        static let fontSize: CGFloat = 45
        
        // MARK: - Answers
        
        static let columns: [GridItem] = [
            GridItem(.flexible(), spacing: 0, alignment: nil),
            GridItem(.flexible(), spacing: 0, alignment: nil),
        ]

        static let colorArray = ["blue", "red", "green", "yellow"]
        
        // MARK: - Font
        
        static let drawFont = "DeliciousHandrawn-Regular"
        
        // MARK: - Lives
        
        static let livesTitleArray = ["livesGreen", "livesYellow", "livesRed"]
        static let livesArray = ["threeLives", "twoLives", "oneLive"]
        
    
        

    }
}

// MARK: VIEWS

extension UnpossibleQuiz {
    var numOfQuestion: some View {
        ZStack {
            Text("\(quizVM.questionNum ).")
                .font(.custom(Constants.drawFont, size: Constants.fontSize))

            Circle()
                .stroke(lineWidth: 4)
                .frame(width: Constants.fontSize, height: Constants.fontSize)
                .padding(.top, 10)
            
        }
        .padding(.trailing, 15)
        .foregroundColor(Color("darkRed"))
    }
    
    var lives: some View {
        HStack {
            Image(Constants.livesTitleArray[changeInLives])
                .resizable()
                .frame(width: 150, height: 50)
                .padding(.leading, 30)
            Image(Constants.livesArray[changeInLives])
                .resizable()
                .frame(width: 40, height: 50)
            Spacer()
        }
    }
    
    var questionTitleWithButton: some View {
        FlowLayout {
                numOfQuestion
                ForEach(Array(zip(0..., Constants.titleFirst.components(separatedBy: " "))), id: \.0) { word in
                    Text(word.1 + " ")
                }
                Button {
                    
                } label: {
                    Text("incorrectly" + " ")
                        
                }
            
                ForEach(Array(zip(0..., Constants.titleLast.components(separatedBy: " "))), id: \.0) { word in
                    Text(word.1 + " ")
                }
        }
        .foregroundColor(.black)
        .font(.custom(Constants.drawFont, size: Constants.fontSize))
    }
    
    var answersShape: some View {
        LazyVGrid(columns: Constants.columns) {
            ForEach(quizVM.currentQuestion.answers, id: \.self) { answer in
                ZStack {
                    Text(answer.answerText)
                        .foregroundColor(.white)
                        .font(.custom(Constants.drawFont, size: 40))
                        .zIndex(5)
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(Color(answer.color))
                        .frame(width: 190, height: 270)
                }
                .onTapGesture {
                    if changeInLives <= 1 {
                        changeInLives += 1
                    }
                }
            }
        }
        
    }
}


