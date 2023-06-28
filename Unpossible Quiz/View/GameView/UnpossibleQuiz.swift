//
//  UnpossibleQuiz.swift
//  Unpossible Quiz
//
//  Created by Asher McConnell on 6/21/23.
//

import SwiftUI

struct UnpossibleQuiz: View {
    
    @ObservedObject var quizVM = QuizViewModel()
    @State var sliderValue: Double = 0
    @State var sliderColor: String = "red"

    
    var body: some View {
        ZStack {
            VStack {
                if quizVM.questionNum == 0 {
                    questionIncorrectly
                } else if quizVM.questionNum == 2 {
                    questionRainbow
                } else if quizVM.questionNum == 4 {
                    questionSlider
                } else {
                    defaultQuestionTitle
                }
                
                Spacer()
                answersShape
                Spacer()
                if quizVM.questionNum == 4 {
                } else {
                    lives
                }
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
        
        // MARK: - questionIncorrectly
        static let questionIncorrectlyFirstText = "What word is always spelled"
        static let questionIncorrectlyButtonText = "incorrectly"
        static let questionIncorrectlyLastText = " in every dictionary ?"
        
        // MARK: - questionRainbow
        
        static let questionRainbowButtonText = "W"
        static let questionRainbowBodyText = "hat will you find at the end of a rainbow?"
        
        // MARK: - Answers
        
        static let columns: [GridItem] = [
            GridItem(.flexible(), spacing: 0, alignment: nil),
            GridItem(.flexible(), spacing: 0, alignment: nil),
        ]
        
        static let colorArray = ["blue", "red", "green", "yellow"]
        static let answerShapeWidth: CGFloat = 190
        static let answerShapeHeight: CGFloat = 270
        
        // MARK: - Font
        
        static let drawFont = "DeliciousHandrawn-Regular"
        static let fontSize: CGFloat = 45
        
        // MARK: - Lives
        
        static let livesTitleArray = ["livesGreen", "livesYellow", "livesRed"]
        static let livesArray = ["threeLives", "twoLives", "oneLive"]
        
    }
}

// MARK: SliderConstants

extension UnpossibleQuiz {
    private struct Slip {
        
        // MARK: - COLOR
        
        static let colorSlide = ["red", "yellow", "green", "blue", "purple"]
        
        // MARK: - YOU
        
        static let y: CGFloat = 30
        static let o: CGFloat = 70
        static let u: CGFloat = 110

        // MARK: - MUST
        
        static let m: CGFloat = 150
        static let uInMust: CGFloat = 110
        static let s: CGFloat = 70
        static let t: CGFloat = 30
        
        // MARK: - TAKE
        
        static let tInTake: CGFloat = 30
        static let a: CGFloat = 70
        static let k: CGFloat = 110
        static let e: CGFloat = 150
        
        // MARK: - THE
        
        static let tInThe: CGFloat = 130
        static let hInThe: CGFloat = 90
        static let eInThe: CGFloat = 50
        
        // MARK: - L
    }
}

// MARK: VIEWS

extension UnpossibleQuiz {
    var numOfQuestion: some View {
        ZStack {
            Text("\(quizVM.questionNum + 1).")
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
            Image(Constants.livesTitleArray[quizVM.lives])
                .resizable()
                .frame(width: 150)
                .padding(.leading, 30)
            Image(Constants.livesArray[quizVM.lives])
                .resizable()
                .frame(width: 40)
            Spacer()
        }.frame(height: 50)
    }
    
    // MARK: - QUESTION VIEWS
    
    var questionIncorrectly: some View {
        FlowLayout {
            numOfQuestion
            ForEach(Array(zip(0..., Constants.questionIncorrectlyFirstText.components(separatedBy: " "))), id: \.0) { word in
                Text(word.1 + " ")
            }
            Button {
                quizVM.nextQuestion()
            } label: {
                Text(Constants.questionIncorrectlyButtonText + " ")
                
            }
            
            ForEach(Array(zip(0..., Constants.questionIncorrectlyLastText.components(separatedBy: " "))), id: \.0) { word in
                Text(word.1 + " ")
            }
        }
        .foregroundColor(.black)
        .font(.custom(Constants.drawFont, size: Constants.fontSize))
        
    }
    var questionRainbow: some View {
        FlowLayout {
            numOfQuestion
            Button {
                quizVM.nextQuestion()
            } label: {
                Text(Constants.questionRainbowButtonText)
            }
            ForEach(Array(zip(0..., Constants.questionRainbowBodyText.components(separatedBy: " "))), id: \.0) { word in
                Text(word.1 + " ")
            }
        }
        .foregroundColor(.black)
        .font(.custom(Constants.drawFont, size: Constants.fontSize))
    }
    var questionSlider: some View {
        ZStack {
            VStack{
                HStack {
                    numOfQuestion
                        .padding(.leading, 15)
                    Spacer()
                }
                if sliderValue == 0 {
                    click1
                } else if sliderValue == 1 {
                    click2
                } else if sliderValue == 2 {
                    click3
                } else if sliderValue == 3 {
                    click4
                } else if sliderValue == 4 {
                    click5
                }
                Spacer()
                
                HStack {
                    Spacer()
                    ForEach(Slip.colorSlide, id: \.self) { color in
                        Rectangle()
                            .foregroundColor(Color(color))
                            .frame(width: 70, height: 40)
                    }
                    Spacer()
                }
                Slider(value: $sliderValue, in: 0...4, step: 1.0)
                    .padding()
                FlowLayout {
                    
                    Button {
                        quizVM.nextQuestion()
                    } label: {
                        Image("Limage")
                            .resizable()
                            .frame(width: 30, height: 45)
                            .padding(.trailing, 2)
                    }
                    
                    Image("ivesimage")
                        .resizable()
                        .frame(width: 110, height: 45)
                        
                    
                    Image(Constants.livesArray[quizVM.lives])
                        .resizable()
                        .frame(width: 40, height: 45)
                    Text("")
                        .frame(width: 200)
            
                    
                }
            }
        }
    }
    
    // MARK: - questionSliderViews
    
    var click1: some View {
        VStack{
            HStack {
                Text("o")
                    .font(.custom(Constants.drawFont, size: 110))
                    .padding(.leading, Slip.o)
                Spacer()
                Text("t")
                    .font(.custom(Constants.drawFont, size: 110))
                    .padding(.trailing, Slip.t)
            }
            HStack {
                Text("k")
                    .font(.custom(Constants.drawFont, size: 110))
                    .padding(.leading, Slip.k)
                Spacer()
                Text("")
                    .font(.custom(Constants.drawFont, size: 110))
                    .padding(.trailing, 60)
            }
            HStack {
                Text("")
                    .font(.custom(Constants.drawFont, size: 110))
            }
        }
        .foregroundColor(Color("red"))
        .padding(.top, 50)
    }
    var click2: some View {
        VStack {
            HStack {
                Text("")
                    .font(.custom(Constants.drawFont, size: 110))
                    .padding(.leading, 30)
                Spacer()
                Text("u")
                    .font(.custom(Constants.drawFont, size: 110))
                    .padding(.trailing, Slip.uInMust)
            }
            HStack {
                Text("a")
                    .font(.custom(Constants.drawFont, size: 110))
                    .padding(.leading, Slip.a)
                Spacer()
                Text("e")
                    
                    .font(.custom(Constants.drawFont, size: 110))
                    .padding(.trailing, Slip.eInThe)
            }
            HStack {
                Text("")
                    .font(.custom(Constants.drawFont, size: 110))
            }
        }
        .foregroundColor(Color("yellow"))
        .padding(.top, 50)
    }
    var click3: some View {
        VStack{
            HStack {
                Text("Y")
                    .font(.custom(Constants.drawFont, size: 110))
                    .padding(.leading, Slip.y)
                Spacer()
                Text("s")
                    .font(.custom(Constants.drawFont, size: 110))
                    .padding(.trailing, Slip.s)
            }
            HStack {
                Text("")
                    .font(.custom(Constants.drawFont, size: 110))
                    .padding(.leading, 50)
                Spacer()
                Text("T")
                    .font(.custom(Constants.drawFont, size: 110))
                    .padding(.trailing, Slip.tInThe)
            }
            HStack {
                Text("")
                    .font(.custom(Constants.drawFont, size: 110))
            }
        }
        .foregroundColor(Color("green"))
        .padding(.top, 50)
    }
    var click4: some View {
        VStack{
            HStack {
                Text("u")
                    .font(.custom(Constants.drawFont, size: 110))
                    .padding(.leading, Slip.u)
                Spacer()
                Text("")
                    .font(.custom(Constants.drawFont, size: 110))
                    .padding(.trailing, 30)
            }
            HStack {
                Text("T")
                    .font(.custom(Constants.drawFont, size: 110))
                    .padding(.leading, Slip.tInTake)
                Spacer()
                Text("h")
                    .font(.custom(Constants.drawFont, size: 110))
                    .padding(.trailing, Slip.hInThe)
            }
            HStack {
                Text("")
                    .font(.custom(Constants.drawFont, size: 110))
            }
        }
        .foregroundColor(Color("blue"))
        .padding(.top, 50)
    }
    var click5: some View {
        VStack{
            HStack {
                Text("")
                    .font(.custom(Constants.drawFont, size: 110))
                    .padding(.leading, 30)
                Spacer()
                Text("M")
                    .font(.custom(Constants.drawFont, size: 110))
                    .padding(.trailing, Slip.m)
            }
            HStack {
                Text("e")
                    .font(.custom(Constants.drawFont, size: 110))
                    .padding(.leading, Slip.e)
                Spacer()
                Text("")
                    .font(.custom(Constants.drawFont, size: 110))
                    .padding(.trailing, 60)
            }
            HStack {
                Text("L")
                    .font(.custom(Constants.drawFont, size: 110))
            }
        }
        .foregroundColor(Color("purple"))
        .padding(.top, 50)
    }
    
    var defaultQuestionTitle: some View {
        FlowLayout {
            numOfQuestion
            ForEach(Array(zip(0..., quizVM.currentQuestion.questionText.components(separatedBy: " "))), id: \.0) { word in
                Text(word.1 + " ")
            }
        }
        .foregroundColor(.black)
        .font(.custom(Constants.drawFont, size: Constants.fontSize))
        .padding(.leading, 5)
    }
    
    var answersShape: some View {
        LazyVGrid(columns: Constants.columns) {
            ForEach(quizVM.currentQuestion.answers, id: \.self) { answer in
                ZStack {
                    if quizVM.questionNum == 6 {
                        ZStack {
                            Image(answer.answerText)
                                .resizable()
                                .frame(width: 160, height: 160)
                                .scaledToFill()
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(Color(answer.color))
                                .frame(width: Constants.answerShapeWidth, height: Constants.answerShapeHeight)
                                .zIndex(-1)
                        }
                        
                    } else {
                        Text(answer.answerText)
                            .foregroundColor(.white)
                            .frame(width: Constants.answerShapeWidth, height: Constants.answerShapeHeight)
                            .font(.custom(Constants.drawFont, size: 40))
                            .zIndex(5)
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color(answer.color))
                            .frame(width: Constants.answerShapeWidth, height: Constants.answerShapeHeight)
                    }
                }
                .onTapGesture {
                    if !answer.correctAnswer && quizVM.lives <= 1 {
                        quizVM.lives += 1
                    } else {
                        quizVM.nextQuestion()
                    }
                }
            }
        }
        
    }
}


