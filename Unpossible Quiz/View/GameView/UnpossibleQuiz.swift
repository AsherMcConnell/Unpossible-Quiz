//
//  UnpossibleQuiz.swift
//  Unpossible Quiz
//
//  Created by Asher McConnell on 6/21/23.
//

import SwiftUI
import NavigationRouter
import AnimationSequence

struct UnpossibleQuiz: View {
    
    @ObservedObject var quizVM: QuizViewModel
    
    @State var sliderValue: Double = 0
    @State var sliderColor: String = "red"
    
    @State var backgroundIsAnimating: Bool? = nil
    @State var barkAnimation = false
    
    @NavRouter var navRouter
    
    @State var skipAnimate: Bool = false
    @State var newSkipAnimate: Bool = false
    
    @State var lostLifeActive: Bool = false
    @State var gameOverActive: Bool = false
    @State var victoryActive: Bool = false
    @State var positionX: CGFloat = -150
    @State var positionY: CGFloat = 0
    
    @State var bluePositionX: CGFloat = -350
    
    @State var animation = true
    
    var body: some View {
        ZStack {
            
//                Ro
//                    .foregroundColor(.clear)
//                    .frame(width: 450, height: 800)
            
            skipAdd
                .zIndex(20)
            gameOver
                .zIndex(5)
            victoryScreen
                .zIndex(5)
            loseLifePopUp
                .zIndex(10)
                        VStack {
                            if quizVM.questionNum == 0 {
                                questionIncorrectly
                            } else if quizVM.questionNum == 3 {
                                questionRainbow
                            } else if quizVM.questionNum == 5 {
                                questionSlider
                            } else if quizVM.questionNum == 8 {
                                questionCupNBall
                            } else if quizVM.questionNum == 14 {
                                questionCatchMe
                            } else {
                                defaultQuestionTitle
                            }
            
                            Spacer()
                            answersShape
                            Spacer()
                            if quizVM.questionNum == 5 {
                            } else {
                                HStack {
//                                    Button {
//                                        quizVM.nextQuestion()
//                                    } label: {
//                                        Text("sdfasdfg")
//                                    }
                                    lives
                                    Button {
                                        if !skipAnimate {
                                            SoundManager.instance.playSound(sound: .dingCorrect)
                                            skipAnimate.toggle()
                                            quizVM.nextQuestion()
                                        }
                                    } label: {
                                        ZStack {
                                            Image(systemName: "arrow.forward")
                                                .resizable()
                                                .frame(width: 85, height: 65)
                                                .foregroundColor(.black)
                                            Image(systemName: "arrow.forward")
                                                .resizable()
                                                .frame(width: 70, height: 65)
                                                .foregroundColor(Color("red"))
                                        }
                                        .offset(x: skipAnimate ? 800 : 0)
                                        .animation(.easeIn(duration: 1.0), value: skipAnimate)
                                    }
                                    .padding(.trailing, 80)
                                    
                                }
                            }
                        }
                        .blur(radius: gameOverActive || victoryActive ? 10 : 0)
                        .animation(.linear(duration: 0.7), value: gameOverActive)
        }
    }
}

//
//struct UnpossibleQuiz_Previews: PreviewProvider {
//    static var previews: some View {
//        UnpossibleQuiz()
//    }
//}

// MARK: CONSTANTS

extension UnpossibleQuiz {
    private struct Constants {
        
        static let colorArrayForBackground = ["red","blue","red","blue","red","blue","red","blue","red","blue","red","blue"]
        
        // MARK: - questionIncorrectly
        static let questionIncorrectlyFirstText = "What word is always spelled"
        static let questionIncorrectlyButtonText = "incorrectly"
        static let questionIncorrectlyLastText = " in every dictionary ?"
        
        // MARK: - questionRainbow
        
        static let questionRainbowBodyText = "What will you find at the end of a rainbo"
        static let questionRainbowButtonText = "w"
        
