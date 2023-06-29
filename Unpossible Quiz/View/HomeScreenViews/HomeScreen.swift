//
//  HomeScreen.swift
//  Unpossible Quiz
//
//  Created by Asher McConnell on 6/20/23.
//

import SwiftUI
import NavigationRouter

struct HomeScreen: View {
    
    @StateObject var quizVM = QuizViewModel()
    
    @NavRouter var navRouter
    @State var backgroundIsAnimating: Bool? = nil
    
//    var highscore = UserDefaults.standard.integer(forKey: "HIGHSCORE")

    
    var body: some View {
        ZStack {
                backgroundAnimation
            VStack {
                Spacer()
                title
                    .padding(.bottom, 100)
                
//                highScore
                startCreditsSettings
                Spacer()
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
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

// MARK: CONSTANTS

extension HomeScreen {
    private struct Constants {
        
        // MARK: - Title/Highscore
        
        static let titleWidth: CGFloat = 375
        static let titleHeight: CGFloat = 240
        static let titleTopPadding: CGFloat = 26
        
        static let highScoreFontSize: CGFloat = 65
        static let drawingFont = "DeliciousHandrawn-Regular"
        
        // MARK: - Buttons
        
        static let colorButtonWidth: CGFloat = 250
        static let colorButtonHeight: CGFloat = 75
        static let colorButtonRadius: CGFloat = 15
        static let borderButtonWidth: CGFloat = 260
        static let borderButtonHeight: CGFloat = 85
        static let borderButtonRadius: CGFloat = 20
        static let imageWidth: CGFloat = 225
        static let imageHeight: CGFloat = 70
        static let shadow: CGFloat = 3
        
        // MARK: - Animated Background
        
        static let colorArray = ["yellow","red","blue","yellow","red","blue", "yellow"]

    }
}


// MARK: VIEWS

extension HomeScreen {
    var title: some View {
        Image("untitle")
            .resizable()
            .frame(width: Constants.titleWidth, height: Constants.titleHeight)
            .padding(.top, Constants.titleTopPadding)
    }
    
    var startCreditsSettings: some View {
        ZStack {
            ZStack {
                Text("COMING SOON")
                    .font(.custom(Constants.drawingFont, size: 30))
                    .zIndex(5)
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.brown)
                    .frame(width: 150, height: 90)
            }
            .padding(.top, 100)
            .zIndex(10)
            VStack {
                buttonOnHomeScreen(color: "yellow", image: "start") {
                    navRouter.push(UnpossibleQuiz())
                    SoundManager.instance.playSound(sound: .click)
                }
                ZStack {
                    Image("dangerTape")
                        .resizable()
                        .frame(width: 250, height: 90)
                        .zIndex(5)
                    buttonOnHomeScreen(color: "red", image: "settings") {
//                        navRouter.push(Settings())
                    }
                }
                ZStack {
                    Image("dangerTape")
                        .resizable()
                        .frame(width: 250, height: 90)
                        .zIndex(5)
                    buttonOnHomeScreen(color: "blue", image: "credits") {
//                        navRouter.push(Credits())
                    }
                }
            }
        }
    }
    
    var highScore: some View {
        HStack {
            Text("High Score: 0")
                .font(.custom(Constants.drawingFont, size: Constants.highScoreFontSize))
        }
    }
    
    var backgroundAnimation: some View {
            VStack {
                ForEach(0..<40) { color in
                    HStack {
                        ForEach(Constants.colorArray, id: \.self) { color in
                            RoundedRectangle(cornerRadius: 10)
                                .opacity(0.7)
                                .foregroundColor(Color(color))
                                .frame(width: 100, height: 20)
                                .offset(x: backgroundIsAnimating ?? true ? -150 : 179)
                                .animation(.linear(duration: 6).repeatForever(autoreverses: false), value: backgroundIsAnimating)
                                .rotationEffect(.degrees(backgroundIsAnimating ?? true ? 10 : -10))
                                .animation(.linear(duration: 6).repeatForever(autoreverses: true), value: backgroundIsAnimating)
                        }
                    }
                }
            }
        }
}

// MARK: FUNCS

extension HomeScreen {
    
    func buttonOnHomeScreen(color: String, image: String, destination: @escaping () -> Void) -> some View {
        Button {
            destination()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: Constants.borderButtonRadius)
                    .frame(width: Constants.borderButtonWidth, height: Constants.borderButtonHeight)
                    .foregroundColor(.black)
                    .shadow(color: Color(color), radius: Constants.shadow)
                RoundedRectangle(cornerRadius: Constants.colorButtonRadius)
                    .frame(width: Constants.colorButtonWidth, height: Constants.colorButtonHeight)
                    .foregroundColor(Color(color))
                Image(image)
                    .resizable()
                    .frame(width: Constants.imageWidth, height: Constants.imageHeight)
                
            }
        }
    }
}
