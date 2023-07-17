//
//  Flow.swift
//  QuizEssentialDeveloper
//
//  Created by Camelia Braghes on 13.07.2023.
//

import Foundation

protocol Router {
    func routeTo(question: String, answearCallBack: @escaping (String) -> Void)
}

class Flow {
    let router: Router
    let questions: [String]
    
    init(router: Router, questions: [String]) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion) { [weak self] _ in
                guard let strongSelf = self else { return }
                
                let firstQuestionIndex = strongSelf.questions.firstIndex(of: firstQuestion)!
                let nextQuestion = strongSelf.questions[firstQuestionIndex+1]
                
                strongSelf.router.routeTo(question: nextQuestion) { _ in
                }
            }
        }
    }
}
