//
//  GameOver.swift
//  Unpossible Quiz
//
//  Created by Asher McConnell on 6/28/23.
//

import SwiftUI
import NavigationRouter

struct GameOver: View {
    
    @NavRouter var navRouter
    
    var body: some View {
        ZStack {
            Color.clear
                .ignoresSafeArea()
            VStack {
                Image("gameOver")
                    .resizable()
                    .frame(width: 300, height: 400)
                    .rotationEffect(.degrees(-90))
                Image("tryAgain")
                    .resizable()
                    .frame(width: 130, height: 200)
                    .rotationEffect(.degrees(-90))
                    .onTapGesture {
                        navRouter.popToRoot()
                    }
            }
        }
    }
}

struct GameOver_Previews: PreviewProvider {
    static var previews: some View {
        GameOver()
    }
}

// MARK: CONSTANTS

extension GameOver {
    private struct Constants {
        static let drawFont = "DeliciousHandrawn-Regular"

    }
}
