//
//  Flow.swift
//  QuizEssentialDeveloper
//
//  Created by Camelia Braghes on 13.07.2023.
//

import Foundation

protocol Router {
    typealias AnswerCallBack = (String) -> Void
    func routeTo(question: String, answearCallBack: @escaping AnswerCallBack)
}

class Flow {
    private let router: Router
    private let questions: [String]
    
    init(router: Router, questions: [String]) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answearCallBack: routeNext(question: firstQuestion))
        }
    }
    
    private func routeNext(question: String) -> Router.AnswerCallBack {
        return { [weak self] _ in
            guard let strongSelf = self else { return }
            
            if let currentQuestionIndex = strongSelf.questions.firstIndex(of: question) {
                if currentQuestionIndex+1 < strongSelf.questions.count {
                    let nextQuestion = strongSelf.questions[currentQuestionIndex+1]
                    strongSelf.router.routeTo(question: nextQuestion, answearCallBack: strongSelf.routeNext(question: nextQuestion))
                }
            }
        }
    }
}
