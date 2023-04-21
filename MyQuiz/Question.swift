//
//  Question.swift
//  MyQuiz
//
//  Created by Mercedes Martinez Milantchi on 4/21/23.
//

import Foundation


class Question {
    let text: String
    let answers: [String]
    let correctAnswerIndex: Int
    
    init(text: String, answers: [String], correctAnswerIndex: Int) {
        self.text = text
        self.answers = answers
        self.correctAnswerIndex = correctAnswerIndex
    }
}