        static let questionRainbowEndText = "?"
        
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
            if quizVM.questionNum == 11 {
                Text("?")
                    .font(.custom(Constants.drawFont, size: 20))
            } else {
                Text("\(quizVM.questionNum + 1).")
                    .font(.custom(Constants.drawFont, size: Constants.fontSize))
            }
            
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
    var gameOver: some View {
        ZStack {
            VStack {
                Image("gameOver")
                    .resizable()
                    .frame(width: gameOverActive ? 300 : 0, height: gameOverActive ? 400 : 0)
                    .rotationEffect(.degrees(-90))
                Image("tryAgain")
                    .resizable()
                    .frame(width:gameOverActive ? 130 : 0, height: gameOverActive ? 200 : 0)
                    .rotationEffect(.degrees(-90))
                    .onTapGesture {
                        SoundManager.instance.playSound(sound: .click)
                        navRouter.popToRoot()
                        
                        quizVM.reset()
                    }
            }
            .rotationEffect(.degrees(gameOverActive ? 360 : 0))
            .animation(.spring(dampingFraction: 2.0 ,blendDuration: 20.0), value: gameOverActive)
            
        }
    }
    var loseLifePopUp: some View {
        ZStack {
            Image("lostLife")
                .resizable()
                .frame(width: 250, height: 300)
                .offset(x: lostLifeActive ? -420 : 340)
                .animation(.easeInOut(duration: 2.5), value: lostLifeActive)
            
        }
    }
    var skipAdd: some View {
        ZStack {
            Circle()
                .frame(width: 300)
                .foregroundColor(Color("green"))
            Text("+1 SKIP")
                .font(.custom(Constants.drawFont, size: 50))
        }
        .opacity(newSkipAnimate ? 1 : 0)
        
    }
    var victoryScreen: some View {
        ZStack {
            VStack {
                Image("victory")
                    .resizable()
                    .frame(width: victoryActive ? 350 : 0, height: victoryActive ? 200 : 0)
                Image("home")
                    .resizable()
                    .frame(width:victoryActive ? 200 : 0, height: victoryActive ? 130 : 0)
                    .onTapGesture {
                        SoundManager.instance.playSound(sound: .click)
                        navRouter.popToRoot()
                        quizVM.reset()
                    }
            }
            .rotationEffect(.degrees(victoryActive ? 360 : 0))
            .animation(.spring(dampingFraction: 2.0 ,blendDuration: 20.0), value: victoryActive)
            
        }
    }
    
    // MARK: - QUESTION VIEWS
    
