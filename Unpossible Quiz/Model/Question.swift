//
//  Question.swift
//  Unpossible Quiz
//
//  Created by Asher McConnell on 6/26/23.
//

import Foundation

struct Question: Identifiable {
    var questionText: String
    var answers: [Answer]
    var id = UUID()
}
