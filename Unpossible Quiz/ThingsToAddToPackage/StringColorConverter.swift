//
//  StringColorConverter.swift
//  Unpossible Quiz
//
//  Created by Asher McConnell on 6/26/23.
//

import SwiftUI

extension String {
    func colorConverter() -> Color {
        switch self {
        case "red": return Color.red
        case "orange": return Color.orange
        case "yellow" : return Color.yellow
        case "gray" : return Color.gray
        case "white" : return Color.white
        case "pink" : return Color.pink
        case "brown" : return Color.brown
        case "green" : return Color.green
        case "purple" : return Color.purple
        case "black" : return Color.black
        default : return Color.blue
        }
    }
}