    var questionIncorrectly: some View {
        FlowLayout {
            numOfQuestion
            ForEach(Array(zip(0..., Constants.questionIncorrectlyFirstText.components(separatedBy: " "))), id: \.0) { word in
                Text(word.1 + " ")
            }
            Button {
                SoundManager.instance.playSound(sound: .dingCorrect)
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
            ForEach(Array(zip(0..., Constants.questionRainbowBodyText.components(separatedBy: " "))), id: \.0) { word in
                Text(word.1 + "")
            }
            Button {
                SoundManager.instance.playSound(sound: .dingCorrect)
                quizVM.nextQuestion()
            } label: {
                Text(Constants.questionRainbowButtonText)
            }
            ForEach(Array(zip(0..., Constants.questionRainbowEndText.components(separatedBy: " "))), id: \.0) { word in
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
                        SoundManager.instance.playSound(sound: .dingCorrect)
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
                    Text("NO SKIPPING")
                        .frame(width: 200)
                        .font(.custom(Constants.drawFont, size: 40))
                    
                    
                    
                }
            }
        }
    }
    var questionCatchMe: some View {
        VStack {
            FlowLayout {
                numOfQuestion
                    .foregroundColor(.white)
                ForEach(Array(zip(0..., quizVM.currentQuestion.questionText.components(separatedBy: " "))), id: \.0) { word in
                    Text(word.1 + " ")
                }
                .foregroundColor(.black)
                .font(.custom(Constants.drawFont, size: Constants.fontSize))
        }
            ZStack {
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color("green"))
                    .opacity(0.5)
                    .zIndex(-10)
                    .offset(y: 300)
                    .onTapGesture {
                        if quizVM.lives == 2 {
                            gameOverActive.toggle()
                            SoundManager.instance.playSound(sound: .gameOver)
                        } else if quizVM.lives <= 1 {
                            SoundManager.instance.playSound(sound: .boomIncorrect)
                            quizVM.lives += 1
                        } else {
                            SoundManager.instance.playSound(sound: .dingCorrect)
                            quizVM.nextQuestion()
                        }
                    }
                    
            Circle()
                .frame(width: 60, height: 60)
                .foregroundColor(Color("red"))
                .offset(x: bluePositionX, y: 300)
                .animation(.linear(duration: 0.8).repeatForever(autoreverses: true))
                .onTapGesture {
                    SoundManager.instance.playSound(sound: .victory)
                    victoryActive.toggle()
                }
                .onAppear {
                    withAnimation(.linear(duration: 0.8)) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            bluePositionX += 800
                            
                        }
                    }
                        
                    }
                }
        }
    }
    
    // MARK: - ViewsFor CUPnBALL
    
    var questionCupNBall: some View {
        ZStack {
            backgroundAnimation
            blueBall
            lives
                .padding(.leading, 240)
                .padding(.top, 830)
            VStack {
                    FlowLayout {
                        numOfQuestion
                            .foregroundColor(.white)
                        ForEach(Array(zip(0..., quizVM.currentQuestion.questionText.components(separatedBy: " "))), id: \.0) { word in
                            Text(word.1 + " ")
                        }
                        .foregroundColor(.black)
                        .font(.custom(Constants.drawFont, size: Constants.fontSize))
                }
                rowOfBalls
                rowOfBalls
                HStack {
                    Group {
                        bigCircle
                            .padding(.trailing, 50)
                        bigCircle
                            .padding(.trailing, 50)
                    }
                    .onTapGesture {
                        if quizVM.lives == 2 {
                            gameOverActive.toggle()
                            SoundManager.instance.playSound(sound: .gameOver)
                        } else if quizVM.lives <= 1 {
                            SoundManager.instance.playSound(sound: .boomIncorrect)
                            quizVM.lives += 1
                        } else {
                            SoundManager.instance.playSound(sound: .dingCorrect)
                            quizVM.nextQuestion()
                        }
                    }
                    bigCircle
                        .onTapGesture {
                            
                            SoundManager.instance.playSound(sound: .dingCorrect)
                            
                            if skipAnimate {
                                newSkipAnimate.toggle()
                                skipAnimate.toggle()
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                if newSkipAnimate {
                                    newSkipAnimate.toggle()
                                }
                                quizVM.nextQuestion()
                            }
                        }
                }.padding(.horizontal, 10).padding(.top, 50)
                rowOfBalls
                
            }
        }
        .onAppear {
            withAnimation {
                if backgroundIsAnimating == nil {
                    backgroundIsAnimating = false
                }
            }
        }
    }
    
    var rowOfBalls: some View {
        HStack {
            bigCircle
                .padding(.trailing, 50)
            bigCircle
                .padding(.trailing, 50)
            bigCircle
        }.padding(.horizontal, 10).padding(.top, 50)
            .onTapGesture {
                if quizVM.lives == 2 {
                    gameOverActive.toggle()
                    SoundManager.instance.playSound(sound: .gameOver)
                } else if quizVM.lives <= 1 {
                    SoundManager.instance.playSound(sound: .boomIncorrect)
                    quizVM.lives += 1
                } else {
                    SoundManager.instance.playSound(sound: .dingCorrect)
                    quizVM.nextQuestion()
                }
            }
    }
    var bigCircle: some View {
        Circle()
            .shadow(color: Color(animation ? "darkRed" : "blue"), radius: animation ? 100 : 20)
            .frame(width: animation ? 100 : 110, height: animation ? 100 : 110)
            .foregroundColor(Color(animation ? "blue" : "darkRed"))
            .animation(.easeInOut(duration: 0.5), value: animation)
    }
    var blueBall: some View {
        Circle()
            .frame(width: 40, height: 40)
            .foregroundColor(Color("red"))
            .offset(x: positionX, y: positionY)
            .animation(.linear(duration: 0.3))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    positionX += 300
                    animation.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                    positionX -= 150
                    positionY += 300
                    animation.toggle()

                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    positionX += 150
                    positionY -= 150
                    animation.toggle()

                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
                    positionX -= 300
                    positionY += 150
                    animation.toggle()

                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 6.5) {
                    positionY -= 450
                    animation.toggle()

                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
                    positionX += 150

                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 7.4) {
                    positionX += 150
                    positionY += 150
                    animation.toggle()

                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 7.8) {
                    positionX -= 300


                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 8.2) {
                    positionX += 300
                    positionY += 150
                    animation.toggle()

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
    
    // MARK: - OTHER VIEWS
    
    var dogWoof: some View {
            HStack {
                Image("dogBark")
                    .resizable()
                    .frame(width: 150, height: 150)
                ZStack {
                    Text("WOOF")
                        .font(.custom(Constants.drawFont, size: 58))
                        .opacity(barkAnimation ? 1 : 0)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                barkAnimation.toggle()
                                SoundManager.instance.playSound(sound: .dogBark)
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                barkAnimation.toggle()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                barkAnimation.toggle()
                                SoundManager.instance.playSound(sound: .dogBark)

                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                                barkAnimation.toggle()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                                barkAnimation.toggle()
                                SoundManager.instance.playSound(sound: .dogBark)

                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                                barkAnimation.toggle()
                            }
                        }
                    VStack {
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(.black ,lineWidth: 10)
                            .frame(width: 150, height: 100)
                        HStack {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 50, height: 10)
                                .rotationEffect(.degrees(-45))
                            Spacer()
                        }
                    }
                }
            }
    }
    
    var defaultQuestionTitle: some View {
        FlowLayout {
            numOfQuestion
            if quizVM.questionNum == 13 {
                dogWoof
            } else {
                ForEach(Array(zip(0..., quizVM.currentQuestion.questionText.components(separatedBy: " "))), id: \.0) { word in
                    Text(word.1 + " ")
                }
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
                    if quizVM.questionNum == 7 || quizVM.questionNum == 2 {
                        ZStack {
                            Image(answer.answerText)
                                .resizable()
                                .frame(width: 160, height: 160)
                                .scaledToFill()
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(Color(answer.color))
                                .frame(width: Constants.answerShapeWidth, height: Constants.answerShapeHeight)
                                .shadow(radius: 10)
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
                            .shadow(radius: 10)
                            .frame(width: Constants.answerShapeWidth, height: Constants.answerShapeHeight)
                    }
                }
                .onTapGesture {
                    if !answer.correctAnswer && quizVM.lives == 2 {
                        gameOverActive.toggle()
                        SoundManager.instance.playSound(sound: .gameOver)
                    } else if !answer.correctAnswer && quizVM.lives <= 1 {
                        SoundManager.instance.playSound(sound: .boomIncorrect)
                        lostLifeActive.toggle()
                        quizVM.lives += 1
                    } else {
                        SoundManager.instance.playSound(sound: .dingCorrect)
                        quizVM.nextQuestion()
                    }
                }
            }
        }
        
    }
    
    var backgroundAnimation: some View {
            VStack {
                ForEach(0..<40) { color in
                    HStack {
                        ForEach(Constants.colorArrayForBackground, id: \.self) { color in
                           Circle()
                                .opacity(1)
                                .foregroundColor(Color(color))
                                .frame(width: 70, height: 70)
                                .offset(x: backgroundIsAnimating ?? true ? -150 : 179)
                                .animation(.linear(duration: 1).repeatForever(autoreverses: true), value: backgroundIsAnimating)
                                .rotationEffect(.degrees(backgroundIsAnimating ?? true ? 10 : -10))
                                .animation(.linear(duration: 1).repeatForever(autoreverses: true), value: backgroundIsAnimating)
                        }
                    }
                }
            }
        }
}



